using System;
using System.Diagnostics;
using System.Collections;
using System.Collections.Generic;
using ASCompletion.Completion;
using CodeRefactor.FRService;
using CodeRefactor.Provider;
using PluginCore.Localization;
using ASCompletion.Model;
using ASCompletion.Context;
using ScintillaNet;
using PluginCore;

namespace CodeRefactor.Commands
{
    /// <summary>
    /// Organizes the imports
    /// </summary>
    public class OrganizeImports : RefactorCommand<IDictionary<String, List<SearchMatch>>>
    {
        /// <summary>
        /// 
        /// </summary>
        protected override void ExecutionImplementation()
        {
            IASContext context = ASContext.Context;
            ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            String eol = ASComplete.GetNewLineMarker(sci.EOLMode);
            List<MemberModel> imports = new List<MemberModel>(context.CurrentModel.Imports.Count);
            imports.AddRange(context.CurrentModel.Imports.Items);
            if (imports.Count > 1)
            {
                Int32 pos = sci.CurrentPos;
                Int32 line = imports[0].LineFrom;
                Int32 indent = sci.GetLineIndentation(line);
                ImportsComparerType comparerType = new ImportsComparerType();
                sci.BeginUndoAction();
                Int32 startLine = imports[0].LineFrom;
                Int32 endLine = imports[imports.Count - 1].LineFrom;
                Int32 startPos = sci.PositionFromLine(startLine);
                Int32 endPos = sci.PositionFromLine(endLine) + sci.LineLength(endLine);
                sci.SetSel(startPos, endPos);
                sci.ReplaceSel("");
                imports.Sort(comparerType);
                imports.Reverse();
                sci.GotoLine(line);
                Int32 curLine = 0;
                MemberModel curItem;
                for (Int32 i = 0; i < imports.Count; i++)
                {
                    curItem = imports[i];
                    curLine = sci.LineFromPosition(sci.CurrentPos);
                    sci.InsertText(sci.CurrentPos, "import " + curItem.Type.ToString() + ";" + eol);
                    sci.SetLineIndentation(curLine, sci.Indent);
                }
                sci.SetSel(pos, pos);
                sci.EndUndoAction();
            }
            this.FireOnRefactorComplete();
        }
        
        /// <summary>
        /// Indicates if the current settings for the refactoring are valid.
        /// </summary>
        public override Boolean IsValid()
        {
            return true;
        }

    }

    /// <summary>
    /// Compare import statements based on import name
    /// </summary>
    class ImportsComparerType : IComparer<MemberModel>
    {
        public int Compare(MemberModel item1, MemberModel item2)
        {
            return new CaseInsensitiveComparer().Compare(item1.Type, item2.Type);
        }
    }

}
