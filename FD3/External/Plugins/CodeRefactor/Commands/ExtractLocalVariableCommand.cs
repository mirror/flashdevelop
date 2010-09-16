using System;
using ASCompletion.Context;
using ASCompletion.Model;
using PluginCore;
using PluginCore.Helpers;
using ScintillaNet;
using ASCompletion.Completion;

namespace CodeRefactor.Commands
{
    class ExtractLocalVariableCommand
    {
        private FileModel cFile;
        private string NewName;
        private ScintillaControl Sci;

        public ExtractLocalVariableCommand(string newName)
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
                Int32 pos = Sci.CurrentPos;

                string expression = Sci.SelText.Trim(new char[] { '=', ' ', '\t', '\n', '\r', ';', '.' });
                expression = expression.TrimEnd(new char[] { '(', '[', '{', '<' });
                expression = expression.TrimStart(new char[] { ')', ']', '}', '>' });

                cFile = ASContext.Context.CurrentModel;
                ASFileParser parser = new ASFileParser();
                parser.ParseSrc(cFile, Sci.Text);

                MemberModel current = cFile.Context.CurrentMember;
               
                string characterClass = ScintillaControl.Configuration.GetLanguage(Sci.ConfigurationLanguage).characterclass.Characters;

                int funcBodyStart = ASGenerator.GetBodyStart(current.LineFrom, current.LineTo, Sci);
                Sci.SetSel(funcBodyStart, Sci.LineEndPosition(current.LineTo));
                string currentMethodBody = Sci.SelText;

                bool isExprInSingleQuotes = (expression.StartsWith("'") && expression.EndsWith("'"));
                bool isExprInDoubleQuotes = (expression.StartsWith("\"") && expression.EndsWith("\""));
                int stylemask = (1 << Sci.StyleBits) - 1;
                int lastPos = -1;
                char prevOrNextChar;
                Sci.Colourise(0, -1);
                while (true)
                {
                    lastPos = currentMethodBody.IndexOf(expression, lastPos + 1);
                    if (lastPos > -1)
                    {
                        if (lastPos > 0)
                        {
                            prevOrNextChar = currentMethodBody[lastPos - 1];
                            if (characterClass.IndexOf(prevOrNextChar) > -1)
                            {
                                continue;
                            }
                        }
                        if (lastPos + expression.Length < currentMethodBody.Length)
                        {
                            prevOrNextChar = currentMethodBody[lastPos + expression.Length];
                            if (characterClass.IndexOf(prevOrNextChar) > -1)
                            {
                                continue;
                            }
                        }

                        int style = Sci.StyleAt(funcBodyStart + lastPos) & stylemask;
                        if (ASComplete.IsCommentStyle(style))
                        {
                            continue;
                        }
                        else if ((isExprInDoubleQuotes && currentMethodBody[lastPos] == '"' && currentMethodBody[lastPos + expression.Length - 1] == '"')
                            || (isExprInSingleQuotes && currentMethodBody[lastPos] == '\'' && currentMethodBody[lastPos + expression.Length - 1] == '\''))
                        {
                            
                        }
                        else if (!ASComplete.IsTextStyle(style))
                        {
                            continue;
                        }

                        Sci.SetSel(funcBodyStart + lastPos, funcBodyStart + lastPos + expression.Length);
                        Sci.ReplaceSel(NewName);
                        currentMethodBody = currentMethodBody.Substring(0, lastPos) + NewName + currentMethodBody.Substring(lastPos + expression.Length);
                        lastPos += NewName.Length;
                    }
                    else
                    {
                        break;
                    }
                }

                Sci.CurrentPos = funcBodyStart;
                Sci.SetSel(Sci.CurrentPos, Sci.CurrentPos);

                string snippet = "var " + NewName + ":$(EntryPoint) = " + expression + ";\n$(Boundary)";
                SnippetHelper.InsertSnippetText(Sci, Sci.CurrentPos, snippet);
            }
            finally
            {
                Sci.EndUndoAction();
            }
        }
    }
}
