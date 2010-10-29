using System;
using System.Text;
using System.Text.RegularExpressions;
using ASCompletion.Context;
using ASCompletion.Model;
using PluginCore;
using PluginCore.Helpers;
using ScintillaNet;
using ASCompletion.Completion;

namespace CodeRefactor.Commands
{
    class ExtractMethodCommand
    {
        static private Regex reModifier = new Regex("[a-z \t]*(public |private |protected )", RegexOptions.Compiled);

        private FileModel cFile;
        private string NewName;
        private ScintillaControl Sci;

        public ExtractMethodCommand(string newName)
        {
            this.NewName = newName;
        }

        public void Execute()
        {
            Sci = PluginBase.MainForm.CurrentDocument.SciControl;
            Sci.BeginUndoAction();
            try
            {
                IASContext context = ASContext.Context;

                string selection = Sci.SelText;
                if (selection == null || selection.Length == 0)
                {
                    return;
                }

                if (selection.TrimStart().Length == 0)
                {
                    return;
                }

                Sci.SetSel(Sci.SelectionStart + selection.Length - selection.TrimStart().Length,
                    Sci.SelectionEnd);
                Sci.CurrentPos = Sci.SelectionEnd;

                Int32 pos = Sci.CurrentPos;

                int lineStart = Sci.LineFromPosition(Sci.SelectionStart);
                int lineEnd = Sci.LineFromPosition(Sci.SelectionEnd);
                int firstLineIndent = Sci.GetLineIndentation(lineStart);
                int entryPointIndent = Sci.Indent;

                for (int i = lineStart; i <= lineEnd; i++)
                {
                    int indent = Sci.GetLineIndentation(i);
                    if (i > lineStart)
                    {
                        Sci.SetLineIndentation(i, indent - firstLineIndent + entryPointIndent);
                    }
                }

                string selText = Sci.SelText;
                Sci.ReplaceSel(NewName + "();");

                cFile = ASContext.Context.CurrentModel;
                ASFileParser parser = new ASFileParser();
                parser.ParseSrc(cFile, Sci.Text);

                bool isAs3 = cFile.Context.Settings.LanguageId == "AS3";

                FoundDeclaration found = GetDeclarationAtLine(Sci, lineStart);
                if (found == null || found.member == null)
                {
                    return;
                }

                int position = Sci.PositionFromLine(found.member.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                Sci.SetSel(position, position);

                StringBuilder sb = new StringBuilder();
                sb.Append("$(Boundary)\n\n");
                if ((found.member.Flags & FlagType.Static) > 0)
                {
                    sb.Append("static ");
                }
                sb.Append(ASGenerator.GetPrivateKeyword());
                sb.Append(" function ");
                sb.Append(NewName);
                sb.Append("():");
                sb.Append(isAs3 ? "void " : "Void ");
                sb.Append("$(CSLB){\n\t");
                sb.Append(selText);
                sb.Append("$(EntryPoint)");
                sb.Append("\n}\n$(Boundary)");

                ASGenerator.InsertCode(position, sb.ToString());
            }
            finally
            {
                Sci.EndUndoAction();
            }
        }

        
        private static FoundDeclaration GetDeclarationAtLine(ScintillaNet.ScintillaControl Sci, int line)
        {
            FoundDeclaration result = new FoundDeclaration();
            FileModel model = ASContext.Context.CurrentModel;

            foreach (MemberModel member in model.Members)
            {
                if (member.LineFrom <= line && member.LineTo >= line)
                {
                    result.member = member;
                    return result;
                }
            }

            foreach (ClassModel aClass in model.Classes)
            {
                if (aClass.LineFrom <= line && aClass.LineTo >= line)
                {
                    result.inClass = aClass;
                    foreach (MemberModel member in aClass.Members)
                    {
                        if (member.LineFrom <= line && member.LineTo >= line)
                        {
                            result.member = member;
                            return result;
                        }
                    }
                    return result;
                }
            }
            return result;
        }
    }

    class FoundDeclaration
    {
        public MemberModel member;
        public ClassModel inClass;

        public FoundDeclaration()
        {
            member = null;
            inClass = ClassModel.VoidClass;
        }
    }

}
