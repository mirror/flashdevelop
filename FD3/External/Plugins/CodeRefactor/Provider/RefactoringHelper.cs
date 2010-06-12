using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using PluginCore.FRService;
using ASCompletion.Completion;
using ASCompletion.Context;
using ASCompletion.Model;
using ScintillaNet;
using PluginCore;

namespace CodeRefactor.Provider
{
    /// <summary>
    /// Central repository of miscellaneous refactoring helper methods to be used by any refactoring command.
    /// </summary>
    public static class RefactoringHelper
    {
        /// <summary>
        /// Populates the m_SearchResults with any found matches
        /// </summary>
        public static IDictionary<String, List<SearchMatch>> GetInitialResultsList(FRResults results)
        {
            IDictionary<String, List<SearchMatch>> searchResults = new Dictionary<String, List<SearchMatch>>();
            if (results == null)
            {
                // I suppose this should never happen -- 
                // normally invoked when the user cancels the FindInFiles dialogue.  
                // but since we're programmatically invoking the FRSearch, I don't think this should happen.
                // TODO: report this?
            }
            else if (results.Count == 0)
            {
                // no search results found.  Again, an interesting issue if this comes up.  
                // we should at least find the source entry the user is trying to change.
                // TODO: report this?
            }
            else
            {
                // found some matches!
                // I current separate the search listing from the FRResults.  It's probably unnecessary but this is just the initial implementation.
                // TODO: test if this is necessary
                foreach (KeyValuePair<String, List<SearchMatch>> entry in results)
                {
                    searchResults.Add(entry.Key, new List<SearchMatch>());
                    foreach (SearchMatch match in entry.Value)
                    {
                        searchResults[entry.Key].Add(match);
                    }
                }
            }
            return searchResults;
        }

        /// <summary>
        /// Retrieves the refactoring target based on the current location.
        /// Note that this will look up to the declaration source.  
        /// This allows users to execute the rename from a reference to the source rather than having to navigate to the source first.
        /// </summary>
        public static ASResult GetDefaultRefactorTarget()
        {
            ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            if (!ASContext.Context.IsFileValid || (sci == null)) return null;
            int position = sci.WordEndPosition(sci.CurrentPos, true);
            return DeclarationLookupResult(sci, position);
        }

        /// <summary>
        /// Checks if a given search match actually points to the given target source
        /// </summary
        /// <returns>True if the SearchMatch does point to the target source.</returns>
        public static ASResult DeclarationLookupResult(ScintillaNet.ScintillaControl Sci, int position)
        {
            if (!ASContext.Context.IsFileValid || (Sci == null)) return null;
            // get type at cursor position
            ASResult result = ASComplete.GetExpressionType(Sci, position);
            // browse to package folder
            if (result.IsPackage && result.inFile != null)
            {
                return null;
            }
            // open source and show declaration
            if (!result.IsNull())
            {
                if (result.Member != null && (result.Member.Flags & FlagType.AutomaticVar) > 0) return null;
                FileModel model = result.inFile ?? ((result.Member != null && result.Member.InFile != null) ? result.Member.InFile : null) ?? ((result.Type != null) ? result.Type.InFile : null);
                if (model == null || model.FileName == "") return null;
                ClassModel inClass = result.inClass ?? result.Type;
                // for Back command
                int lookupLine = Sci.LineFromPosition(Sci.CurrentPos);
                int lookupCol = Sci.CurrentPos - Sci.PositionFromLine(lookupLine);
                ASContext.Panel.SetLastLookupPosition(ASContext.Context.CurrentFile, lookupLine, lookupCol);
                // open the file
                if (model != ASContext.Context.CurrentModel)
                {
                    // cached files declarations have no line numbers
                    if (model.CachedModel && model.Context != null)
                    {
                        ASFileParser.ParseFile(model);
                        if (inClass != null && !inClass.IsVoid())
                        {
                            inClass = model.GetClassByName(inClass.Name);
                            if (result.Member != null) result.Member = inClass.Members.Search(result.Member.Name, 0, 0);
                        }
                        else result.Member = model.Members.Search(result.Member.Name, 0, 0);
                    }
                    if (model.FileName.Length > 0 && File.Exists(model.FileName))
                    {
                        ASContext.MainForm.OpenEditableDocument(model.FileName, false);
                    }
                    else
                    {
                        ASComplete.OpenVirtualFile(model);
                        result.inFile = ASContext.Context.CurrentModel;
                        if (result.inFile == null) return null;
                        if (inClass != null)
                        {
                            inClass = result.inFile.GetClassByName(inClass.Name);
                            if (result.Member != null) result.Member = inClass.Members.Search(result.Member.Name, 0, 0);
                        }
                        else if (result.Member != null)
                        {
                            result.Member = result.inFile.Members.Search(result.Member.Name, 0, 0);
                        }
                    }
                }
                if ((inClass == null || inClass.IsVoid()) && result.Member == null) return null;
                Sci = ASContext.CurSciControl;
                if (Sci == null) return null;
                int line = 0;
                string name = null;
                bool isClass = false;
                // member
                if (result.Member != null && result.Member.LineFrom > 0)
                {
                    line = result.Member.LineFrom;
                    name = result.Member.Name;
                }
                // class declaration
                else if (inClass.LineFrom > 0)
                {
                    line = inClass.LineFrom;
                    name = inClass.Name;
                    isClass = true;
                    // constructor
                    foreach (MemberModel member in inClass.Members)
                    {
                        if ((member.Flags & FlagType.Constructor) > 0)
                        {
                            line = member.LineFrom;
                            name = member.Name;
                            isClass = false;
                            break;
                        }
                    }
                }
                if (line > 0) // select
                {
                    if (isClass) ASComplete.LocateMember("(class|interface)", name, line);
                    else ASComplete.LocateMember("(function|var|const|get|set|property|[,(])", name, line);
                }
                return result;
            }
            return null;
        }

        /// <summary>
        /// Simply checks the given flag combination if they contain a specific flag
        /// </summary>
        public static bool CheckFlag(FlagType flags, FlagType checkForThisFlag)
        {
            return (flags & checkForThisFlag) == checkForThisFlag;
        }

        /// <summary>
        /// Checks if the given match actually is the declaration.
        /// </summary>
        static public bool IsMatchTheTarget(ScintillaNet.ScintillaControl Sci, SearchMatch match, ASResult target)
        {
            if (Sci == null || target == null || target.inFile == null || target.Member == null)
            {
                return false;
            }
            String originalFile = Sci.FileName;
            // get type at match position
            ASResult declaration = DeclarationLookupResult(Sci, Sci.MBSafePosition(match.Index) + Sci.MBSafeTextLength(match.Value));
            return (declaration.inFile != null && originalFile == declaration.inFile.FileName) && (Sci.CurrentPos == (Sci.MBSafePosition(match.Index) + Sci.MBSafeTextLength(match.Value)));
        }

        /// <summary>
        /// Checks if a given search match actually points to the given target source
        /// </summary
        /// <returns>True if the SearchMatch does point to the target source.</returns>
        static public bool DoesMatchPointToTarget(ScintillaNet.ScintillaControl Sci, SearchMatch match, ASResult target, DocumentHelper associatedDocumentHelper)
        {
            if (Sci == null || target == null || target.inFile == null || target.Member == null)
            {
                return false;
            }
            // get type at match position
            ASResult result = DeclarationLookupResult(Sci, Sci.MBSafePosition(match.Index) + Sci.MBSafeTextLength(match.Value));
            if (associatedDocumentHelper != null)
            {
                // because the declaration lookup opens a document, we should register it with the document helper to be closed later
                associatedDocumentHelper.RegisterLoadedDocument(PluginBase.MainForm.CurrentDocument);
            }
            // check if the result matches the target
            // TODO: this method of checking their equality seems pretty crude -- is there a better way?
            if (result == null || result.inFile == null || result.Member == null)
            {
                return false;
            }
            Boolean doesMatch = result.inFile.BasePath == target.inFile.BasePath && result.inFile.FileName == target.inFile.FileName && result.Member.LineFrom == target.Member.LineFrom && result.Member.Name == target.Member.Name;
            return (doesMatch);
        }

        /// <summary>
        /// Finds the given target in all project files.
        /// If the target is a local variable or function parameter, it will only search the associated file.
        /// Note: if running asynchronously, you must supply a listener to "findFinishedHandler" to retrieve the results.
        /// If running synchronously, do not set listeners and instead use the return value.
        /// </summary>
        /// <param name="target">the source member to find references to</param>
        /// <param name="progressReportHandler">event to fire as search results are compiled</param>
        /// <param name="findFinishedHandler">event to fire once searching is finished</param>
        /// <param name="asynchronous">executes in asynchronous mode</param>
        /// <returns>If "asynchronous" is false, will return the search results, otherwise returns null on bad input or if running in asynchronous mode.</returns>
        public static FRResults FindTargetInFiles(ASResult target, FRProgressReportHandler progressReportHandler, FRFinishedHandler findFinishedHandler, Boolean asynchronous)
        {
            Boolean currentFileOnly = false;
            // checks target is a member
            if (target == null || ((target.Member == null || target.Member.Name == null || target.Member.Name == String.Empty) && (target.Type == null || CheckFlag(FlagType.Class, target.Type.Flags))))
            {
                return null;
            }
            else
            {
                // if the target we are trying to rename exists as a local variable or a function parameter we only need to search the current file
                if (target.Member != null && 
                    (RefactoringHelper.CheckFlag(target.Member.Flags, FlagType.LocalVar) 
                     || RefactoringHelper.CheckFlag(target.Member.Flags, FlagType.ParameterVar))
                     || target.Member.Access == Visibility.Private)
                {
                    currentFileOnly = true;
                }
            }
            // sets the FindInFiles settings to the project root, *.as files, and recursive
            String path = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            if (!PluginBase.MainForm.CurrentDocument.FileName.StartsWith(path))
            {
                // This is out of the project, just look for this file...
                currentFileOnly = true;
            }
            String mask = "*.as;*.hx";
            Boolean recursive = true;
            // but if it's only the current file, let's just search that!
            if (currentFileOnly)
            {
                path = Path.GetDirectoryName(PluginBase.MainForm.CurrentDocument.FileName);
                mask = Path.GetFileName(PluginBase.MainForm.CurrentDocument.FileName);
                recursive = false;
            }
            FRConfiguration config = new FRConfiguration(path, mask, recursive, GetFRSearch(target.Member.Name));
            config.CacheDocuments = true;
            FRRunner runner = new FRRunner();
            if (progressReportHandler != null)
            {
                runner.ProgressReport += progressReportHandler;
            }
            if (findFinishedHandler != null)
            {
                runner.Finished += findFinishedHandler;
            }
            if (asynchronous) runner.SearchAsync(config);
            else return runner.SearchSync(config);
            return null;
        }


        /// <summary>
        /// Generates an FRSearch to find all instances of the given member name.
        /// Enables WholeWord and Match Case. No comment/string literal, escape characters, or regex searching.
        /// </summary>
        private static FRSearch GetFRSearch(string memberName)
        {
            String pattern = memberName;
            FRSearch search = new FRSearch(pattern);
            search.IsRegex = false;
            search.IsEscaped = false;
            search.WholeWord = true;
            search.NoCase = false;
            search.Filter = SearchFilter.None | SearchFilter.OutsideCodeComments | SearchFilter.OutsideStringLiterals;
            return search;
        }

        /// <summary>
        /// Replaces matches with the new text.
        /// This was actually taken from PluginCore.FRService.FRSearch.ReplaceAllMatches method without its isEscaped/isRegex checks.
        /// TODO: Consider wrapping an actual FRSearch object somehow?
        /// </summary>
        /// <returns>the "src" text with all matches replaced with "replacement"</returns>
        static public String ReplaceMatches(IList<SearchMatch> matches, String replacement, String src)
        {
            if (matches == null || matches.Count == 0) return src;
            StringBuilder sb = new StringBuilder();
            String original = replacement;
            Int32 lastIndex = 0;
            foreach (SearchMatch match in matches)
            {
                sb.Append(src.Substring(lastIndex, match.Index - lastIndex));
                sb.Append(replacement); // replace text
                lastIndex = match.Index + match.Length;
            }
            sb.Append(src.Substring(lastIndex));
            return sb.ToString();
        }

    }

}
