/*
 * Code completion
 */

using System;
using System.Windows.Forms;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Diagnostics;
using PluginCore;
using PluginCore.Managers;
using PluginCore.Controls;
using ASCompletion.Model;
using ASCompletion.Context;
using System.IO;
using PluginCore.Helpers;

namespace ASCompletion.Completion
{
	/// <summary>
	/// Description of ASComplete.
	/// </summary>
	public class ASComplete
	{
		#region regular_expressions_definitions
		static private readonly RegexOptions ro_csr = ASFileParser.ro_cs | RegexOptions.RightToLeft;
		// refine last expression
		static private readonly Regex re_refineExpression = new Regex("[^\\[\\]{}(:,=+*/%!<>-]*$", ro_csr);
		// code cleaning
		static private readonly Regex re_whiteSpace = new Regex("[\\s]+", ASFileParser.ro_cs);
		// balanced matching, see: http://blogs.msdn.com/bclteam/archive/2005/03/15/396452.aspx
		static private readonly Regex re_balancedParenthesis = new Regex("\\([^()]*(((?<Open>\\()[^()]*)+((?<Close-Open>\\))[^()]*)+)*(?(Open)(?!))\\)", ASFileParser.ro_cs);
		// expressions
		static private readonly Regex re_sub = new Regex("^#(?<index>[0-9]+)~$", ASFileParser.ro_cs);
		#endregion

		#region application_event_handlers
		/// <summary>
		/// Character written in editor
		/// </summary>
		/// <param name="Value">Character inserted</param>
		static public bool OnChar(ScintillaNet.ScintillaControl Sci, int Value, bool autoHide)
		{
            IASContext ctx = ASContext.Context;
			if (ctx.Settings == null || !ctx.Settings.CompletionEnabled) 
                return false;
			try
			{
				int eolMode = Sci.EOLMode;
				// code auto
				if (((Value == 10) && (eolMode != 1)) || ((Value == 13) && (eolMode == 1)))
				{
                    if (ASContext.HasContext && ASContext.Context.IsFileValid) HandleStructureCompletion(Sci);
					return false;
				}

                int position = Sci.CurrentPos;
                if (position < 2) return false;

				// ignore text in comments & quoted text
				Sci.Colourise(0,-1);
				int stylemask = (1 << Sci.StyleBits) -1;
				int style = Sci.StyleAt(position-1) & stylemask;
				if (!IsTextStyle(style) && !IsTextStyle(Sci.StyleAt(position) & stylemask))
				{
					// documentation completion
                    if (ASContext.CommonSettings.SmartTipsEnabled && IsCommentStyle(style))
						return ASDocumentation.OnChar(Sci, Value, position, style);
					else if (autoHide) return false;
				}

				// stop here if the class is not valid
				if (!ASContext.HasContext || !ASContext.Context.IsFileValid) return false;
                ContextFeatures features = ASContext.Context.Features;

				// handle
				switch (Value)
				{
					case '.':
                        if (features.dot == "." || !autoHide) 
                            return HandleDotCompletion(Sci, autoHide);
                        break;

                    case '>':
                        if (features.dot == "->" && Sci.CharAt(position - 2) == '-')
                            return HandleDotCompletion(Sci, autoHide);
                        break;

                    case ' ':
						position--;
						string word = GetWordLeft(Sci, ref position);
                        if (word.Length <= 0)
                        {
                            char c = (char)Sci.CharAt(position);
                            if (c == ':' && features.hasEcmaTyping)
                                return HandleColonCompletion(Sci, "", autoHide);
                            break;
                        }
                        // new/extends/instanceof/...
                        if (features.HasTypePreKey(word))
							return HandleNewCompletion(Sci, "", autoHide, word);
                        // import
                        if (features.hasImports && word == features.importKey)
							return HandleImportCompletion(Sci, "", autoHide);
                        // public/internal/private/protected/static
                        if (word == features.publicKey || word == features.internalKey
                            || word == features.protectedKey || word == features.privateKey
                            || word == features.staticKey || word == features.inlineKey)
                            return HandleDeclarationCompletion(Sci, "", autoHide);
                        // override
                        if (word == features.overrideKey)
                            return ASGenerator.HandleGeneratorCompletion(Sci, autoHide, word);
						break;

					case ':':
                        if (features.hasEcmaTyping)
                        {
                            return HandleColonCompletion(Sci, "", autoHide);
                        }
                        else break;

                    case '<':
                        if (features.hasGenerics && position > 2)
                        {
                            char c0 = (char)Sci.CharAt(position - 2);
                            bool result = false;
                            if (c0 == '.' || Char.IsLetterOrDigit(c0))
                                return HandleColonCompletion(Sci, "", autoHide);
                            return result;
                        }
                        else break;

					case '(':
                    case ',':
                        if (!ASContext.CommonSettings.DisableCallTip)
                            return HandleFunctionCompletion(Sci);
                        else return false;

					case ')':
                        if (UITools.CallTip.CallTipActive) UITools.CallTip.Hide();
						return false;

					case '*':
                        if (features.hasImportsWildcard) return CodeAutoOnChar(Sci, Value);
                        break;

                    case ';':
                        if (!ASContext.CommonSettings.DisableCodeReformat) 
                            ReformatLine(Sci, position);
                        break;

                    default:
                        AutoStartCompletion(Sci, position);
                        break;
				}
			}
			catch (Exception ex) {
				ErrorManager.ShowError(/*"Completion error",*/ ex);
			}

			// CodeAuto context
			if (!PluginCore.Controls.CompletionList.Active) LastExpression = null;
			return false;
		}

		/// <summary>
		/// Handle shortcuts
		/// </summary>
		/// <param name="keys">Test keys</param>
		/// <returns></returns>
		static public bool OnShortcut(Keys keys, ScintillaNet.ScintillaControl Sci)
		{
            // dot complete
			if (keys == (Keys.Control | Keys.Space))
			{
                if (ASContext.HasContext && ASContext.Context.IsFileValid)
				{
					// force dot completion
					OnChar(Sci, '.', false);
					return true;
				}
				else return false;
			}
			// show calltip
			else if (keys == (Keys.Control | Keys.Shift | Keys.Space))
			{
                if (ASContext.HasContext && ASContext.Context.IsFileValid)
				{
					HandleFunctionCompletion(Sci);
					return true;
				}
				else return false;
			}
            // project types completion
            else if (keys == (Keys.Control | Keys.Alt | Keys.Space))
            {
                if (ASContext.HasContext && ASContext.Context.IsFileValid && !ASContext.Context.Settings.LazyClasspathExploration)
                {
                    int position = Sci.CurrentPos-1;
                    string tail = GetWordLeft(Sci, ref position);
                    ContextFeatures features = ASContext.Context.Features;
                    if (tail.IndexOf(features.dot) < 0 && features.HasTypePreKey(tail)) tail = "";
                    // display the full project classes list
                    HandleAllClassesCompletion(Sci, tail, false);
                    return true;
                }
                else return false;
            }
			// hot build
			else if (keys == (Keys.Control | Keys.Enter))
			{
				// project build
                DataEvent de = new DataEvent(EventType.Command, "HotBuild", null);
				EventManager.DispatchEvent(ASContext.Context, de);
				//
				if (!de.Handled)
				{
					// quick build
                    if (!ASContext.Context.BuildCMD(true))
                    {
                        // Flash IDE
                        if (PluginBase.CurrentProject == null)
                        {
                            string idePath = ASContext.CommonSettings.PathToFlashIDE;
                            if (idePath != null && File.Exists(Path.Combine(idePath, "Flash.exe")))
                            {
                                string cmd = Path.Combine("Tools", Path.Combine("flashide", "testmovie.jsfl"));
                                cmd = PathHelper.ResolvePath(cmd);
                                if (cmd != null && File.Exists(cmd))
                                    Commands.CallFlashIDE.Run(idePath, cmd);
                            }
                        }
                    }
				}
				return true;
			}
			// help
            else if (keys == Keys.F1 && ASContext.HasContext && ASContext.Context.IsFileValid)
			{
                ResolveElement(Sci, "ShowDocumentation");
				return true;
			}
            // generators
            else if (keys == ASContext.CommonSettings.ContextualGenerator)
            {
                if (ASContext.HasContext && ASContext.Context.IsFileValid)
                {
                    ASGenerator.ContextualGenerator(Sci);
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// Fire the completion automatically
        /// </summary>
        private static void AutoStartCompletion(ScintillaNet.ScintillaControl Sci, int position)
        {
            if (!CompletionList.Active && ASContext.CommonSettings.AlwaysCompleteWordLength > 0)
            {
                // fire completion if starting to write a word
                bool valid = true;
                int n = ASContext.CommonSettings.AlwaysCompleteWordLength;
                int wordStart = Sci.WordStartPosition(position, true);
                if (position - wordStart != n)
                    return;
                char c = (char)Sci.CharAt(wordStart);
                string characterClass = ScintillaNet.ScintillaControl.Configuration.GetLanguage(Sci.ConfigurationLanguage).characterclass.Characters;
                if (Char.IsDigit(c) || characterClass.IndexOf(c) < 0)
                    return;
                // give a guess to the context (do not complete where it should not)
                if (valid)
                {
                    int pos = wordStart - 1;
                    c = ' ';
                    char c2 = ' ';
                    bool hadWS = false;
                    bool canComplete = false;
                    while (pos > 0)
                    {
                        c = (char)Sci.CharAt(pos--);
                        if (hadWS && characterClass.IndexOf(c) >= 0) break;
                        else if (c == '<' && ((char)Sci.CharAt(pos + 2) == '/' || !hadWS)) break;
                        else if (":;,+-*%!&|<>/{}()[=".IndexOf(c) >= 0)
                        {
                            canComplete = true;
                            // TODO  Add HTML lookup here
                            if (pos > 0)
                            {
                                char c0 = (char)Sci.CharAt(pos);
                                if (c == '/' && c0 == '<') canComplete = false;
                            }
                            break;
                        }
                        else if (c <= 32)
                        {
                            if (c == '\r' || c == '\n')
                            {
                                canComplete = true;
                                break;
                            }
                            else if (pos > 1)
                            {
                                int style = Sci.BaseStyleAt(pos - 1);
                                if (style == 19)
                                {
                                    canComplete = true;
                                    break;
                                }
                            }
                            hadWS = true;
                        }
                        else if (c != '.' && characterClass.IndexOf(c) < 0)
                        {
                            // TODO support custom DOT
                            canComplete = false;
                            break;
                        }
                        c2 = c;
                    }
                    if (canComplete) HandleDotCompletion(Sci, true);
                }
            }
        }
		#endregion

		#region plugin commands
		/// <summary>
		/// Using the text under at cursor position, search and open the object/class/member declaration
		/// </summary>
		/// <param name="Sci">Control</param>
		/// <returns>Declaration was found</returns>
		static public bool DeclarationLookup(ScintillaNet.ScintillaControl Sci)
		{
			if (!ASContext.Context.IsFileValid || (Sci == null)) return false;

			// get type at cursor position
			int position = Sci.WordEndPosition(Sci.CurrentPos, true);
			ASResult result = GetExpressionType(Sci, position);

			// browse to package folder
            if (result.IsPackage && result.inFile != null)
			{
				return ASContext.Context.BrowseTo(result.inFile.Package);
			}

			// open source and show declaration
            if (!result.IsNull())
			{
                if (result.Member != null && (result.Member.Flags & FlagType.AutomaticVar) > 0)
                    return false;

                FileModel model = result.inFile
                    ?? ((result.Member != null && result.Member.InFile != null) ? result.Member.InFile : null)
                    ?? ((result.Type != null) ? result.Type.InFile : null);
                if (model == null || model.FileName == "") return false;
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
                            if (result.Member != null)
                                result.Member = inClass.Members.Search(result.Member.Name, 0, 0);
                        }
                        else result.Member = model.Members.Search(result.Member.Name, 0, 0);
                    }

                    if (model.FileName.Length > 0 && File.Exists(model.FileName))
                        ASContext.MainForm.OpenEditableDocument(model.FileName, false);
                    else
                    {
                        OpenVirtualFile(model);
                        result.inFile = ASContext.Context.CurrentModel;
                        if (result.inFile == null) return false;
                        if (inClass != null)
                        {
                            inClass = result.inFile.GetClassByName(inClass.Name);
                            if (result.Member != null)
                                result.Member = inClass.Members.Search(result.Member.Name, 0, 0);
                        }
                        else if (result.Member != null)
                            result.Member = result.inFile.Members.Search(result.Member.Name, 0, 0);
                    }
                }
                if ((inClass == null || inClass.IsVoid()) && result.Member == null)
                    return false;

				Sci = ASContext.CurSciControl;
				if (Sci == null)
					return false;

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
                        if ((member.Flags & FlagType.Constructor) > 0)
                        {
                            line = member.LineFrom;
                            name = member.Name;
                            isClass = false;
                            break;
                        }
                }
                // select
                if (line > 0)
                {
                    if (isClass)
                        LocateMember("(class|interface)", name, line);
                    else
                        LocateMember("(function|var|const|get|set|property|[,(])", name, line);
                }
                return true;
			}
			return false;
		}

        static public void OpenVirtualFile(FileModel model)
        {
            string dummyFile = Path.Combine(
                Path.GetDirectoryName(model.FileName),
                "[model] " + Path.GetFileName(model.FileName).Replace("$.as", ".as"));
            foreach (ITabbedDocument doc in ASContext.MainForm.Documents)
            {
                if (doc.FileName == dummyFile)
                {
                    doc.Activate();
                    return;
                }
            }
            string src = model.GenerateIntrinsic(false);
            ASContext.MainForm.CreateEditableDocument(dummyFile, src, 65001);
        }

        static public void LocateMember(string keyword, string name, int line)
        {
            try
            {
                ScintillaNet.ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                if (sci == null || line <= 0) return;

                bool found = false;
                string pattern = String.Format("{0}\\s*(?<name>{1})[^A-z0-9]", (keyword ?? ""), name.Replace(".", "\\s*.\\s*"));
                Regex re = new Regex(pattern);
                for (int i = line; i < line + 2; i++)
                    if (i < sci.LineCount)
                    {
                        string text = sci.GetLine(i);
                        Match m = re.Match(text);
                        if (m.Success)
                        {
                            int position = sci.PositionFromLine(i) + sci.MBSafeTextLength(text.Substring(0, m.Groups["name"].Index));
                            sci.EnsureVisible(sci.LineFromPosition(position));
                            sci.SetSel(position, position + m.Groups["name"].Length);
                            found = true;
                            break;
                        }
                    }

                if (!found)
                {
                    sci.EnsureVisible(line);
                    int linePos = sci.PositionFromLine(line);
                    sci.SetSel(linePos, linePos);
                }
                sci.Focus();
            }
            catch { }
        }

		/// <summary>
		/// Using the text under at cursor position, resolve the member/type and call the specified command.
		/// </summary>
		/// <param name="Sci">Control</param>
		/// <returns>Resolved element details</returns>
		static public Hashtable ResolveElement(ScintillaNet.ScintillaControl Sci, string eventAction)
		{
            Hashtable details = new Hashtable();

			// get type at cursor position
            if (Sci == null) return details;
			int position = Sci.WordEndPosition(Sci.CurrentPos, true);
			ASResult result = GetExpressionType(Sci, position);

            // file model
            IASContext context = ASContext.Context;
            if (context.CurrentModel == null) return details;
            ContextFeatures features = context.Features;
            string package = context.CurrentModel.Package;
            details.Add("TypPkg", package);

            ClassModel cClass = context.CurrentClass;
            if (cClass == null) cClass = ClassModel.VoidClass;
            details.Add("TypName", cClass.Name);
            string fullname = (package.Length > 0 ? package + "." : "") + cClass.Name;
            details.Add("TypPkgName", fullname);
            FlagType flags = cClass.Flags;
            string kind = GetKind(flags, features);
            details.Add("TypKind", kind);

            if (context.CurrentMember != null)
            {
                details.Add("MbrName", context.CurrentMember.Name);
                flags = context.CurrentMember.Flags;
                kind = GetKind(flags, features);
                details.Add("MbrKind", kind);

                ClassModel aType = ASContext.Context.ResolveType(context.CurrentMember.Type, context.CurrentModel);
                package = aType.IsVoid() ? "" : aType.InFile.Package;
                details.Add("MbrTypPkg", package);
                details.Add("MbrTypName", aType.Name);
                fullname = (package.Length > 0 ? package + "." : "") + aType.Name;
                details.Add("MbrTypePkgName", fullname);
                flags = aType.Flags;
                kind = GetKind(flags, features);
                details.Add("MbrTypKind", kind);
            }
            else
            {
                details.Add("MbrName", "");
                details.Add("MbrKind", "");
                details.Add("MbrTypPkg", "");
                details.Add("MbrTypName", "");
                details.Add("MbrTypePkgName", "");
                details.Add("MbrTypKind", "");
            }

			// if element can be resolved
            if (!result.IsNull())
            {
                ClassModel oClass = (result.inClass != null) ? result.inClass : result.Type;
                if (oClass.IsVoid())
                    return details;
                if ((result.Type != null) && (result.Type.Flags == FlagType.Package))
                    return details;

                details.Add("ItmFile", oClass.InFile.FileName);

                // type details
                if (oClass != ClassModel.VoidClass)
                {
                    details.Add("ItmTypName", oClass.Name);
                    package = oClass.InFile.Package;
                    details.Add("ItmTypPkg", package);
                    fullname = (package.Length > 0 ? package + "." : "") + oClass.Name;
                    details.Add("ItmTypPkgName", fullname);
                    flags = oClass.Flags;
                    kind = GetKind(flags, features);
                    details.Add("ItmTypKind", kind);
                }
                else
                {
                    details.Add("ItmTypName", oClass.Name);
                    details.Add("ItmTypPkg", "");
                    details.Add("ItmTypPkgName", oClass.Name);
                    details.Add("ItmTypKind", "class");
                }
                // type as path
                details.Add("ItmTypPkgNamePath", (details["ItmTypPkgName"] as string).Replace('.', '\\'));
                details.Add("ItmTypPkgNameURL", (details["ItmTypPkgName"] as string).Replace('.', '/'));

                // element details
                if ((result.Type != null) && (result.Member != null))
                {
                    details.Add("ItmName", result.Member.Name);
                    flags = result.Member.Flags;
                    kind = GetKind(flags, features);
                    details.Add("ItmKind", kind);
                }
                else
                {
                    details.Add("ItmName", oClass.Name);
                    flags = oClass.Flags;
                    kind = GetKind(flags, features);
                    details.Add("ItmKind", kind);
                }

                if (eventAction != null)
                {
                    // other plugins may handle the documentation
                    DataEvent de = new DataEvent(EventType.Command, eventAction, details);
                    EventManager.DispatchEvent(ASContext.Context, de);
                    if (de.Handled) return details;

                    // help
                    if (eventAction == "ShowDocumentation")
                    {
                        string cmd = ASContext.Context.Settings.DocumentationCommandLine;
                        if (cmd == null || cmd.Length == 0) return null;
                        // top-level vars should be searched only if the command includes member information
                        if (result.inClass == ClassModel.VoidClass && cmd.IndexOf("$(Itm") < 0) return null;
                        // complete command
                        ArgumentsProcessor.Process(cmd, details);
                        // call the command
                        try
                        {
                            ASContext.MainForm.CallCommand("RunProcess", cmd);
                        }
                        catch (Exception ex)
                        {
                            ErrorManager.ShowError(ex);
                        }
                    }
                }
            }
            else
            {
                details.Add("ItmFile", "");
                details.Add("ItmName", "");
                details.Add("ItmKind", "");
                details.Add("ItmTypName", "");
                details.Add("ItmTypPkg", "");
                details.Add("ItmTypPkgName", "");
                details.Add("ItmTypKind", "");
                details.Add("ItmTypPkgNamePath", "");
                details.Add("ItmTypPkgNameURL", "");
            }
			return details;
		}

        private static string GetKind(FlagType flags, ContextFeatures features)
        {
            if ((flags & FlagType.Constant) > 0) return features.constKey;
            if ((flags & (FlagType.Getter | FlagType.Setter)) > 0) return features.varKey;
            if ((flags & FlagType.Function) > 0) return features.functionKey;
            if ((flags & FlagType.Interface) > 0) return "interface";
            if ((flags & FlagType.Class) > 0) return "class";
            return "";
        }
		#endregion

		#region structure_completion
		static private void HandleStructureCompletion(ScintillaNet.ScintillaControl Sci)
		{
			try
			{
				int position = Sci.CurrentPos;
				int line = Sci.LineFromPosition(position);
				if (line == 0)
					return;
				string txt = Sci.GetLine(line-1).TrimEnd();
				int style = Sci.BaseStyleAt(position);

				// in comments
                if (PluginBase.Settings.CommentBlockStyle == CommentBlockStyle.Indented && txt.EndsWith("*/"))
                    FixIndentationAfterComments(Sci, line);
                else if (IsCommentStyle(style) && (Sci.BaseStyleAt(position + 1) == style))
                    FormatComments(Sci, txt, line);
                // in code
                else
                {
                    // braces
                    if (!ASContext.CommonSettings.DisableAutoCloseBraces)
                    {
                        if (txt.IndexOf("//") > 0) // remove comment at end of line
                        {
                            int slashes = Sci.MBSafeTextLength(txt.Substring(0, txt.IndexOf("//") + 1));
                            if (Sci.PositionIsOnComment(slashes))
                                txt = txt.Substring(0, txt.IndexOf("//")).Trim();
                        }
                        if (txt.EndsWith("{") && (line > 1)) AutoCloseBrace(Sci, line);
                    }
                    // code reformating
                    if (!ASContext.CommonSettings.DisableCodeReformat)
                        ReformatLine(Sci, Sci.PositionFromLine(line) - 1);
                }
			}
			catch (Exception ex)
			{
				ErrorManager.ShowError(ex);
			}
		}

        private static void ReformatLine(ScintillaNet.ScintillaControl Sci, int position)
        {
            int line = Sci.LineFromPosition(position);
            string txt = Sci.GetLine(line);
            int curPos = Sci.CurrentPos;
            int startPos = Sci.PositionFromLine(line);
            int offset = Sci.MBSafeLengthFromBytes(txt, position - startPos);
            
            ReformatOptions options = new ReformatOptions();
            options.Newline = GetNewLineMarker(Sci.EOLMode);
            options.CondenseWhitespace = ASContext.CommonSettings.CondenseWhitespace;
            options.BraceAfterLine = ASContext.CommonSettings.ReformatBraces 
                && PluginBase.MainForm.Settings.CodingStyle == CodingStyle.BracesAfterLine;
            options.CompactChars = ASContext.CommonSettings.CompactChars;
            options.SpacedChars = ASContext.CommonSettings.SpacedChars;
            options.SpaceBeforeFunctionCall = ASContext.CommonSettings.SpaceBeforeFunctionCall;
            options.AddSpaceAfter = ASContext.CommonSettings.AddSpaceAfter.Split(' ');
            options.isPhp = ASContext.Context.Settings.LanguageId == "PHP";

            int newOffset = offset;
            string replace = Reformater.ReformatLine(txt, options, ref newOffset);

            if (replace != txt)
            {
                position = curPos + newOffset - offset;
                Sci.SetSel(startPos, startPos + Sci.MBSafeTextLength(txt));
                Sci.ReplaceSel(replace);
                Sci.SetSel(position, position);
            }
        }

        /// <summary>
        /// Add closing brace to a code block.
        /// If enabled, move the starting brace to a new line.
        /// </summary>
        /// <param name="Sci"></param>
        /// <param name="txt"></param>
        /// <param name="line"></param>
        private static void AutoCloseBrace(ScintillaNet.ScintillaControl Sci, int line)
        {
            // find matching brace
            int bracePos = Sci.LineEndPosition(line - 1) - 1;
            while ((bracePos > 0) && (Sci.CharAt(bracePos) != '{')) bracePos--;
            if (bracePos == 0 || Sci.BaseStyleAt(bracePos) != 10) return;
            int match = Sci.SafeBraceMatch(bracePos);
            int start = line;
            int indent = Sci.GetLineIndentation(start - 1);
            if (match > 0)
            {
                int endIndent = Sci.GetLineIndentation(Sci.LineFromPosition(match));
                if (endIndent + Sci.TabWidth > indent)
                    return;
            }

            // find where to include the closing brace
            int startIndent = indent;
            int newIndent = indent + Sci.TabWidth;
            int count = Sci.LineCount;
            int lastLine = line;
            line++;
            while (line < count - 1)
            {
                string txt = Sci.GetLine(line).TrimEnd();
                if (txt.Length != 0)
                {
                    indent = Sci.GetLineIndentation(line);
                    if (indent <= startIndent) break;
                    lastLine = line;
                }
                else break;
                line++;
            }
            if (line >= count - 1) lastLine = start;

            // insert closing brace
            int position = Sci.LineEndPosition(lastLine);
            Sci.BeginUndoAction();
            try
            {
                int eolMode = Sci.EOLMode;
                Sci.InsertText(position, GetNewLineMarker(eolMode) + "}");
                Sci.SetLineIndentation(lastLine + 1, startIndent);
            }
            finally
            {
                Sci.EndUndoAction();
            }
        }

        /// <summary>
        /// When javadoc comment blocks have and additional space, 
        /// fix indentation of new line following this block
        /// </summary>
        /// <param name="Sci"></param>
        /// <param name="line"></param>
        private static void FixIndentationAfterComments(ScintillaNet.ScintillaControl Sci, int line)
        {
            int startLine = line - 1;
            while (startLine > 0)
            {
                string txt = Sci.GetLine(startLine).TrimStart();
                if (txt.StartsWith("/*")) break;
                else if (!txt.StartsWith("*")) break;
                startLine--;
            }
            Sci.SetLineIndentation(line, Sci.GetLineIndentation(startLine));
            int position = Sci.LineIndentPosition(line);
            Sci.SetSel(position, position);
        }

        /// <summary>
        /// Add a '*' at the beginning of new lines inside a comment block
        /// </summary>
        /// <param name="Sci"></param>
        /// <param name="txt"></param>
        /// <param name="line"></param>
        private static void FormatComments(ScintillaNet.ScintillaControl Sci, string txt, int line)
        {
            txt = txt.TrimStart();
            if (txt.StartsWith("/*"))
            {
                Sci.ReplaceSel("* ");
                if (PluginBase.Settings.CommentBlockStyle == CommentBlockStyle.Indented)
                    Sci.SetLineIndentation(line, Sci.GetLineIndentation(line) + 1);
                int position = Sci.LineIndentPosition(line) + 2;
                Sci.SetSel(position, position);
            }
            else if (txt.StartsWith("*"))
            {
                Sci.ReplaceSel("* ");
                int position = Sci.LineIndentPosition(line) + 2;
                Sci.SetSel(position, position);
            }
        }
		#endregion

		#region template_completion
		static private bool HandleDeclarationCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide)
		{
			int position = Sci.CurrentPos;
            int line = Sci.LineFromPosition(position);
            if (Sci.CharAt(position - 1) <= 32) tail = "";

            // completion support
            ContextFeatures features = ASContext.Context.Features;
            List<string> support = features.GetDeclarationKeywords(Sci.GetLine(line));
            if (support.Count == 0) return true;
            
            // current model
            FileModel cFile = ASContext.Context.CurrentModel;
            ClassModel cClass = ASContext.Context.CurrentClass;

            // does it need indentation?
            int tab = 0;
            int tempLine = line-1;
            int tempIndent;
            string tempText;
            while(tempLine > 0)
            {
                tempText = Sci.GetLine(tempLine).Trim();
                tempIndent = Sci.GetLineIndentation(tempLine);
                if (tempText.Length > 0 && !tempText.StartsWith("*"))
                {
                    tab = tempIndent;
                    if (tempText.EndsWith("{")) tab += Sci.TabWidth;
                    break;
                } 
                tempLine--;
            }
            if (tab > 0)
            {
                tempIndent = Sci.GetLineIndentation(line);
				Sci.SetLineIndentation(line, tab);
                if (Sci.IsUseTabs) position += (tab - tempIndent) / Sci.TabWidth;
                else position += (tab - tempIndent);
				Sci.SetSel(position, position);
			}

			// build list
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            foreach(string token in support)
			    known.Add(new DeclarationItem(token));

			// show
			CompletionList.Show(known, autoHide, tail);
			return true;
		}
		#endregion

		#region function_completion
		static private string calltipDef;
        static private MemberModel calltipMember;
		static private bool calltipDetails;
		static private int calltipPos = -1;
		static private int calltipOffset;
		static private string prevParam = "";
		static private string paramInfo = "";

		static public bool HasCalltip()
		{
			return UITools.CallTip.CallTipActive && (calltipDef != null);
		}

		/// <summary>
		/// Show highlighted calltip
		/// </summary>
		/// <param name="Sci">Scintilla control</param>
		/// <param name="paramNumber">Highlight param number</param>
		static private void ShowCalltip(ScintillaNet.ScintillaControl Sci, int paramNumber)
		{
			// measure highlighting
			int start = calltipDef.IndexOf('(');
            while ((start >= 0) && (paramNumber-- > 0))
                start = calltipDef.IndexOf(',', start + 1);
            int end = calltipDef.IndexOf(',', start + 1);
            if (end < 0)
                end = calltipDef.IndexOf(')', start + 1);

			// get parameter name
			string paramName = "";
			if (calltipMember.Comments != null && start >= 0 && end > 0)
			{
                paramName = calltipDef.Substring(start + 1, end - start - 1).Trim();
				int p = paramName.IndexOf(':');
                if (p > 0) paramName = paramName.Substring(0, p).TrimEnd();
                if (paramName.Length > 0)
				{
					Match mParam = Regex.Match(calltipMember.Comments, "@param\\s+"+Regex.Escape(paramName)+"[ \t:]+(?<desc>[^\r\n]*)");
					if (mParam.Success)
					{
						paramInfo = "\n[B]"+paramName+":[/B] "+mParam.Groups["desc"].Value.Trim();
					}
					else paramInfo = "";
				}
				else paramInfo = "";
			}

			// show calltip
            if (!UITools.CallTip.CallTipActive || UITools.Manager.ShowDetails != calltipDetails || paramName != prevParam)
			{
				prevParam = paramName;
                calltipDetails = UITools.Manager.ShowDetails;
				string text = calltipDef + ASDocumentation.GetTipDetails(calltipMember, paramName);
                UITools.CallTip.CallTipShow(Sci, calltipPos - calltipOffset, text);
			}

			// highlight
			if ((start < 0) || (end < 0))
			{
				/*UITools.CallTip.Hide();
				calltipDef = null;
				calltipPos = -1;*/
                UITools.CallTip.CallTipSetHlt(0, 0);
			}
            else UITools.CallTip.CallTipSetHlt(start + 1, end);
		}

		/// <summary>
		/// Display method signature
		/// </summary>
		/// <param name="Sci">Scintilla control</param>
		/// <returns>Auto-completion has been handled</returns>
		static public bool HandleFunctionCompletion(ScintillaNet.ScintillaControl Sci)
		{
			// find method
			int position = Sci.CurrentPos-1;
			int parCount = 0;
			int braCount = 0;
			int comaCount = 0;
			int arrCount = 0;
			int style = 0;
			int stylemask = (1 << Sci.StyleBits) -1;
			char c;
			while (position >= 0)
			{
				style = Sci.StyleAt(position) & stylemask;
				if (style == 19)
				{
					string keyword = GetWordLeft(Sci, ref position);
					if (!ASContext.Context.Features.HasTypePreKey(keyword))
					{
						position = -1;
						break;
					}
				}
				if (!IsLiteralStyle(style) && IsTextStyleEx(style))
				{
					c = (char)Sci.CharAt(position);
					if (c == ';')
					{
						position = -1;
						break;
					}
					// skip {} () [] blocks
					if ( ((braCount > 0) && (c != '{'))
					    || ((arrCount > 0) && (c != '['))
					    || ((parCount > 0) && (c != '(')))
					{
						position--;
						continue;
					}
					// new block
					if (c == '}') braCount++;
					else if (c == ']') arrCount++;
					else if (c == ')') parCount++;

					// block closed
					else if (c == '{')
					{
						if (braCount == 0) comaCount = 0;
						else braCount--;
					}
					else if (c == '[')
					{
						if (arrCount == 0) comaCount = 0;
						else arrCount--;
					}
					else if (c == '(')
					{
						if (--parCount < 0)
							// function start found
							break;
					}

					// new parameter reached
					else if ((c == ',') && (parCount == 0))
						comaCount++;
				}
				position--;
			}
			// continuing calltip ?
			if (HasCalltip())
			{
				if (calltipPos == position)
				{
					ShowCalltip(Sci, comaCount);
					return true;
				}
                else UITools.CallTip.Hide();
			}
			else if (position < 0)
				return false;

			// get expression at cursor position
			ASExpr expr = GetExpression(Sci, position, true);
			if (expr.Value == null || expr.Value.Length == 0
			    || (expr.WordBefore == "function" && expr.Separator == ' '))
				return false;
			// Context
            expr.LocalVars = ParseLocalVars(expr);
            FileModel aFile = ASContext.Context.CurrentModel;
			ClassModel aClass = ASContext.Context.CurrentClass;
			// Expression before cursor
            ASResult result = EvalExpression(expr.Value, expr, aFile, aClass, true, true);

			// Show calltip
			if (!result.IsNull())
			{
				MemberModel method = result.Member;
                if (method == null)
				{
                    if (result.Type == null) 
                        return true;
					string constructor = ASContext.GetLastStringToken(result.Type.Name,".");
					result.Member = method = result.Type.Members.Search(constructor, FlagType.Constructor, 0);
					if (method == null)
						return true;
				}
                else if ((method.Flags & FlagType.Function) == 0)
                {
                    if (method.Name == "super" && result.Type != null)
                    {
                        result.Member = method = result.Type.Members.Search(result.Type.Constructor, FlagType.Constructor, 0);
                        if (method == null)
                            return true;
                    }
                    else return true;
                }

                // inherit doc
                while ((method.Flags & FlagType.Override) > 0 && result.inClass != null
                    && (method.Comments == null || method.Comments.Trim() == ""))
                {
                    FindMember(method.Name, result.inClass.Extends, result, 0, 0);
                    method = result.Member;
                    if (method == null) 
                        return true;
                }
                if ((method.Comments == null || method.Comments.Trim() == "")
                    && result.inClass != null && result.inClass.Implements != null)
                {
                    ASResult iResult = new ASResult();
                    foreach (string type in result.inClass.Implements)
                    {
                        ClassModel model = ASContext.Context.ResolveType(type, result.inFile);
                        FindMember(method.Name, model, iResult, 0, 0);
                        if (iResult.Member != null)
                        {
                            result = iResult;
                            method = iResult.Member;
                            break;
                        }
                    }
                }

                // calltip content
				calltipPos = position;
				calltipOffset = method.Name.Length;
                calltipDef = method.ToString();
				calltipMember = method;
                calltipDetails = UITools.Manager.ShowDetails;
				// show
				prevParam = "";
				ShowCalltip(Sci, comaCount);
			}
			return true;
		}
		#endregion

		#region dot_completion
		/// <summary>
		/// Complete object member
		/// </summary>
		/// <param name="Sci">Scintilla control</param>
		/// <param name="autoHide">Don't keep the list open if the word does not match</param>
		/// <returns>Auto-completion has been handled</returns>
		static private bool HandleDotCompletion(ScintillaNet.ScintillaControl Sci, bool autoHide)
		{
			// get expression at cursor position
			int position = Sci.CurrentPos;
			ASExpr expr = GetExpression(Sci, position);
			if (expr.Value == null)
				return true;
            ContextFeatures features = ASContext.Context.Features;
            int dotIndex = expr.Value.LastIndexOf(features.dot);
			if (dotIndex == 0) return true;

			// complete keyword
            if (expr.WordBefore != null &&
                (expr.WordBefore == features.varKey || expr.WordBefore == features.functionKey || expr.WordBefore == features.constKey))
                return false;
			if (dotIndex < 0)
			{
                string word = expr.WordBefore;
                // new/extends/implements
                if (features.HasTypePreKey(word))
                    return HandleNewCompletion(Sci, expr.Value, autoHide, word);
                // type
				if (features.hasEcmaTyping && expr.Separator == ':' 
                    && HandleColonCompletion(Sci, expr.Value, autoHide)) 
                    return true;
                // import
				if (features.hasImports && word == features.importKey)
					return HandleImportCompletion(Sci, expr.Value, autoHide);
                // no completion
                if ((expr.BeforeBody && expr.Separator != '=') 
                    || expr.coma == ComaExpression.AnonymousObject 
                    || expr.coma == ComaExpression.FunctionDeclaration)
                    return false;

                // complete declaration
                MemberModel cMember = ASContext.Context.CurrentMember;
                int line = Sci.LineFromPosition(position);
                if (cMember == null)
                {
                    if (ASContext.Context.CurrentModel.Version >= 2) 
                        return HandleDeclarationCompletion(Sci, expr.Value, autoHide);
                }
                else if (line == cMember.LineFrom)
                {
                    string text = Sci.GetLine(line);
                    int p = text.IndexOf(cMember.Name);
                    if (p < 0 || position < Sci.PositionFromLine(line) + p)
                        return HandleDeclarationCompletion(Sci, expr.Value, autoHide);
                }
			}

            // current model
            bool outOfDate = (expr.Separator == ':') ? ASContext.Context.UnsetOutOfDate() : false;
            FileModel cFile = ASContext.Context.CurrentModel;
            ClassModel cClass = ASContext.Context.CurrentClass;

			// Context
			expr.LocalVars = ParseLocalVars(expr);
			ASResult result;
			ClassModel tmpClass;
			if (dotIndex > 0)
			{
				// Expression before cursor
                result = EvalExpression(expr.Value, expr, cFile, cClass, false, false);
                if (result.IsNull())
                {
                    if (outOfDate) ASContext.Context.SetOutOfDate();
                    return true;
                }
                if (autoHide && features.hasE4X && IsXmlType(result.Type))
                    return true;
                tmpClass = result.Type;
			}
			else
			{
				result = new ASResult();
				tmpClass = cClass;
			}
			MemberList mix = new MemberList();
			// local vars are the first thing to try
			if ((result.IsNull() || (dotIndex < 0)) && expr.ContextFunction != null)
				mix.Merge(expr.LocalVars);

			// TODO merge sub classes
			//if (tmpClass.InFile.TryAsPackage != null)

			// get all members
			FlagType mask = 0;
            // members visibility
            IASContext ctx = ASContext.Context;
            ClassModel curClass = cClass;
            curClass.ResolveExtends();
            Visibility acc = ctx.TypesAffinity(curClass, tmpClass);

            // list package elements
            if (result.IsPackage)
            {
                mix.Merge(result.inFile.Imports);
                mix.Merge(result.inFile.Members);
            }
            // list instance members
			else if (expr.ContextFunction != null || expr.Separator != ':' || (dotIndex > 0 && !result.IsNull()))
			{
				// user setting may ask to hide some members
                bool limitMembers = autoHide; // ASContext.Context.HideIntrinsicMembers || (autoHide && !ASContext.Context.AlwaysShowIntrinsicMembers);

                // static or instance members?
                if (!result.IsNull())
                    mask = (result.IsStatic) ? FlagType.Static : FlagType.Dynamic;

				// explore members
                tmpClass.ResolveExtends();
                if (!limitMembers || result.IsStatic || tmpClass.Name != features.objectKey)
				while (tmpClass != null && !tmpClass.IsVoid())
				{
                    mix.Merge(tmpClass.GetSortedMembersList(), mask, acc);
                    if ((mask & FlagType.Static) > 0 && tmpClass.InFile.Version != 2) break; // only AS2 inherit static members

                    tmpClass = tmpClass.Extends;
                    // hide Object class members
                    if (limitMembers && tmpClass != null && tmpClass.InFile.Package == "" && tmpClass.Name == features.objectKey) 
                        break;
                    // members visibility
                    acc = ctx.TypesAffinity(curClass, tmpClass);
                }
			}
			// known classes / toplevel vars/methods
			if (result.IsNull() || (dotIndex < 0))
			{
                mix.Merge(cFile.GetSortedMembersList());
                mix.Merge(ctx.GetVisibleExternalElements(false));
                MemberList decl = new MemberList();
                foreach (string key in features.codeKeywords)
                    decl.Add(new MemberModel(key, key, FlagType.Template, 0));
                decl.Sort();
                mix.Merge(decl);
            }

			// show
            List<ICompletionListItem> list = new List<ICompletionListItem>();
			foreach(MemberModel member in mix)
                list.Add(new MemberItem(member));
            string tail = (dotIndex >= 0) ? expr.Value.Substring(dotIndex + features.dot.Length) : expr.Value;
			CompletionList.Show(list, autoHide, tail);
            if (outOfDate) ctx.SetOutOfDate();
			return true;
		}

		#endregion

		#region types_completion

        static private void SelectTypedNewMember(ScintillaNet.ScintillaControl sci)
        {
            ASExpr expr = GetExpression(sci, sci.CurrentPos);
            if (expr.Value == null) return;
            // try local var
            expr.LocalVars = ParseLocalVars(expr);
            foreach (MemberModel localVar in expr.LocalVars)
            {
                if (localVar.LineTo == ASContext.Context.CurrentLine)
                {
                    CompletionList.SelectItem(localVar.Type);
                    return;
                }
            }
            // try member
            string currentLine = sci.GetLine(sci.LineFromPosition(sci.CurrentPos));
            Match mVarNew = Regex.Match(currentLine, "\\s*(?<name>[a-z_$][a-z_$0-9]*)\\s*=\\s*new\\s", RegexOptions.IgnoreCase);
            if (mVarNew.Success)
            {
                ASResult result = EvalVariable(mVarNew.Groups["name"].Value, expr, ASContext.Context.CurrentModel, ASContext.Context.CurrentClass);
                if (result.Member != null)
                    CompletionList.SelectItem(result.Member.Type);
            }
        }

		static private bool HandleNewCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide, string keyword)
		{
            if (!ASContext.Context.Settings.LazyClasspathExploration
                && ASContext.Context.Settings.CompletionListAllTypes)
            {
                // show all project classes
                HandleAllClassesCompletion(Sci, tail, true);
                SelectTypedNewMember(Sci);
                return true;
            }

			// Context
			ClassModel cClass = ASContext.Context.CurrentClass;

			// Consolidate known classes
			MemberList known = new MemberList();
            known.Merge(ASContext.Context.GetVisibleExternalElements(true));
            // show
            List<ICompletionListItem> list = new List<ICompletionListItem>();
			foreach(MemberModel member in known)
				list.Add(new MemberItem(new MemberModel(member.Type, member.Type, member.Flags, member.Access)));
			CompletionList.Show(list, autoHide, tail);
			return true;
		}

		static private bool HandleImportCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide)
		{
            if (!ASContext.Context.Features.hasImports) return false;

            if (!ASContext.Context.Settings.LazyClasspathExploration
                && ASContext.Context.Settings.CompletionListAllTypes)
            {
                // show all project classes
                HandleAllClassesCompletion(Sci, "", false);
            }
            else
            {
                // list visible classes
                MemberList known = new MemberList();
                ClassModel cClass = ASContext.Context.CurrentClass;
                known.Merge(ASContext.Context.GetVisibleExternalElements(true));

                // show
                List<ICompletionListItem> list = new List<ICompletionListItem>();
                foreach (MemberModel member in known)
                    list.Add(new MemberItem(member));
                CompletionList.Show(list, autoHide, tail);
            }
			return true;
		}

		static private bool HandleColonCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide)
		{
            ComaExpression coma = ComaExpression.None;
			int position = Sci.CurrentPos - 1;
            char c = ' ';
            //bool inGenericType = false;
            while (position > 0)
            {
                c = (char)Sci.CharAt(position);
                //if (c == '<') inGenericType = true;
                if (c == ':' || c == ';' || c == '=' || c == ',') break;
                position--;
            }
            position--;

            // var declaration
            GetWordLeft(Sci, ref position);
            string keyword = (c == ':') ? GetWordLeft(Sci, ref position) : null;
            if (keyword == ASContext.Context.Features.varKey || keyword == ASContext.Context.Features.constKey)
                coma = ComaExpression.VarDeclaration;
            // function return type
            else if ((char)Sci.CharAt(position) == ')')
            {
                int parCount = 0;
                while (position > 0)
                {
                    position--;
                    c = (char)Sci.CharAt(position);
                    if (c == ')') parCount++;
                    else if (c == '(')
                    {
                        parCount--;
                        if (parCount < 0)
                        {
                            position--;
                            break;
                        }
                    }
                }
                keyword = GetWordLeft(Sci, ref position);
                ContextFeatures features = ASContext.Context.Features;
                if (keyword == features.functionKey)
                    coma = ComaExpression.FunctionDeclaration;
                else
                {
                    keyword = GetWordLeft(Sci, ref position);
                    if (keyword == features.functionKey || keyword == features.getKey || keyword == features.setKey)
                        coma = ComaExpression.FunctionDeclaration;
                }
            }
            // function declaration
            else coma = DisambiguateComa(Sci, position, 0);

            if (coma != ComaExpression.FunctionDeclaration && coma != ComaExpression.VarDeclaration)
                return false;

            if (!ASContext.Context.Settings.LazyClasspathExploration
                && ASContext.Context.Settings.CompletionListAllTypes)
            {
                // show all project classes
                HandleAllClassesCompletion(Sci, tail, true);
            }
            else
            {
                bool outOfDate = ASContext.Context.UnsetOutOfDate();

                // list visible classes
                MemberList known = new MemberList();
                ClassModel cClass = ASContext.Context.CurrentClass;
                known.Merge(ASContext.Context.GetVisibleExternalElements(true));

                // show
                List<ICompletionListItem> list = new List<ICompletionListItem>();
                foreach (MemberModel member in known)
                    list.Add(new MemberItem(member));
                CompletionList.Show(list, autoHide, tail);
                if (outOfDate) ASContext.Context.SetOutOfDate();
            }
            return true;
		}

        /// <summary>
        /// Display the full project classes list
        /// </summary>
        /// <param name="Sci"></param>
        static private void HandleAllClassesCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool classesOnly)
        {
            MemberList known = ASContext.Context.GetAllProjectClasses();
            if (known.Count == 0) return;
            
            List<ICompletionListItem> list = new List<ICompletionListItem>();
            string prev = null;
            FlagType mask = (classesOnly) ? FlagType.Class | FlagType.Interface : (FlagType)uint.MaxValue;
            foreach (MemberModel member in known)
            {
                if ((member.Flags & mask) == 0 || prev == member.Name) continue;
                prev = member.Name;
                list.Add(new MemberItem(member));
            }
            CompletionList.Show(list, false, tail);
        }
		#endregion

		#region expression_evaluator
		/// <summary>
		/// Find expression type in function context
		/// </summary>
		/// <param name="expression">To evaluate</param>
        /// <param name="context">Completion context</param>
        /// <param name="inFile">File context</param>
		/// <param name="inClass">Class context</param>
		/// <param name="complete">Complete (sub-expression) or partial (dot-completion) evaluation</param>
		/// <returns>Class/member struct</returns>
        static private ASResult EvalExpression(string expression, ASExpr context, FileModel inFile, ClassModel inClass, bool complete, bool asFunction)
		{
			ASResult notFound = new ASResult();
            if (expression == null || expression.Length == 0)
                return notFound;

            ContextFeatures features = ASContext.Context.Features;
            if (expression.StartsWith(features.dot))
            {
                if (expression.StartsWith(features.dot + "#")) expression = expression.Substring(1);
                else return notFound;
            }

			string[] tokens = Regex.Split(expression, Regex.Escape(features.dot));

			// eval first token
			string token = tokens[0];
            if (asFunction && tokens.Length == 1) token += "(";

			ASResult head;
            if (token.Length == 0) 
                return notFound;
            else if (token.StartsWith("#"))
			{
				Match mSub = re_sub.Match(token);
				if (mSub.Success)
				{
					string subExpr = context.SubExpressions[ Convert.ToInt16(mSub.Groups["index"].Value) ];
					// parse sub expression
					subExpr = subExpr.Substring(1,subExpr.Length-2).Trim();
                    ASExpr subContext = new ASExpr(context);
					subContext.SubExpressions = ExtractedSubex = new List<string>();
					subExpr = re_balancedParenthesis.Replace(subExpr, new MatchEvaluator(ExtractSubex));
					Match m = re_refineExpression.Match(subExpr);
					if (!m.Success) return notFound;
                    Regex re_dot = new Regex("[\\s]*" + Regex.Escape(features.dot) + "[\\s]*");
					subExpr = re_dot.Replace( re_whiteSpace.Replace(m.Value, " ") , features.dot).Trim();
					int space = subExpr.LastIndexOf(' ');
                    if (space > 0)
                    {
                        string trash = subExpr.Substring(0, space).TrimEnd();
                        subExpr = subExpr.Substring(space + 1);
                        if (trash.EndsWith("as")) subExpr += features.dot + "#";
                    }
					// eval sub expression
					head = EvalExpression(subExpr, subContext, inFile, inClass, true, false);
					if (head.Member != null)
						head.Type = ASContext.Context.ResolveType(head.Member.Type, head.Type.InFile);
				}
				else
				{
					token = token.Substring(token.IndexOf('~')+1);
					head = EvalVariable(token, context, inFile, inClass);
				}
			}
			else head = EvalVariable(token, context, inFile, inClass);

			// no head, exit
			if (head.IsNull()) return notFound;

			// eval tail
			int n = tokens.Length;
			if (!complete) n--;
			// context
			ASResult step = head;
			ClassModel resultClass = head.Type;
			// look for static or dynamic members?
			FlagType mask = (head.IsStatic) ? FlagType.Static : FlagType.Dynamic;
            // members visibility
            IASContext ctx = ASContext.Context;
			ClassModel curClass = ctx.CurrentClass;
            curClass.ResolveExtends();
            Visibility acc = ctx.TypesAffinity(curClass, step.Type);

			// explore
            bool inE4X = false;
			for (int i=1; i<n; i++)
			{
                token = tokens[i];
                if (token.Length == 0)
                {
                    // this means 2 dots in the expression: consider as E4X expression
                    if (ctx.Features.hasE4X && IsXmlType(step.Type) && i < n - 1)
                    {
                        inE4X = true;
                        step = new ASResult();
                        step.Member = new MemberModel(token, "XMLList", FlagType.Variable | FlagType.Dynamic | FlagType.AutomaticVar, Visibility.Public);
                        step.Type = ctx.ResolveType(ctx.Features.objectKey, null);
                        acc = Visibility.Public;
                    }
                    else return notFound;
                }
                else if (step.IsPackage)
                {
                    FindMember(token, inFile, step, mask, acc);
                    if (step.IsNull())
                        return step;
                }
                else if (step.Type != null)
                {
                    resultClass = step.Type;
                    // handle typed indexes automatic typing
                    if (token[0] == '#' && step.inClass != null && step.Member != null
                        && step.inClass.IndexType == step.Member.Type)
                    {
                        step.inFile = step.inClass.InFile;
                    }
                    FindMember(token, resultClass, step, mask, acc);
                    // handle E4X expressions
                    if (step.Type == null)
                    {
                        if (inE4X || (ctx.Features.hasE4X && IsXmlType(resultClass)))
                        {
                            inE4X = false;
                            step = new ASResult();
                            step.Member = new MemberModel(token, "XMLList", FlagType.Variable | FlagType.Dynamic | FlagType.AutomaticVar, Visibility.Public);
                            step.Type = ctx.ResolveType("XMLList", null);
                        }
                        else return step;
                        // members visibility
                        acc = ctx.TypesAffinity(curClass, step.Type);
                    }
                    else inE4X = false;

                    if (!step.IsStatic)
                    {
                        if ((mask & FlagType.Static) > 0)
                        {
                            mask -= FlagType.Static;
                            mask |= FlagType.Dynamic;
                        }
                    }
                }
			}
			return step;
		}

		/// <summary>
		/// Find variable type in function context
		/// </summary>
		/// <param name="token">Variable name</param>
        /// <param name="context">Completion context</param>
        /// <param name="inFile">File context</param>
		/// <param name="inClass">Class context</param>
		/// <returns>Class/member struct</returns>
		static private ASResult EvalVariable(string token, ASExpr local, FileModel inFile, ClassModel inClass)
		{
			ASResult result = new ASResult();
            IASContext context = ASContext.Context;

            int p = token.IndexOf('(');
            if (p > 0) token = token.Substring(0, p);

            // local vars
			if (local.LocalVars != null)
			foreach(MemberModel var in local.LocalVars)
			{
				if (var.Name == token)
				{
                    result.inFile = inFile;
					result.inClass = inClass;
                    result.Type = context.ResolveType(var.Type, inClass.InFile);
					result.Member = var;
					return result;
				}
			}

			// method parameters
            if (local.ContextFunction != null && local.ContextFunction.Parameters != null)
			{
                foreach(MemberModel para in local.ContextFunction.Parameters)
                if (para.Name == token || (para.Name[0] == '?' && para.Name.Substring(1) == token))
                {
                    result.Member = para;
                    result.Type = context.ResolveType(para.Type, inClass.InFile);
                    return result;
                }
			}

			// class members
            if (!inClass.IsVoid())
            {
                FindMember(token, inClass, result, 0, 0);
                if (!result.IsNull())
                    return result;
            }
            if (inFile.Version != 2 || inClass.IsVoid())
            {
                // file member
                FindMember(token, inFile, result, 0, 0);
                if (!result.IsNull())
                    return result;
            }

			// current file types
            foreach(ClassModel aClass in inFile.Classes)
                if (aClass.Name == token)
                {
                    result.Type = aClass;
                    result.IsStatic = (p < 0);
                    return result;
                }

			// types & imports
            MemberList imports = context.ResolveImports(inFile);
            foreach (MemberModel item in imports)
                if (item.Name == token)
                {
                    if ((item.Flags & FlagType.Class) > 0)
                    {
                        result.Type = context.ResolveType(item.Type, null);
                        result.IsStatic = (p < 0);
                        return result;
                    }
                    else
                    {
                        result.Member = item;
                        result.Type = (p < 0 && (item.Flags & FlagType.Function) > 0) 
                            ? context.ResolveType("Function", null) 
                            : context.ResolveType(item.Type, item.InFile);
                        return result;
                    }
                }
            imports = null;

            // package-level types
            if (context.Features.hasPackages && inFile.Package.Length > 0)
            {
                ClassModel friendClass = context.GetModel(inFile.Package, token, inFile.Package);
                if (!friendClass.IsVoid())
                {
                    result.Type = friendClass;
                    result.IsStatic = (p < 0);
                    return result;
                }
            }

            // toplevel types
            ClassModel topClass = context.ResolveType(token, null);
            if (!topClass.IsVoid())
            {
                result.Type = topClass;
                if (p > 0)
                {
                    if (topClass.Constructor != null)
                    {
                        FindMember(topClass.Constructor, topClass, result, 0, 0);
                        if (!result.IsNull()) return result;
                        else
                        {
                            result.Member = null;
                            result.Type = topClass;
                        }
                    }
                    return result;
                }
                else result.IsStatic = true;
            }

            // top-level elements resolution
            context.ResolveTopLevelElement(token, result);
            if (!result.IsNull())
            {
                if (result.Member != null && (result.Member.Flags & FlagType.Function) > 0 && p < 0)
                    result.Type = context.ResolveType("Function", null);
                return result;
            }

            // packages folders
            FileModel package = context.ResolvePackage(token, false);
			if (package != null)
			{
                result.inFile = package;
                result.IsPackage = true;
                result.IsStatic = true;
			}
			return result;
		}

        /// <summary>
        /// Find package-level member
        /// </summary>
        /// <param name="token">To match</param>
        /// <param name="inFile">In given file</param>
        /// <param name="result">Class/Member struct</param>
        /// <param name="mask">Flags mask</param>
        /// <param name="acc">Visibility mask</param>
        static public void FindMember(string token, FileModel inFile, ASResult result, FlagType mask, Visibility acc)
        {
            // package
            if (result.IsPackage)
            {
                string fullName = (result.inFile.Package.Length > 0) ? result.inFile.Package + "." + token : token;
                foreach (MemberModel mPack in result.inFile.Imports)
                {
                    if (mPack.Name == token)
                    {
                        // sub-package
                        if (mPack.Flags == FlagType.Package)
                        {
                            FileModel package = ASContext.Context.ResolvePackage(fullName, false);
                            if (package != null) result.inFile = package;
                            else
                            {
                                result.IsPackage = false;
                                result.inFile = null;
                            }
                        }
                        // class
                        else
                        {
                            result.IsPackage = false;
                            result.Type = ASContext.Context.ResolveType(fullName, ASContext.Context.CurrentModel);
                            result.inFile = result.Type.InFile;
                        }
                        return;
                    }
                }
                foreach (MemberModel member in result.inFile.Members)
                {
                    if (member.Name == token)
                    {
                        result.inClass = ClassModel.VoidClass;
                        result.inFile = member.InFile ?? inFile;
                        result.Member = member;
                        result.Type = ASContext.Context.ResolveType(member.Type, inFile);
                        result.IsStatic = false;
                        result.IsPackage = false;
                        return;
                    }
                }
                // dead end
                result.IsPackage = false;
                result.Type = null;
                result.Member = null;
                return;
            }

            MemberModel found;
            // variable
            found = inFile.Members.Search(token, mask, acc);
            // ignore setters
            if (found != null && (found.Flags & FlagType.Setter) > 0)
            {
                found = null;
                MemberList matches = inFile.Members.MultipleSearch(token, mask, acc);
                foreach (MemberModel member in matches)
                {
                    found = member;
                    if ((member.Flags & FlagType.Setter) == 0) break;
                }
            }
            if (found != null)
            {
                result.inClass = ClassModel.VoidClass;
                result.inFile = inFile;
                result.Member = found;
                result.Type = ASContext.Context.ResolveType(found.Type, inFile);
                result.IsStatic = false;
                return;
            }
        }

		/// <summary>
		/// Match token to a class' member
		/// </summary>
		/// <param name="token">To match</param>
		/// <param name="inClass">In given class</param>
		/// <param name="result">Class/Member struct</param>
        /// <param name="mask">Flags mask</param>
        /// <param name="acc">Visibility mask</param>
        static public void FindMember(string token, ClassModel inClass, ASResult result, FlagType mask, Visibility acc)
		{
            if (token.Length == 0)
                return;

			MemberModel found = null;
			ClassModel tmpClass = inClass;
            if (inClass == null)
            {
                if (result.inFile != null) FindMember(token, result.inFile, result, mask, acc);
                return;
            }
            // previous member accessed as an array
            if (token == "[]")
            {
                result.IsStatic = false;
                if (result.Type == null || result.Type.IndexType == null)
                {
                    result.Member = null;
                    result.inFile = null;
                    result.Type = ASContext.Context.ResolveType(ASContext.Context.Features.objectKey, null);
                }
                else
                {
                    result.Type = ASContext.Context.ResolveType(result.Type.IndexType, result.inFile);
                }
                return;
            }
            // previous member called as a method
			else if (token[0] == '#')
            {
                result.IsStatic = false;
                if (result.Member != null)
                {
                    if ((result.Member.Flags & FlagType.Constructor) > 0)
                        result.Type = inClass;
                    else
                        result.Type = ASContext.Context.ResolveType(result.Member.Type, result.inFile);
                }
                return;
            }
			// variable
			else if (tmpClass != null)
            {
                // member
                tmpClass.ResolveExtends();
                while (!tmpClass.IsVoid())
                {
                    found = tmpClass.Members.Search(token, mask, acc);
                    // ignore setters
                    if (found != null && (found.Flags & FlagType.Setter) > 0)
                    {
                        found = null;
                        MemberList matches = tmpClass.Members.MultipleSearch(token, mask, acc);
                        foreach (MemberModel member in matches)
                        {
                            found = member;
                            if ((member.Flags & FlagType.Getter) > 0) break;
                        }
                    }
                    if (found != null)
                    {
                        result.Member = found;
                        // variable / getter
                        if ((found.Flags & FlagType.Function) == 0)
                        {
                            result.Type = ASContext.Context.ResolveType(found.Type, tmpClass.InFile);
                            result.IsStatic = false;
                        }
                        // constructor
                        else if ((found.Flags & FlagType.Constructor) > 0)
                        {
                            // is the constructor - ie. a Type
                            result.Type = tmpClass;
                            result.IsStatic = true;
                        }
                        // in enum
                        else if ((found.Flags & FlagType.Enum) > 0)
                        {
                            result.Type = ASContext.Context.ResolveType(found.Type, tmpClass.InFile);
                        }
                        // method
                        else
                        {
                            result.Type = ASContext.Context.ResolveType("Function", null);
                            result.IsStatic = false;
                        }
                        break;
                    }
                    // Flash IDE-like typing
                    else if (tmpClass.Name == "MovieClip" || tmpClass.Name == "Sprite")
                    {
                        string autoType = null;
                        if (tmpClass.InFile.Version < 3)
                        {
                            if (token.EndsWith("_mc") || token.StartsWith("mc")) autoType = "MovieClip";
                            else if (token.EndsWith("_txt") || token.StartsWith("txt")) autoType = "TextField";
                            else if (token.EndsWith("_btn") || token.StartsWith("bt")) autoType = "Button";
                        }
                        else if (tmpClass.InFile.Version == 3)
                        {
                            if (token.EndsWith("_mc") || token.StartsWith("mc")) autoType = "flash.display.MovieClip";
                            else if (token.EndsWith("_txt") || token.StartsWith("txt")) autoType = "flash.text.TextField";
                            else if (token.EndsWith("_btn") || token.StartsWith("bt")) autoType = "flash.display.SimpleButton";
                        }
                        if (autoType != null)
                        {
                            result.Type = ASContext.Context.ResolveType(autoType, null);
                            result.Member = new MemberModel(token, autoType, FlagType.Variable | FlagType.Dynamic | FlagType.AutomaticVar, Visibility.Public);
                            result.IsStatic = false;
                            return;
                        }
                    }
                    if ((mask & FlagType.Static) > 0 && tmpClass.InFile.Version != 2) break; // only AS2 inherit static members
                    tmpClass = tmpClass.Extends;
                }
			}

			// result found!
			if (found != null)
			{
                result.inClass = tmpClass;
                result.inFile = tmpClass.InFile;
				if (result.Type == null) 
                    result.Type = ASContext.Context.ResolveType(found.Type, tmpClass.InFile);
				return;
			}
			// try subpackages
			else if (inClass.InFile.TryAsPackage)
			{
                result.Type = ASContext.Context.ResolveType(inClass.Name + "." + token, null);
				if (!result.Type.IsVoid())
					return;
			}

			// not found
			result.Type = null;
			result.Member = null;
		}

		#endregion

		#region main_code_parser
		static private List<string> ExtractedSubex;

        /// <summary>
        /// Find Actionscript expression at cursor position
        /// </summary>
        /// <param name="sci">Scintilla Control</param>
        /// <param name="position">Cursor position</param>
        /// <returns></returns>
        static private ASExpr GetExpression(ScintillaNet.ScintillaControl Sci, int position)
        {
            return GetExpression(Sci, position, false);
        }

		/// <summary>
		/// Find Actionscript expression at cursor position
		/// </summary>
		/// <param name="sci">Scintilla Control</param>
		/// <param name="position">Cursor position</param>
        /// <param name="ignoreWhiteSpace">Skip whitespace at position</param>
		/// <returns></returns>
        static private ASExpr GetExpression(ScintillaNet.ScintillaControl Sci, int position, bool ignoreWhiteSpace)
		{
			ASExpr expression = new ASExpr();
			expression.Position = position;
			expression.Separator = ' ';

            // file's member declared at this position
            expression.ContextMember = ASContext.Context.CurrentMember;
            int minPos = 0;
            string body = null;
            if (expression.ContextMember != null)
            {
                minPos = Sci.PositionFromLine(expression.ContextMember.LineFrom);
                StringBuilder sbBody = new StringBuilder();
                for (int i = expression.ContextMember.LineFrom; i <= expression.ContextMember.LineTo; i++)
                    sbBody.Append(Sci.GetLine(i)).Append('\n');
                body = sbBody.ToString();
                //int tokPos = body.IndexOf(expression.ContextMember.Name);
                //if (tokPos >= 0) minPos += tokPos + expression.ContextMember.Name.Length;

                if ((expression.ContextMember.Flags & (FlagType.Function | FlagType.Constructor | FlagType.Getter | FlagType.Setter)) > 0)
                {
                    expression.ContextFunction = expression.ContextMember;
                    expression.FunctionOffset = expression.ContextMember.LineFrom;

                    Match mStart = Regex.Match(body, "(\\)|[a-z0-9*])\\s*{", RegexOptions.IgnoreCase);
                    if (mStart.Success)
                    {
                        // cleanup function body & offset
                        int pos = mStart.Index + mStart.Length;
                        expression.BeforeBody = (position < Sci.PositionFromLine(expression.ContextMember.LineFrom) + pos);
                        string pre = body.Substring(0, pos);
                        for (int i = 0; i < pre.Length - 1; i++)
                            if (pre[i] == '\r') { expression.FunctionOffset++; if (pre[i + 1] == '\n') i++; }
                            else if (pre[i] == '\n') expression.FunctionOffset++;
                        body = body.Substring(pos);
                    }
                    expression.FunctionBody = body;
                }
                else
                {
                    int eqPos = body.IndexOf('=');
                    expression.BeforeBody = (eqPos < 0 || position < Sci.PositionFromLine(expression.ContextMember.LineFrom) + eqPos);
                }
            }

            // get the word characters from the syntax definition
            string characterClass = ScintillaNet.ScintillaControl.Configuration.GetLanguage(Sci.ConfigurationLanguage).characterclass.Characters;

            // get expression before cursor
            ContextFeatures features = ASContext.Context.Features;
            int stylemask = (1 << Sci.StyleBits) -1;
			int style = (position >= minPos) ? Sci.StyleAt(position) & stylemask : 0;
            StringBuilder sb = new StringBuilder();
            StringBuilder sbSub = new StringBuilder();
            int subCount = 0;
			char c;
            int startPos = position;
            int braceCount = 0;
            int sqCount = 0;
            int genCount = 0;
            bool hasGenerics = features.hasGenerics;
            bool hadWS = false;
            bool hadDot = ignoreWhiteSpace;
            bool inRegex = false;
            char dot = features.dot[features.dot.Length-1];
            while (position > minPos)
            {
                position--;
                style = Sci.StyleAt(position) & stylemask;
                if (style == 14) // regex literal
                {
                    inRegex = true;
                }
                else if (!IsCommentStyle(style))
                {
                    c = (char)Sci.CharAt(position);
                    // end of regex literal
                    if (inRegex)
                    {
                        inRegex = false;
                        if (expression.SubExpressions == null) expression.SubExpressions = new List<string>();
                        expression.SubExpressions.Add("");
                        sb.Insert(0, "RegExp.#" + (subCount++) + "~");
                    }
                    // array access
                    if (c == '[')
                    {
                        sqCount--;
                        if (sqCount == 0)
                        {
                            if (sbSub.Length > 0) sbSub.Insert(0, '[');
                            if (braceCount == 0) sb.Insert(0, ".[]");
                            continue;
                        }
                        if (sqCount < 0)
                        {
                            expression.Separator = ';';
                            break;
                        }
                    }
                    else if (c == ']')
                    {
                        sqCount++;
                    }
                    //
                    else if (c == '<' && hasGenerics)
                    {
                        genCount--;
                        if (genCount < 0)
                        {
                            expression.Separator = ';';
                            break;
                        }
                    }
                    else if (c == '>' && hasGenerics)
                    {
                        genCount++;
                    }
                    // ignore sub-expressions (method calls' parameters)
                    else if (c == '(')
                    {
                        braceCount--;
                        if (braceCount == 0)
                        {
                            sb.Insert(0, ".#"+(subCount++)+"~"); // method call or sub expression
                            sbSub.Insert(0, c);
                            expression.SubExpressions.Add(sbSub.ToString());
                            continue;
                        }
                        else if (braceCount < 0)
                        {
                            expression.Separator = ';';
                            int testPos = position - 1;
                            string testWord = GetWordLeft(Sci, ref testPos); // anonymous function
                            string testWord2 = GetWordLeft(Sci, ref testPos); // regular function
                            if (testWord == ASContext.Context.Features.functionKey || testWord == "catch"
                                || testWord2 == ASContext.Context.Features.functionKey) 
                            {
                                expression.Separator = ',';
                                expression.coma = ComaExpression.FunctionDeclaration;
                            }
                            break;
                        }
                    }
                    else if (c == ')')
                    {
                        if (!hadDot)
                        {
                            expression.Separator = ';';
                            break;
                        }
                        if (braceCount == 0) // start sub-expression
                        {
                            if (expression.SubExpressions == null) expression.SubExpressions = new List<string>();
                            sbSub = new StringBuilder();
                        }
                        braceCount++;
                    }
                    if (braceCount > 0 || sqCount > 0 || genCount > 0) 
                    {
                        if (c == ';') // not expected: something's wrong
                        {
                            expression.Separator = ';';
                            break;
                        }
                        // build sub expression
                        sbSub.Insert(0, c);
                        continue;
                    }
                    // build expression
                    if (c <= 32)
                    {
                        if (genCount == 0) hadWS = true;
                    }
                    else if (c == dot)
                    {
                        if (features.dot.Length == 2)
                            hadDot = position > 0 && Sci.CharAt(position - 1) == features.dot[0];
                        else hadDot = true;
                        sb.Insert(0, c);
                    }
                    else if (characterClass.IndexOf(c) >= 0)
                    {
                        if (hadWS && !hadDot)
                        {
                            expression.Separator = ' ';
                            break;
                        }
                        hadWS = false;
                        hadDot = false;
                        sb.Insert(0, c);
                        startPos = position;
                    }
                    else if (c == ';')
                    {
                        expression.Separator = ';';
                        break;
                    }
                    else if (hasGenerics && (genCount > 0 || c == '<'))
                    {
                        sb.Insert(0, c);
                    }
                    else if (c == '{')
                    {
                        expression.coma = DisambiguateComa(Sci, position, minPos);
                        expression.Separator = (expression.coma == ComaExpression.None) ? ';' : ',';
                        break;
                    }
                    else if (c == ',')
                    {
                        expression.coma = DisambiguateComa(Sci, position, minPos);
                        expression.Separator = (expression.coma == ComaExpression.None) ? ';' : ',';
                        break;
                    }
                    else if (c == ':')
                    {
                        expression.Separator = ':';
                        break;
                    }
                    else if (c == '=')
                    {
                        expression.Separator = '=';
                        break;
                    }
                    else //if (hadWS && !hadDot)
                    {
                        expression.Separator = ';';
                        break;
                    }
                }
                // string literals only allowed in sub-expressions
                else
                {
                    if (braceCount == 0) // not expected: something's wrong
                    {
                        expression.Separator = ';';
                        break;
                    }
                }
            }

            // check if there is a particular keyword
            if (expression.Separator == ' ') 
            {
                expression.WordBefore = GetWordLeft(Sci, ref position);
            }

			// result
            expression.Value = sb.ToString();
            expression.PositionExpression = startPos;
            LastExpression = expression;
			return expression;
		}

        /// <summary>
        /// Find out in what context is a coma-separated expression
        /// </summary>
        /// <returns></returns>
        private static ComaExpression DisambiguateComa(ScintillaNet.ScintillaControl Sci, int position, int minPos)
        {
            ContextFeatures features = ASContext.Context.Features;
            // find block start '(' or '{'
            int parCount = 0;
            int braceCount = 0;
            int sqCount = 0;
            char c;
            while (position > minPos)
            {
                c = (char)Sci.CharAt(position);
                if (c == ';')
                {
                    return ComaExpression.None;
                }
                // var declaration
                else if (c == ':')
                {
                    position--;
                    string word = GetWordLeft(Sci, ref position);
                    word = GetWordLeft(Sci, ref position);
                    if (word == features.varKey) return ComaExpression.VarDeclaration;
                    else continue;
                }
                // Array values
                else if (c == '[')
                {
                    sqCount--;
                    if (sqCount < 0)
                    {
                        return ComaExpression.ArrayValue;
                    }
                }
                else if (c == ']')
                {
                    sqCount++;
                }
                // function declaration or parameter
                else if (c == '(')
                {
                    parCount--;
                    if (parCount < 0)
                    {
                        position--;
                        string word1 = GetWordLeft(Sci, ref position);
                        if (word1 == features.functionKey) return ComaExpression.FunctionDeclaration; // anonymous function
                        string word2 = GetWordLeft(Sci, ref position);
                        if (word2 == features.functionKey || word2 == features.setKey || word2 == features.getKey)
                            return ComaExpression.FunctionDeclaration; // function declaration
                        return ComaExpression.FunctionParameter; // function call
                    }
                }
                else if (c == ')')
                {
                    parCount++;
                }
                // code block or anonymous object
                else if (c == '{')
                {
                    braceCount--;
                    if (braceCount < 0)
                    {
                        position--;
                        string word1 = GetWordLeft(Sci, ref position);
                        c = (word1.Length > 0) ? word1[word1.Length - 1] : (char)Sci.CharAt(position);
                        if (c != ')' && c != '}' && !Char.IsLetterOrDigit(c)) return ComaExpression.AnonymousObject;
                        break;
                    }
                }
                else if (c == '}')
                {
                    braceCount++;
                }
                position--;
            }
            return ComaExpression.None;
        }

		/// <summary>
		/// Parse function body for local var definitions
		/// TODO  ASComplete: parse coma separated local vars definitions
		/// </summary>
		/// <param name="expression">Expression source</param>
		/// <returns>Local vars dictionnary (name, type)</returns>
		static public MemberList ParseLocalVars(ASExpr expression)
		{
			FileModel model;
            if (expression.FunctionBody != null && expression.FunctionBody.Length > 0)
            {
                model = ASContext.Context.GetCodeModel(expression.FunctionBody);
                foreach (MemberModel member in model.Members)
                {
                    member.Flags |= FlagType.LocalVar;
                    member.LineFrom += expression.FunctionOffset;
                    member.LineTo += expression.FunctionOffset;
                }
            }
            else model = new FileModel();
            if (expression.ContextFunction != null && expression.ContextFunction.Parameters != null)
            {
                ContextFeatures features = ASContext.Context.Features;
                foreach (MemberModel item in expression.ContextFunction.Parameters)
                {
                    if (item.Name.StartsWith(features.dot)) 
                        model.Members.Merge(new MemberModel(item.Name.Substring(item.Name.LastIndexOf(features.dot) + 1), "Array", item.Flags, item.Access));
                    else if (item.Name[0] == '?') model.Members.Merge(new MemberModel(item.Name.Substring(1), item.Type, item.Flags, item.Access));
                    else model.Members.Merge(item);
                }
                if (features.functionArguments != null)
                    model.Members.Add(ASContext.Context.Features.functionArguments);
            }
            model.Members.Sort();
            return model.Members;
		}

		/// <summary>
		/// Extract sub-expressions
		/// </summary>
		static private string ExtractSubex(Match m)
		{
            ExtractedSubex.Add(m.Value);
            return ".#" + (ExtractedSubex.Count - 1) + "~";
		}
		#endregion

		#region tools_functions

        static public string GetNewLineMarker(int eolMode)
        {
            if (eolMode == 1) return "\r";
            else if (eolMode == 2) return "\n";
            else return "\r\n";
        }

        static public bool IsLiteralStyle(int style)
        {
            return (style == 4) || (style == 6) || (style == 7);
        }

        static public bool IsTextStyle(int style)
		{
			return (style == 0) || (style == 4) || (style == 5) || /*(style == 6) || (style == 7) ||*/ (style == 10) || (style == 11) || (style == 16) 
                || (style == 127);
		}

		static public bool IsTextStyleEx(int style)
		{
            return (style == 0) || (style == 4) || (style == 5) || (style == 6) || (style == 7) || (style == 10) || (style == 11) || (style == 16) || (style == 19) 
                || (style == 127);
		}

		static public bool IsCommentStyle(int style)
		{
			return (style == 1) || (style == 2) || (style == 3) || (style == 17) || (style == 18);
		}

		static public string GetWordLeft(ScintillaNet.ScintillaControl Sci, ref int position)
		{
            // get the word characters from the syntax definition
            string characterClass = ScintillaNet.ScintillaControl.Configuration.GetLanguage(Sci.ConfigurationLanguage).characterclass.Characters;

			string word = "";
			//string exclude = "(){};,+*/\\=:.%\"<>";
			bool skipWS = true;
			int style;
			int stylemask = (1 << Sci.StyleBits) -1;
			char c;
			while (position >= 0)
			{
				style = Sci.StyleAt(position) & stylemask;
				if (IsTextStyleEx(style))
				{
					c = (char)Sci.CharAt(position);
					if (c <= ' ')
					{
						if (!skipWS)
							break;
					}
                    else if (characterClass.IndexOf(c) < 0) break;
					else if (style != 6)
					{
						word = c+word;
						skipWS = false;
					}
				}
				position--;
			}
			return word;
		}

		static public ASResult GetExpressionType(ScintillaNet.ScintillaControl sci, int position)
		{
            // context
            int line = sci.LineFromPosition(position);
            if (line != ASContext.Context.CurrentLine) 
                ASContext.Context.UpdateContext(line);
            try
            {
                ASExpr expr = GetExpression(sci, position);
                if ((expr.Value == null) || (expr.Value.Length == 0))
                    return new ASResult();
                expr.LocalVars = ParseLocalVars(expr);
                FileModel aFile = ASContext.Context.CurrentModel;
                ClassModel aClass = ASContext.Context.CurrentClass;
                // Expression before cursor
                return EvalExpression(expr.Value, expr, aFile, aClass, true, false);
            }
            finally
            {
                // restore context
                if (line != ASContext.Context.CurrentLine) 
                    ASContext.Context.UpdateContext(ASContext.Context.CurrentLine);
            }
		}

        private static bool IsXmlType(ClassModel model)
        {
            return model != null
                && (model.QualifiedName == "XML" || model.QualifiedName == "XMLList");
        }

		#endregion

		#region tooltips formatting
		static public string GetToolTipText(ASResult result)
		{
			if (result.Member != null && result.inClass != null)
			{
				return MemberTooltipText(result.Member, result.inClass);
			}
			else if (result.Member != null && (result.Member.Flags & FlagType.Constructor) != FlagType.Constructor)
			{
                return MemberTooltipText(result.Member, ClassModel.VoidClass);
			}
			else if (result.inClass != null)
			{
				return ClassModel.ClassDeclaration(result.inClass);
			}
			else if (result.Type != null)
			{
				return ClassModel.ClassDeclaration(result.Type);
			}
			else return null;
		}

		static private string MemberTooltipText(MemberModel member, ClassModel inClass)
		{
			// modifiers
            FlagType ft = member.Flags;
            Visibility acc = member.Access;
			string modifiers = "";
			if ((ft & FlagType.Class) == 0)
            {
                if ((ft & FlagType.LocalVar) > 0)
                    modifiers += "(local) ";
                else if ((ft & FlagType.ParameterVar) > 0)
                    modifiers += "(parameter) ";
                else if ((ft & FlagType.AutomaticVar) > 0)
                    modifiers += "(auto) ";
                else
                {
                    if ((ft & FlagType.Extern) > 0)
                        modifiers += "extern ";
                    if ((ft & FlagType.Static) > 0)
                        modifiers += "static ";
                    if ((acc & Visibility.Private) > 0)
                        modifiers += "private ";
                    else if ((acc & Visibility.Public) > 0)
                        modifiers += "public ";
                    else if ((acc & Visibility.Protected) > 0)
                        modifiers += "protected ";
                    else if ((acc & Visibility.Internal) > 0)
                        modifiers += "internal ";
                }
            }
			// signature
            string foundIn = "";
            if (inClass != ClassModel.VoidClass)
            {
                string package = inClass.InFile.Package;
                foundIn = "\nin " + ((package.Length > 0) ? package + "." + inClass.Name : inClass.Name);
            }
            if ((ft & (FlagType.Getter | FlagType.Setter)) > 0)
                return String.Format("{0}property {1}{2}", modifiers, member.ToString(), foundIn);
            else if ((ft & FlagType.Function) > 0)
            {
                return String.Format("{0}function {1}{2}", modifiers, member.ToString(), foundIn);
            }
            else if ((ft & FlagType.Namespace) > 0)
                return String.Format("{0}namespace {1}{2}", modifiers, member.Name, foundIn);
            else if ((ft & FlagType.Constant) > 0)
                return String.Format("{0}const {1}{2}", modifiers, member.ToString(), foundIn);
            else if ((ft & FlagType.Variable) > 0)
                return String.Format("{0}var {1}{2}", modifiers, member.ToString(), foundIn);
            else
                return String.Format("{0}{1}{2}", modifiers, member.ToString(), foundIn);
		}
		#endregion

		#region automatic code generation
		static private ASExpr LastExpression;

        /// <summary>
        /// When typing a fully qualified class name:
        /// - automatically insert import statement 
        /// - replace with short name
        /// </summary>
        static internal void HandleCompletionInsert(ScintillaNet.ScintillaControl sci, int position, string text, char trigger)
        {
            if (!ASContext.Context.IsFileValid)
                return;
            // let the context handle the insertion
            if (ASContext.Context.OnCompletionInsert(sci, position, text))
                return;

            // default handling
            if (ASContext.Context.Settings != null)
            {
                // was a fully qualified type inserted?
                ASExpr expr = GetExpression(sci, position + text.Length);
                if (expr.Value == null) return;

                // look for a snippet
                ContextFeatures features = ASContext.Context.Features;
                if (trigger == '\t' && expr.Value.IndexOf(features.dot) < 0)
                {
                    foreach(string key in features.codeKeywords)
                        if (key == expr.Value)
                        {
                            InsertSnippet(key);
                            return;
                        }
                }

                // resolve context & do smart insertion
                expr.LocalVars = ParseLocalVars(expr);
                ASResult context = EvalExpression(expr.Value, expr, ASContext.Context.CurrentModel, ASContext.Context.CurrentClass, true, false);
                if (SmartInsertion(sci, position, expr, context))
                    DispatchInsertedElement(context, trigger);
            }
        }

        private static bool SmartInsertion(ScintillaNet.ScintillaControl sci, int position, ASExpr expr, ASResult context)
        {
            ContextFeatures features = ASContext.Context.Features;
            FileModel cFile = ASContext.Context.CurrentModel;
            ClassModel cClass = ASContext.Context.CurrentClass;
            FileModel inFile = null;
            MemberModel import = null;

            // if completed a package-level member
            if (context.Member != null && context.Member.IsPackageLevel && context.Member.InFile.Package != "")
            {
                inFile = context.Member.InFile;
                import = context.Member.Clone() as MemberModel;
                import.Type = inFile.Package + "." + import.Name;
            }
            // if not completed a type
            else if (context.IsNull() || !context.IsStatic || context.Type == null
                || (context.Type.Type != null && context.Type.Type.IndexOf(features.dot) < 0)
                || context.Type.IsVoid())
            {
                if (context.Member != null && expr.Separator == ' '
                    && expr.WordBefore == features.overrideKey)
                {
                    ASGenerator.GenerateOverride(sci, context.inClass, context.Member, position);
                    return false;
                }
                else if (!context.IsNull())
                {
                    if (expr.WordBefore == features.importKey)
                        ASContext.Context.RefreshContextCache(expr.Value);
                }
                return true;
            }
            // test inserted type
            else
            {
                inFile = context.inFile;
                import = context.Type;
            }
            if (inFile == null || import == null)
                return false;

            if (expr.Separator == ' ' && expr.WordBefore != null)
            {

                if (expr.WordBefore == features.importKey
                    || (!features.HasTypePreKey(expr.WordBefore) && expr.WordBefore != "case" && expr.WordBefore != "return"))
                {
                    if (expr.WordBefore == features.importKey)
                        ASContext.Context.RefreshContextCache(expr.Value);
                    return true;
                }
            }
            int startPos = expr.PositionExpression;
            int endPos = sci.CurrentPos;

            // check if in the same file or package
            if (cFile == inFile || features.hasPackages && cFile.Package == inFile.Package)
            {
                sci.SetSel(startPos, endPos);
                sci.ReplaceSel(import.Name);
                sci.SetSel(sci.CurrentPos, sci.CurrentPos);
                return true;
            }

            int curLine = sci.LineFromPosition(position);
            try
            {
                if (ASContext.Context.IsImported(import, curLine))
                {
                    sci.SetSel(startPos, endPos);
                    sci.ReplaceSel(import.Name);
                    sci.SetSel(sci.CurrentPos, sci.CurrentPos);
                    return true;
                }
            }
            catch (Exception) // type name already present in imports
            {
                return true;
            }

            // class with same name exists in current package?
            if (ASContext.Context.Features.hasPackages && import is ClassModel)
            {
                string cname = import.Name;
                if (cFile.Package.Length > 0) cname = cFile.Package + "." + cname;
                ClassModel inPackage = ASContext.Context.ResolveType(cname, cFile);
                if (!inPackage.IsVoid())
                    return true;
            }

            // insert import
            if (ASContext.Context.Settings.GenerateImports)
            {
                sci.BeginUndoAction();
                try
                {
                    int offset = ASGenerator.InsertImport(import, true);
                    // insert short name
                    startPos += offset;
                    endPos += offset;
                    sci.SetSel(startPos, endPos);
                    sci.ReplaceSel(import.Name);
                    sci.SetSel(sci.CurrentPos, sci.CurrentPos);
                }
                finally
                {
                    sci.EndUndoAction();
                }
            }
            return true;
        }

        private static void DispatchInsertedElement(ASResult context, char trigger)
        {
            Hashtable info = new Hashtable();
            info["context"] = context;
            info["trigger"] = trigger;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.InsertedElement", info);
            EventManager.DispatchEvent(ASContext.Context, de);
        }

        private static void InsertSnippet(string word)
        {
            String global = Path.Combine(PathHelper.SnippetDir, word + ".fds");
            String specificDir = Path.Combine(PathHelper.SnippetDir, ASContext.Context.Settings.LanguageId);
            String specific = Path.Combine(specificDir, word + ".fds");
            if (File.Exists(specific) || File.Exists(global))
                PluginBase.MainForm.CallCommand("InsertSnippet", word);
        }

		/// <summary>
		/// Some characters can fire code generation
		/// </summary>
		/// <param name="sci"></param>
		/// <param name="value">Character inserted</param>
		/// <returns>Code was generated</returns>
		static private bool CodeAutoOnChar(ScintillaNet.ScintillaControl sci, int value)
		{
			if (ASContext.Context.Settings == null || !ASContext.Context.Settings.GenerateImports)
				return false;

			int position = sci.CurrentPos;

			if (value == '*' && position > 1 && sci.CharAt(position-2) == '.' && LastExpression != null)
			{
				// context
				if (LastExpression.Separator == ' ' && LastExpression.WordBefore != null 
                    && !ASContext.Context.Features.HasTypePreKey(LastExpression.WordBefore))
					return false;

                FileModel cFile = ASContext.Context.CurrentModel;
                ClassModel cClass = ASContext.Context.CurrentClass;
				ASResult context = EvalExpression(LastExpression.Value, LastExpression, cFile, cClass, true, false);
                if (context.IsNull() || !context.IsPackage || context.inFile == null)
					return false;

				string package = LastExpression.Value;
				int startPos = LastExpression.Position;
				string check = "";
				char c;
				while (startPos > LastExpression.PositionExpression && check.Length <= package.Length && check != package)
				{
					c = (char)sci.CharAt(--startPos);
					if (c > 32) check = c+check;
				}
				if (check != package)
					return false;

				// insert import
				string statement = "import "+package+"*;"+GetNewLineMarker(sci.EOLMode);
				int endPos = sci.CurrentPos;
				int line = 0;
				int curLine = sci.LineFromPosition(position);
				bool found = false;
				while (line < curLine)
				{
					if (sci.GetLine(line++).IndexOf("import") >= 0) found = true;
					else if (found) {
						line--;
						break;
					}
				}
				if (line == curLine) line = 0;
				position = sci.PositionFromLine(line);
				line = sci.FirstVisibleLine;
				sci.SetSel(position, position);
				sci.ReplaceSel(statement);

				// prepare insertion of the term as usual
				startPos += statement.Length;
				endPos += statement.Length;
				sci.SetSel(startPos, endPos);
				sci.ReplaceSel("");
				sci.LineScroll(0, line-sci.FirstVisibleLine+1);

				// create classes list
                List<ICompletionListItem> list = new List<ICompletionListItem>();
				foreach(MemberModel import in cClass.InFile.Imports)
				if (import.Type.StartsWith(package))
					list.Add(new MemberItem(import));
				CompletionList.Show(list, false);
				return true;
			}
			return false;
		}

		#endregion
    }

    #region completion list
    /// <summary>
    /// Class member completion list item
    /// </summary>
    public class MemberItem : ICompletionListItem
    {
        private MemberModel member;
        private int icon;

        public MemberItem(MemberModel oMember)
        {
            member = oMember;
            FlagType type = member.Flags;
            Visibility acc = member.Access;
            icon = PluginUI.ICON_TYPE;
            if ((type & (FlagType.Getter | FlagType.Setter)) > 0)
                icon = ((acc & Visibility.Private) > 0) ? PluginUI.ICON_PRIVATE_PROPERTY :
                    ((acc & Visibility.Protected) > 0) ? PluginUI.ICON_PROTECTED_PROPERTY : PluginUI.ICON_PROPERTY;
            else if ((type & FlagType.Function) > 0)
                icon = ((acc & Visibility.Private) > 0) ? PluginUI.ICON_PRIVATE_FUNCTION :
                    ((acc & Visibility.Protected) > 0) ? PluginUI.ICON_PROTECTED_FUNCTION : PluginUI.ICON_FUNCTION;
            else if ((type & FlagType.Constant) > 0)
                icon = ((acc & Visibility.Private) > 0) ? PluginUI.ICON_PRIVATE_CONST :
                    ((acc & Visibility.Protected) > 0) ? PluginUI.ICON_PROTECTED_CONST : PluginUI.ICON_CONST;
            else if ((type & FlagType.Variable) > 0)
                icon = ((acc & Visibility.Private) > 0) ? PluginUI.ICON_PRIVATE_VAR :
                    ((acc & Visibility.Protected) > 0) ? PluginUI.ICON_PROTECTED_VAR : PluginUI.ICON_VAR;
            else if ((type & FlagType.Intrinsic) > 0)
                icon = PluginUI.ICON_INTRINSIC_TYPE;
            else if ((type & FlagType.Interface) > 0)
                icon = PluginUI.ICON_INTERFACE;
            else if (type == FlagType.Package)
                icon = PluginUI.ICON_PACKAGE;
            else if (type == FlagType.Declaration)
                icon = PluginUI.ICON_DECLARATION;
            else if (type == FlagType.Template)
                icon = PluginUI.ICON_TEMPLATE;
        }

        public string Label
        {
            get { return member.Name; }
        }

        public string Description
        {
            get
            {
                return ClassModel.MemberDeclaration(member) + ASDocumentation.GetTipDetails(member, null);
            }
        }

        public System.Drawing.Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(icon); }
        }

        public string Value
        {
            get 
            {
                if (member.Name.IndexOf('<') > 0)
                {
                    if (member.Name.IndexOf(".<") > 0) 
                        return member.Name.Substring(0, member.Name.IndexOf(".<"));
                    else return member.Name.Substring(0, member.Name.IndexOf('<'));
                }
                return member.Name; 
            }
        }
    }

    /// <summary>
    /// Declaration completion list item
    /// </summary>
    public class DeclarationItem : ICompletionListItem
    {
        private string label;

        public DeclarationItem(string label)
        {
            this.label = label;
        }

        public string Label
        {
            get { return label; }
        }
        public string Description
        {
            get { return "Declaration template"; }
        }

        public System.Drawing.Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(PluginUI.ICON_DECLARATION); }
        }

        public string Value
        {
            get { return label; }
        }
    }
    #endregion

	#region expressions_structures
    public enum ComaExpression
    {
        None,
        AnonymousObject,
        VarDeclaration,
        FunctionDeclaration,
        FunctionParameter,
        ArrayValue,
        GenericIndexType
    }

	/// <summary>
	/// Parsed expression with it's function context
	/// </summary>
	sealed public class ASExpr
	{
		public int Position;
        public MemberModel ContextMember;
        public MemberList LocalVars;
        public MemberModel ContextFunction;
        public string FunctionBody;
        public int FunctionOffset;
        public bool BeforeBody;

        public int PositionExpression;
		public string Value;
        public List<string> SubExpressions;
		public char Separator;
		public string WordBefore;
        public ComaExpression coma;

        public ASExpr() { }

        public ASExpr(ASExpr inContext) 
        {
            ContextMember = inContext.ContextMember;
            ContextFunction = inContext.ContextFunction;
            LocalVars = inContext.LocalVars;
            FunctionBody = inContext.FunctionBody;
        }
	}

	/// <summary>
	/// Expressions/tokens evaluation result
	/// </summary>
	sealed public class ASResult
	{
		public ClassModel Type;
        public ClassModel inClass;
        public FileModel inFile;
		public MemberModel Member;
        public bool IsStatic;
        public bool IsPackage;

		public bool IsNull()
		{
            return (Type == null && Member == null && !IsPackage);
		}
	}
	#endregion
}


