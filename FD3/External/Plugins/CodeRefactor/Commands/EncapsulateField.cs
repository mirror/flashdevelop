using System;
using System.Collections.Generic;
using ASCompletion.Completion;
using CodeRefactor.FRService;
using CodeRefactor.Provider;
using PluginCore.Localization;
using ASCompletion.Model;
using PluginCore;

namespace CodeRefactor.Commands
{
    /// <summary>
    /// Encapsulates the target field.
    /// If the field stays the same name, it updates all references to it to point to the new getter/setters.
    /// </summary>
    public class EncapsulateField : RefactorCommand<IDictionary<String, List<SearchMatch>>>
    {
        private ASResult targetResult;
        private Boolean outputResults;

        /// <summary>
        /// A new Encapsulation refactoring command.
        /// Outputs found results.
        /// Uses the current text location as the declaration target.
        /// </summary>
        public EncapsulateField() : this(true)
        {
        }

        /// <summary>
        /// A new Encapsulation refactoring command.
        /// Uses the current text location as the declaration target.
        /// </summary>
        /// <param name="output">If true, will send the found results to the trace log and results panel</param>
        public EncapsulateField(Boolean output) : this(RefactoringHelper.GetDefaultRefactorTarget(), output)
        {
        }

        /// <summary>
        /// A new Rename refactoring command.
        /// </summary>
        /// <param name="target">The target declaration to find references to.</param>
        /// <param name="output">If true, will send the found results to the trace log and results panel</param>
        public EncapsulateField(ASResult target, Boolean output)
        {
            this.targetResult = target;
            this.outputResults = output;
        }

        /// <summary>
        /// 
        /// </summary>
        protected override void ExecutionImplementation()
        {
            // gets the new property name that would be used
            String propertyName = GetPropertyNameFor(targetResult.Member);
            // uses the built-in getter/setter generator
            ASGenerator.GenerateJob(GeneratorJobType.GetterSetter, targetResult.Member, targetResult.inClass);
            // if the new property name is non-null and different than the original name, 
            // we need to get all the original references to that field to point to our new getters/setters instead!
            if (propertyName != null && propertyName != targetResult.Member.Name)
            {
                //execute a rename. Skip the user dialog for name input and don't rename the original source field.
                Rename rename = new Rename(targetResult, true, propertyName, true);
                rename.OnRefactorComplete += new EventHandler<RefactorCompleteEventArgs<IDictionary<string, List<SearchMatch>>>>(this.OnRenameCompleted);
                rename.Execute();
            }
            else this.FireOnRefactorComplete();
        }

        /// <summary>
        /// Indicates if the current settings for the refactoring are valid.
        /// </summary>
        public override Boolean IsValid()
        {
            return this.targetResult != null;
        }

        /// <summary>
        /// 
        /// </summary>
        private void OnRenameCompleted(Object sender, RefactorCompleteEventArgs<IDictionary<string, List<SearchMatch>>> eventArgs)
        {
            this.Results = eventArgs.Results;
            this.FireOnRefactorComplete();
        }

        /// <summary>
        /// Taken from ASCompletion.Completion.ASGenerator since it's only private there.
        /// Determines what the property name should be for a given field.
        /// </summary>
        private string GetPropertyNameFor(MemberModel member)
        {
            string name = member.Name;
            if (name.Length < 1) return null;
            int pre = name.IndexOf('_');
            if (pre < 0) pre = name.IndexOf('$');
            int post = name.Length - pre - 1;
            if (pre < 0) return null;
            if (pre > post) return name.Substring(0, pre);
            else return name.Substring(pre + 1);
        }

    }

}
