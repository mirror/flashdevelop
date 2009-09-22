using System;
using System.Collections.Generic;
using ASCompletion.Completion;
using ASCompletion.Model;
using CodeRefactor.FRService;
using CodeRefactor.Provider;
using PluginCore.Localization;


namespace CodeRefactor.Commands
{

    /// <summary>
    /// Encapsulates the target field.
    /// If the field stays the same name, it updates all references to it to point to the new getter/setters.
    /// </summary>
    public class EncapsulateField : RefactorCommand<IDictionary<String, List<SearchMatch>>>
    {
        private ASResult m_Target;
        private Boolean m_OutputResults;

        /// <summary>
        /// A new Encapsulation refactoring command.
        /// Outputs found results.
        /// Uses the current text location as the declaration target.
        /// </summary>
        public EncapsulateField()
            : this(true)
        {
        }

        /// <summary>
        /// A new Encapsulation refactoring command.
        /// Uses the current text location as the declaration target.
        /// </summary>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        public EncapsulateField(Boolean outputResults)
            : this(RefactoringHelper.GetDefaultRefactorTarget(), outputResults)
        {
        }

        /// <summary>
        /// A new Rename refactoring command.
        /// </summary>
        /// <param name="target">The target declaration to find references to.</param>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        public EncapsulateField(ASResult target, Boolean outputResults)
        {
            if (!RefactoringHelper.CheckFlag(target.Member.Flags, FlagType.Variable))
            {
                throw new CodeRefactor.Exceptions.TargetNotValidException(TextHelper.GetString("Info.CanOnlyEncapsulateFields") + " : " + target.Member.Flags);
            }

            this.m_Target = target;
            this.m_OutputResults = outputResults;
        }

        protected override void ExecutionImplementation()
        {

            // gets the new property name that would be used
            string propertyName = GetPropertyNameFor(m_Target.Member);

            // uses the built-in getter/setter generator
            ASGenerator.GenerateJob(GeneratorJobType.GetterSetter, m_Target.Member, m_Target.inClass);

            // TODO: we may need to save the file after placing the getter/setter... I don't like that

            // if the new property name is non-null and different than the original name, 
            // we need to get all the original references to that field to point to our new getters/setters instead!
            if (propertyName != null && propertyName != m_Target.Member.Name)
            {
                //execute a rename.  Skip the user dialogue for name input and don't rename the original source field.
                Rename rename = new Rename(m_Target, true, propertyName, true);
                rename.OnRefactorComplete += new EventHandler<RefactorCompleteEventArgs<IDictionary<string, List<SearchMatch>>>>(this.OnRenameCompleted);
                rename.Execute();
            }
            else
            {
                this.FireOnRefactorComplete();
            }
        }

        /// <summary>
        /// Indicates if the current settings for the refactoring are valid.
        /// </summary>
        public override bool IsValid()
        {
            return this.m_Target != null;
        }

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
            if (name.Length < 1)
                return null;
            int pre = name.IndexOf('_');
            if (pre < 0) pre = name.IndexOf('$');
            int post = name.Length - pre - 1;
            if (pre < 0) return null;
            if (pre > post) return name.Substring(0, pre);
            else return name.Substring(pre + 1);
        }
    }
}
