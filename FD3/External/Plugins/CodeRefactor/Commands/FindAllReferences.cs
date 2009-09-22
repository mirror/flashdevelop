using System;
using System.Collections.Generic;
using ASCompletion.Completion;
using PluginCore;
using PluginCore.Managers;
using CodeRefactor.FRService;
using CodeRefactor.Provider;
using ScintillaNet;
using PluginCore.Localization;

namespace CodeRefactor.Commands
{

    /// <summary>
    /// Finds all references to a given declaration.
    /// </summary>
    public class FindAllReferences : RefactorCommand<IDictionary<String, List<SearchMatch>>>
    {

        #region Fields and Properties

        private ASResult m_CurrentTarget;
        private Boolean m_OutputResults;
        private Boolean m_IgnoreDeclarationSource;

        /// <summary>
        /// The current declaration target that references are being found to.
        /// </summary>
        public ASResult CurrentTarget
        {
            get
            {
                return m_CurrentTarget;
            }
        }

        #endregion

        #region Constructors

        /// <summary>
        /// A new FindAllReferences refactoring command.
        /// Outputs found results.
        /// Uses the current text location as the declaration target.
        /// </summary>
        public FindAllReferences()
            : this(true)
        {
        }

        /// <summary>
        /// A new FindAllReferences refactoring command.
        /// Uses the current text location as the declaration target.
        /// </summary>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        public FindAllReferences(Boolean outputResults)
            : this(RefactoringHelper.GetDefaultRefactorTarget(), outputResults)
        {
            m_OutputResults = outputResults;
        }

        /// <summary>
        /// A new FindAllReferences refactoring command.
        /// </summary>
        /// <param name="target">The target declaration to find references to.</param>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        public FindAllReferences(ASResult target, Boolean outputResults)
            : this(target, outputResults, false)
        {
        }

        public FindAllReferences(ASResult target, Boolean outputResults, Boolean ignoreDeclarationSource)
        {
            m_CurrentTarget = target;
            m_OutputResults = outputResults;
            m_IgnoreDeclarationSource = ignoreDeclarationSource;
        }

        #endregion

        #region RefactorCommand Implementation

        /// <summary>
        /// Entry point to execute finding.
        /// </summary>
        protected override void ExecutionImplementation()
        {
            UserInterfaceManager.FindingReferencesDialogueMain.Show();
            UserInterfaceManager.FindingReferencesDialogueMain.SetTitle(TextHelper.GetString("Info.FindingReferences"));
            UserInterfaceManager.FindingReferencesDialogueMain.UpdateStatusMessage(TextHelper.GetString("Info.SearchingFiles"));
            RefactoringHelper.FindTargetInFiles(m_CurrentTarget, new FRProgressReportHandler(this.RunnerProgress), new FRFinishedHandler(this.FindFinished), true);
        }

        /// <summary>
        /// Indicates if the current settings for the refactoring are valid.
        /// </summary>
        public override bool IsValid()
        {
            return this.m_CurrentTarget != null;
        }
        #endregion

        #region Private Helper Methods

        /// <summary>
        /// Invoked as the FRSearch gathers results.
        /// </summary>
        private void RunnerProgress(Int32 percentDone)
        {
            // perhaps we should show some progress to the user, especially if there are a lot of files to check...
            UserInterfaceManager.FindingReferencesDialogueMain.UpdateProgress(percentDone);
        }

        /// <summary>
        /// Invoked when the FRSearch completes its search
        /// </summary>
        private void FindFinished(FRResults results)
        {

            UserInterfaceManager.FindingReferencesDialogueMain.Reset();
            UserInterfaceManager.FindingReferencesDialogueMain.UpdateStatusMessage(TextHelper.GetString("Info.ResolvingReferences"));

            // First filter out any results that don't actually point to our source declaration
            this.Results = ResolveActualMatches(results, m_CurrentTarget);

            if (this.m_OutputResults)
            {
                // let's report the results!
                this.ReportResults();
            }

            UserInterfaceManager.FindingReferencesDialogueMain.Hide();

            this.FireOnRefactorComplete();
        }

        /// <summary>
        /// Filters the initial result set by determining which entries actually resolve back to our declaration target.
        /// </summary>
        private IDictionary<String, List<SearchMatch>> ResolveActualMatches(FRResults results, ASResult target)
        {
            
            // this will hold actual references back to the source member (some result hits could point to different members with the same name)
            IDictionary<String, List<SearchMatch>> actualMatches = new Dictionary<String, List<SearchMatch>>();


            IDictionary<String, List<SearchMatch>> initialResultsList = RefactoringHelper.GetInitialResultsList(results);

            int matchesChecked = 0;
            int totalMatches = 0;
            foreach (KeyValuePair<String, List<SearchMatch>> entry in initialResultsList)
            {
                totalMatches += entry.Value.Count;
            }

            String projectPath = PluginBase.CurrentProject.ProjectPath;
            if (projectPath == null)
            {
                projectPath = String.Empty;
            }
            else
            {
                projectPath = System.IO.Path.GetDirectoryName(projectPath) + "\\";
            }

            int projectPathLength = projectPath.Length;

            IDictionary<String, Boolean> filesOpenedAndUsed = new Dictionary<String, Boolean>();
            IDictionary<String, WeifenLuo.WinFormsUI.Docking.DockContent> filesOpenedDocumentReferences = new Dictionary<String, WeifenLuo.WinFormsUI.Docking.DockContent>();

            Boolean foundDeclarationSource = false;
            foreach (KeyValuePair<String, List<SearchMatch>> entry in initialResultsList)
            {
                
                string currentFileName = entry.Key;

                UserInterfaceManager.FindingReferencesDialogueMain.UpdateStatusMessage(TextHelper.GetString("Info.ResolvingReferencesIn") + " \"" + (currentFileName.StartsWith(projectPath) ? currentFileName.Substring(projectPathLength) : currentFileName) + "\"");
                
                foreach (SearchMatch match in entry.Value)
                {
                    // we have to open/reopen the entry's file
                    // there are issues with evaluating the declaration targets with non-open, non-current files
                    // we have to do it each time as the process of checking the declaration source can change the currently open file!
                    ScintillaControl sci = this.AssociatedDocumentHelper.LoadDocument(currentFileName);

                    // if the search result does point to the member source, store it
                    if (RefactoringHelper.DoesMatchPointToTarget(sci, match, target, this.AssociatedDocumentHelper))
                    {
                        if (m_IgnoreDeclarationSource && !foundDeclarationSource && RefactoringHelper.IsMatchTheTarget(sci, match, target))
                        {
                            //ignore the declaration source
                            foundDeclarationSource = true;
                        }
                        else
                        {
                            if (!actualMatches.ContainsKey(currentFileName))
                            {
                                actualMatches.Add(currentFileName, new List<SearchMatch>());
                            }
                            actualMatches[currentFileName].Add(match);
                        }
                    }

                    matchesChecked++;
                    UserInterfaceManager.FindingReferencesDialogueMain.UpdateProgress((100 * matchesChecked) / totalMatches);
                }
            }

            this.AssociatedDocumentHelper.CloseTemporarilyOpenedDocuments();

            return actualMatches;
        }

        /// <summary>
        /// Outputs the results to the TraceManager
        /// </summary>
        private void ReportResults()
        {
            FlashDevelop.Globals.MainForm.CallCommand("PluginCommand", "ResultsPanel.ClearResults");
            foreach (KeyValuePair<String, List<SearchMatch>> entry in this.Results)
            {
                // outputs the lines as they change
                foreach (SearchMatch match in entry.Value)
                {
                    Int32 column = match.Column;
                    TraceManager.Add(entry.Key + ":" + match.Line.ToString() + ": characters " + match.Column + "-" + (match.Column + match.Length) + " : " + match.LineText.Trim(), (Int32)TraceType.Info);
                }
            }
            FlashDevelop.Globals.MainForm.CallCommand("PluginCommand", "ResultsPanel.ShowResults");
        }

        #endregion

    }
}
