/*
 * Code completion
 */

using System;
using System.Windows.Forms;
using System.Collections;
using System.Collections.Specialized;
using System.Text;
using System.Text.RegularExpressions;
using PluginCore;
using PluginCore.Controls;

namespace ASCompletion
{
	/// <summary>
	/// Description of ASComplete.
	/// </summary>
	public class ASComplete
	{		
		#region regular_expressions_definitions
		static private readonly RegexOptions ro_csr = 
			ASClassParser.ro_cs | RegexOptions.RightToLeft;
		
		// special keyword
		static private readonly Regex re_specialKeyword =
			new Regex("[^\\w](?<key>import|new|extends|implements) $", ro_csr);

		// refine last expression
		static private readonly Regex re_refineExpression =
			new Regex("[^\\[\\]{}(:,=+*/%!<>-]*$", ro_csr);

		// find function declaration
		static private readonly Regex re_validFunction =
			new Regex("function[\\s][\\s\\w$]+\\(", ASClassParser.ro_cs);
		// anonymouse function statement
		static private readonly Regex re_anonymousFunction =
			new Regex("function[\\s]*\\(\\)", ASClassParser.ro_cs);

		// find class definition
		static private readonly Regex re_classDefinition =
			new Regex("^[\\s]*class[\\s]+", ASClassParser.ro_cs);
		
		// find local vars definitions
		static private readonly Regex re_variable =
			new Regex("[;{}\\(\r\n][\\s]*var[\\s]+[^,;=\r\n]+", ASClassParser.ro_cs);
		static private readonly Regex re_splitVariable =
			new Regex("[^\\w$]var[\\s]+(?<pname>[\\w$]+)(?<type>.*)",  ASClassParser.ro_cs);
		static public readonly Regex re_variableType = 
			ASClassParser.re_variableType;

		// code cleaning
		static private readonly Regex re_whiteSpace =
			new Regex("[\\s]+", ASClassParser.ro_cs);
		static private readonly Regex re_dot =
			new Regex("[\\s]*\\.[\\s]*", ASClassParser.ro_cs);
		static private readonly Regex re_subexMarker =
			new Regex("[\\s]*#", ASClassParser.ro_cs);
		
		
		// balanced matching, see: http://blogs.msdn.com/bclteam/archive/2005/03/15/396452.aspx
		static private readonly Regex re_balancedBraces = 
			ASClassParser.re_balancedBraces;
		static private readonly Regex re_balancedParenthesis = 
			new Regex("\\([^()]*(((?<Open>\\()[^()]*)+((?<Close-Open>\\))[^()]*)+)*(?(Open)(?!))\\)", ASClassParser.ro_cs);
		//static private readonly Regex re_balancedBrakets = 
		//	new Regex("\\[[^\\[\\]]*(((?<Open>\\[)[^\\[\\]]*)+((?<Close-Open>\\])[^\\[\\]]*)+)*(?(Open)(?!))\\]", ASClassParser.ro_cs);
		
		// expressions
		static private readonly Regex re_sub =
			new Regex("^#(?<index>[0-9]+)~$", ASClassParser.ro_cs);
			//new Regex("^#(?<index>[0-9]+)~(?<token>.*)$", ASClassParser.ro_cs);
		static private readonly Regex re_level = 
			new Regex("^_level[0-9]+$", ASClassParser.ro_cs);
		#endregion
		
		#region application_event_handlers
		/// <summary>
		/// Character written in editor
		/// </summary>
		/// <param name="Value">Character inserted</param>
		static public bool OnChar(ScintillaNet.ScintillaControl Sci, int Value, bool autoHide)
		{
			if (autoHide && !ASContext.HelpersEnabled)
				return false;
			try
			{
				int eolMode = Sci.EOLMode;
				// code auto
				if (((Value == 10) && (eolMode != 1)) || ((Value == 13) && (eolMode == 1)))
				{
					DebugConsole.Trace("Struct");
					HandleStructureCompletion(Sci);
					return false;
				}
				
				// ignore repeated characters
				int position = Sci.CurrentPos;
				if ((Sci.CharAt(position-2) == Value) && (Sci.CharAt(position-1) == Value) && (Value != '*'))
					return false;
				
				// ignore text in comments & quoted text
				Sci.Colourise(0,-1);
				int stylemask = (1 << Sci.StyleBits) -1;
				int style = Sci.StyleAt(position-1) & stylemask;
				DebugConsole.Trace("style "+style);
				if (!IsTextStyle(style) && !IsTextStyle(Sci.StyleAt(position) & stylemask))
				{
					// documentation completion
					if (ASContext.DocumentationCompletionEnabled && IsCommentStyle(style))
						return ASDocumentation.OnChar(Sci, Value, position, style);
					else if (autoHide) return false;
				}
				
				// stop here if the class is not valid
				if (!ASContext.IsClassValid()) return false;
				
				// handle
				switch (Value)
				{
					case '.':
						return HandleDotCompletion(Sci, autoHide);
						
					case ' ':
						position--;
						string word = GetWordLeft(Sci, ref position);
						DebugConsole.Trace("Word? "+word);
						if (word.Length > 0)
						switch (word) 
						{
							case "new":
							case "extends":
							case "implements":
								return HandleNewCompletion(Sci, "", autoHide);
							case "import":
								return HandleImportCompletion(Sci, "", autoHide);
							case "public":
								return HandleDeclarationCompletion(Sci, "function static var", "", autoHide);
							case "private":
								return HandleDeclarationCompletion(Sci, "function static var", "", autoHide);
							case "static":
								return HandleDeclarationCompletion(Sci, "function private public var", "", autoHide);
						}
						break;
						
					case ':':
						ASContext.UnsetOutOfDate();
						bool result = HandleColonCompletion(Sci, "", autoHide);
						ASContext.SetOutOfDate();
						return result;
						
					case '(':
						return HandleFunctionCompletion(Sci);
					case ')':
						if (InfoTip.CallTipActive) InfoTip.Hide();
						return false;
					
					case '*':
						return CodeAutoOnChar(Sci, Value);
				}
			}
			catch (Exception ex) {
				ErrorHandler.ShowError("Completion error", ex);
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
			DebugConsole.Trace("Key? "+keys);
			// dot complete
			if (keys == (Keys.Control | Keys.Space))
			{
				if (ASContext.IsClassValid()) 
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
				if (ASContext.IsClassValid()) 
				{
					// force function completion
					HandleFunctionCompletion(Sci);
					return true;
				}
				else return false;
			}
			// hot build
			else if (keys == (Keys.Control | Keys.Enter))
			{
				// project build
				TextEvent te = new TextEvent(EventType.Command, "HotBuild");
				ASContext.MainForm.DispatchEvent(te);
				//
				if (!te.Handled) 
				{
					// quick build
					if (!ASContext.BuildMTASC(true) && ASContext.MMHotBuild)
					{
						// test movie
						CommandBarButton item = ASContext.MainForm.GetCBButton("TestInFlashButton");
						if ((item != null) && (item.Tag != null))
						{
							ASContext.MainForm.CallCommand("PluginCommand", (string)item.Tag);
						}
					}
				}
				return true;
			}
			// help
			else if (keys == Keys.F1)
			{
				return (ResolveElement(Sci, "ShowDocumentation") != null);
			}
			return false;
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
			if (!ASContext.IsClassValid() || (Sci == null)) return false;
			
			// get type at cursor position
			int position = Sci.WordEndPosition(Sci.CurrentPos, true);			
			ASResult result = GetExpressionType(Sci, position);
			
			// Open source and show declaration
			if (!result.IsNull())
			{
				// browse to package folder
				if ((result.Class != null) && (result.Class.Flags == FlagType.Package))
				{
					return ASContext.BrowseTo(result.Class.ClassName);
				}
				
				// open/activate class file
				ASClass oClass = (result.inClass != null) ? result.inClass : result.Class;
				if (oClass.IsVoid() || (oClass.FileName.Length == 0))
					return false;
				
				// for Back command
				ASContext.Panel.SetLastLookupPosition(ASContext.CurrentFile, Sci.CurrentPos);
				
				// open the file
				ASContext.MainForm.OpenSelectedFile(oClass.FileName);
				Sci = ASContext.MainForm.CurSciControl;
				if (Sci == null)
					return false;
				
				// show selected member
				Match m = null;
				if (result.Member != null)
				{
					if ((result.Member.Flags & FlagType.Function) > 0)
						m = Regex.Match(Sci.Text, "function[\\s]+(?<mname>"+Regex.Escape(result.Member.Name)+")[\\s]*\\(", ASClassParser.ro_cs);
					else if ((result.Member.Flags & FlagType.Variable) > 0)
						m = Regex.Match(Sci.Text, "var[\\s]+(?<mname>"+Regex.Escape(result.Member.Name)+")[^\\w]", ASClassParser.ro_cs);
					else if ((result.Member.Flags & (FlagType.Getter | FlagType.Setter)) > 0)
						m = Regex.Match(Sci.Text, "function[\\s]+(?<mname>(g|s)et[\\s]+"+Regex.Escape(result.Member.Name)+")[\\s]*\\(", ASClassParser.ro_cs);
					// show
					if ((m != null) && m.Success)
					{
						ASContext.Panel.GotoPosAndFocus(Sci, m.Groups["mname"].Index);
						Sci.SetSel(Sci.CurrentPos, Sci.CurrentPos + m.Groups["mname"].Length);
						return true;
					}
				}
				// else show class declaration
				m = Regex.Match(Sci.Text, "class[\\s]+(?<cname>"+Regex.Escape(oClass.ClassName)+")");
				if (m.Success)
				{
					ASContext.Panel.GotoPosAndFocus(Sci, m.Groups["cname"].Index);
				}
				return true;
			}
			return false;
		}
		
		/// <summary>
		/// Using the text under at cursor position, resolve the member/type and call the specified command.
		/// </summary>
		/// <param name="Sci">Control</param>
		/// <returns>Resolved element details</returns>
		static public Hashtable ResolveElement(ScintillaNet.ScintillaControl Sci, string eventAction)
		{
			// get type at cursor position
			int position = Sci.WordEndPosition(Sci.CurrentPos, true);
			ASResult result = GetExpressionType(Sci, position);
			
			// Open source and show declaration
			if (!result.IsNull())
			{
				ASClass oClass = (result.inClass != null) ? result.inClass : result.Class;
				if (oClass.IsVoid() || (oClass.FileName.Length == 0))
					return null;
				if ((result.Class != null) && (result.Class.Flags == FlagType.Package))
					return null;
				
				// details
				Hashtable details = new Hashtable();
				int p;
				
				// CLASS DETAILS
				details.Add("@CLASSFILE", oClass.FileName);
				// top-level class is not "searchable"
				if (oClass != ASContext.TopLevel)
				{
					details.Add("@CLASSDECL", ASClass.MemberDeclaration(oClass.ToASMember()));
					//
					p = oClass.ClassName.LastIndexOf('.');
					if (p > 0) {
						details.Add("@CLASSPACKAGE", oClass.ClassName.Substring(0,p));
						details.Add("@CLASSNAME", oClass.ClassName.Substring(p+1));
					}
					else {
						details.Add("@CLASSPACKAGE", "");
						details.Add("@CLASSNAME", oClass.ClassName);
					}
					details.Add("@CLASSFULLNAME", oClass.ClassName);
				}
				else {
					details.Add("@CLASSDECL", "");
					details.Add("@CLASSPACKAGE", "");
					details.Add("@CLASSNAME", "");
					details.Add("@CLASSFULLNAME", "");
				}
				
				// MEMBER DETAILS
				if ((result.Class != null) && (result.Member != null))
				{
					details.Add("@MEMBERNAME", result.Member.Name);
					details.Add("@MEMBERDECL", ASClass.MemberDeclaration(result.Member));
					//
					string kind = "";
					if ((result.Member.Flags & FlagType.Function) > 0)
						kind = "method";
					else if ((result.Member.Flags & FlagType.Variable) > 0)
						kind = "property";
					else if ((result.Member.Flags & (FlagType.Getter | FlagType.Setter)) > 0)
						kind = "property";
					details.Add("@MEMBERKIND", kind);
					//
					p = result.Class.ClassName.LastIndexOf('.');
					if (p > 0) {
						details.Add("@MEMBERCLASSPACKAGE", result.Class.ClassName.Substring(0,p));
						details.Add("@MEMBERCLASSNAME", result.Class.ClassName.Substring(p+1));
					}
					else {
						details.Add("@MEMBERCLASSPACKAGE", "");
						details.Add("@MEMBERCLASSNAME", result.Class.ClassName);
					}
					//
					details.Add("@MEMBERCLASSFILE", result.Class.FileName);
					details.Add("@MEMBERCLASSDECL", ASClass.MemberDeclaration(result.Class.ToASMember()));
				}
				else 
				{
					details.Add("@MEMBERKIND", "");
					details.Add("@MEMBERNAME", "");
					details.Add("@MEMBERDECL", "");
					details.Add("@MEMBERCLASSPACKAGE", "");
					details.Add("@MEMBERCLASSNAME", "");
					details.Add("@MEMBERCLASSFILE", "");
					details.Add("@MEMBERCLASSDECL", "");
				}
				
				if (eventAction != null)
				{
					// other plugins may handle the documentation
					DataEvent de = new DataEvent(EventType.CustomData, eventAction, details);
					ASContext.MainForm.DispatchEvent(de);
					if (de.Handled) return details;
				
					// help
					if (eventAction == "ShowDocumentation")
					{
						string cmd = ASContext.HelpCommandPattern;
						if ((cmd == null) || (cmd.Length == 0)) return null;
						// top-level vars should be searched only if the command includes member information
						if ((result.inClass == ASContext.TopLevel) && (cmd.IndexOf("@MEMBER") < 0)) return null;
						// complete command
						foreach(string key in details.Keys)
							cmd = cmd.Replace(key, (string)details[key]);
						// call the command
						ASContext.MainForm.CallCommand("RunProcess", cmd);
					}
				}
				return details;
			}
			return null;
		}
		#endregion      
		
		#region structure_completion
		static private bool HandleStructureCompletion(ScintillaNet.ScintillaControl Sci)
		{
			try
			{
				int position = Sci.CurrentPos;
				int line = Sci.LineFromPosition(position);
				if (line == 0) 
					return false;
				string txt = Sci.GetLine(line-1);
				int style = Sci.BaseStyleAt(position);
				int eolMode = Sci.EOLMode;
				// box comments
				if (IsCommentStyle(style) && (Sci.BaseStyleAt(position+1) == style))
				{
					txt = txt.Trim();
					if (txt.StartsWith("/*") || txt.StartsWith("*"))
					{
						Sci.ReplaceSel("* ");
						position = Sci.LineIndentPosition(line)+2;
						Sci.SetSel(position,position);
						return true;
					}
				}
				// braces
				else if (txt.TrimEnd().EndsWith("{") && (line > 1))
				{
					// find matching brace
					int bracePos = Sci.LineEndPosition(line-1)-1;
					while ((bracePos > 0) && (Sci.CharAt(bracePos) != '{')) bracePos--;
					if (bracePos == 0 || Sci.BaseStyleAt(bracePos) != 10) return true;
					int match = Sci.SafeBraceMatch(bracePos);
					DebugConsole.Trace("match "+bracePos+" "+match);
					int start = line;
					int indent = Sci.GetLineIndentation(start-1);
					if (match > 0)
					{
						int endIndent = Sci.GetLineIndentation(Sci.LineFromPosition(match));
						if (endIndent+Sci.TabWidth > indent) 
							return false;
				 	}
					// find where to include the closing brace
					int startIndent = indent;
					int newIndent = indent+Sci.TabWidth;
					int count = Sci.LineCount;
					int lastLine = line;
					line++;
					while (line < count-1)
					{
						txt = Sci.GetLine(line).TrimEnd();
						if (txt.Length != 0) {
							indent = Sci.GetLineIndentation(line);
							DebugConsole.Trace("indent "+(line+1)+" "+indent+" : "+txt);
							if (indent <= startIndent) break;
							lastLine = line;
						}
						else break;
						line++;
					}
					if (line >= count-1) lastLine = start;
					
					// insert closing brace
					DebugConsole.Trace("Insert at "+position);
					position = Sci.LineEndPosition(lastLine);
					Sci.InsertText(position, ASContext.MainForm.GetNewLineMarker(eolMode)+"}");
					Sci.SetLineIndentation(lastLine+1, startIndent);
					return false;
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
			return false;
		}
		#endregion
		
		#region template_completion
		static private bool HandleDeclarationCompletion(ScintillaNet.ScintillaControl Sci, string words, string tail, bool autoHide)
		{
			DebugConsole.Trace("** Complete: declaration <"+words+">");
			if (words.Length == 0) 
				return false;
			int position = Sci.CurrentPos;
			
			// concat current word if DotCompletion sent us the previous word
			if (Sci.CharAt(position-1) <= 32) 
				tail = "";
			
			// does it need a tab?
			if ((words != "import") && (words.IndexOf("extends") < 0) && (words.IndexOf("implements") < 0))
			{
				if (ASContext.CurrentClass.IsAS3 && words.IndexOf("var") > 0) {
					words = "const "+words;
				}
				int curLine = Sci.LineFromPosition(position);
				if (Sci.GetLineIndentation(curLine) == 0)
				{
					Sci.SetLineIndentation(curLine, Sci.TabWidth);
					if (Sci.IsUseTabs) position++;
					else position += Sci.TabWidth;
					Sci.SelectionStart = Sci.CurrentPos = position;
				}
			}
			
			// remove keywords already set
			words = " "+words+" ";
			string rem = GetWordLeft(Sci, ref position);
			while (rem.Length > 0)
			{
				if ((rem == "var") || (rem == "function") || (ASContext.CurrentClass.IsAS3 && (rem == "const")))
					return true;
				else if (rem == "public")
					words = words.Replace(" private ", " ");
				else if (rem == "private")
					words = words.Replace(" public ", " ");
				words = words.Replace(" "+rem+" ", " ");
				rem = GetWordLeft(Sci, ref position);
			}
			words = words.Trim();
			
			// build list
			string[] items = words.Split(' ');
			ArrayList known = new ArrayList();
			foreach(string item in items)
				known.Add(new TemplateItem(item));
			
			// show
			CompletionList.Show(known, autoHide, tail);
			return true;
		}
		#endregion
		
		#region function_completion
		static private string calltipDef;
		static private ASMember calltipMember;
		static private bool calltipDetails;
		static private int calltipPos = -1;
		static private int calltipOffset;
		static private string prevParam = "";
		
		static public bool HasCalltip()
		{
			return InfoTip.CallTipActive && (calltipDef != null);
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
				start = calltipDef.IndexOf(',',start+1);
			int end = calltipDef.IndexOf(',',start+1);
			if (end < 0) 
				end = calltipDef.IndexOf(')', start+1);
			
			// get parameter name
			string paramName = "";
			if (ASContext.DocumentationInTips && calltipMember.Comments != null && start >= 0 && end > 0) 
			{
				paramName = calltipDef.Substring(start+1, end-start).Trim();
				int p = paramName.IndexOf(':');
				if (p > 0) paramName = paramName.Substring(0, p).TrimEnd();
			}
			
			// show calltip
			if (!InfoTip.CallTipActive || UITools.ShowDetails != calltipDetails || paramName != prevParam)
			{
				prevParam = paramName;
				calltipDetails = UITools.ShowDetails;
				string text = calltipDef + ASDocumentation.GetTipDetails(calltipMember, paramName);
				InfoTip.CallTipShow(Sci, calltipPos-calltipOffset, text);
				UITools.ShowDetails = calltipDetails;
			}
			
			// highlight
			if ((start < 0) || (end < 0))
			{
				InfoTip.Hide();
				calltipDef = null;
				calltipPos = -1;
			}
			else InfoTip.CallTipSetHlt(start+1, end);
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
					DebugConsole.Trace("Keyword "+keyword);
					if (!"new".StartsWith(keyword))
					{
						position = -1;
						break;
					}
				}
				if (IsTextStyleEx(style))
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
					else if (c == ',' && parCount == 0 && Sci.BaseStyleAt(position) != 6)
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
				else InfoTip.Hide();
			}
			else if (position < 0) 
				return false;
			
			// get expression at cursor position
			ASExpr expr = GetExpression(Sci, position);
			DebugConsole.Trace("Expr: "+expr.Value);
			if (expr.Value == null || expr.Value.Length == 0 || expr.separator == ':'
			    || (expr.Keyword == "function" && expr.separator == ' '))
				return false;
			DebugConsole.Trace("** Display method parameters");
			DebugConsole.Trace(expr.Value);
			// Context
			expr.LocalVars = ParseLocalVars(expr);
			ASClass aClass = ASContext.CurrentClass; 
			// Expression before cursor
			ASResult result = EvalExpression(expr.Value, expr, aClass, true);
			
			// Show calltip
			if (!result.IsNull())
			{
				ASMember method = result.Member;
				if (method == null)
				{
					string constructor = ASContext.GetLastStringToken(result.Class.ClassName,".");
					method = result.Class.Methods.Search(constructor, FlagType.Constructor);
					if (method == null)
						return true;
				}
				else if ((method.Flags & FlagType.Function) == 0)
					return true;
				// calltip content
				calltipPos = position;
				calltipOffset = method.Name.Length;
				calltipDef = method.Name+"("+method.Parameters+")";
				if (method.Type.Length > 0) 
					calltipDef += " : "+method.Type;
				calltipMember = method;
				calltipDetails = UITools.ShowDetails;
				
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
			int dotIndex = expr.Value.LastIndexOf('.');
			if (dotIndex == 0) return true;
			string tail = (dotIndex >= 0) ? expr.Value.Substring(dotIndex+1) : expr.Value;
			
			DebugConsole.Trace("? "+dotIndex+" '"+expr.separator+"' "+expr.Keyword+" ."+tail);
			// complete keyword
			if (dotIndex < 0)
			{
				if (expr.Keyword == "new") return HandleNewCompletion(Sci, expr.Value, autoHide);
				else if (expr.separator == ':') {
					if (HandleColonCompletion(Sci, expr.Value, autoHide)) return true;
				}
				else if (expr.Keyword == "import")
					return HandleImportCompletion(Sci, expr.Value, autoHide);
				else if ((expr.Keyword == "extends") || (expr.Keyword == "implements"))
					return HandleNewCompletion(Sci, expr.Value, autoHide);
			}
			else if ((expr.ContextBody == null) && (expr.separator != ':') && (expr.separator != '=')
			         && (expr.Keyword != "import") && (expr.Keyword != "extends") && (expr.Keyword != "implements") )
				return true;
			
			// complete declaration
			if ((expr.ContextBody == null) && 
			    ((expr.separator == ';') || (expr.separator == ' ') || (expr.separator == '}') || (expr.separator == '{')))
			{
				if (expr.Value.IndexOf('#') >= 0) return true;
				else 
				{
					string text = " "+ASClassParser.CleanClassSource(Sci.GetText(Sci.CurrentPos), null)+" ";
					if (Regex.IsMatch(text, "[\\s](class|interface)[\\s]"))
					{
						DebugConsole.Trace("Match class");
						Match m = Regex.Match(text, "[\\s](class|interface)[\\s]+"+ASContext.CurrentClass.ClassName+"[\\s{]");
						if (m.Success)
						{
							if (text.Substring(m.Index).IndexOf('{') > 0)
								return HandleDeclarationCompletion(Sci, "function private public static var", tail, autoHide);
							else if ((expr.Keyword != "extends") && (expr.Keyword != "implements"))
								return HandleDeclarationCompletion(Sci, "extends implements", tail, autoHide);
						}
						else return true;
					}
					else if (expr.Keyword == "class") return true;
					else if (dotIndex < 0) return HandleDeclarationCompletion(Sci, "import", tail, autoHide);
				}
			}
			
			DebugConsole.Trace("** Complete expression '"+expr.separator+"' "+expr.Value.Length);
			DebugConsole.Trace(expr.Value);
			
			// Context
			expr.LocalVars = ParseLocalVars(expr);
			ASClass cClass = ASContext.CurrentClass; 
			ASResult result;
			ASClass tmpClass;
			if (dotIndex > 0)
			{
				// Expression before cursor
				result = EvalExpression(expr.Value, expr, cClass, false);
				if (result.IsNull())
					return true;
				tmpClass = result.Class;
			}
			else 
			{
				result = new ASResult();
				tmpClass = cClass;
			}
			ASMemberList mix = new ASMemberList();
			// local vars are the first thing to try
			if ((result.IsNull() || (dotIndex < 0)) && (expr.ContextFunction != null)) 
				mix.Merge(expr.LocalVars);
			
			// packages
			if (tmpClass.Package != null)
				mix.Merge(tmpClass.Package);
			
			// get all members
			FlagType mask = 0;
			if ((expr.ContextFunction != null) || (expr.separator != ':'))
			{
				// user setting may ask to hide some members
				bool limitMembers = ASContext.HideIntrinsicMembers || (autoHide && !ASContext.AlwaysShowIntrinsicMembers);
				// static or dynamic members?
				if (!result.IsNull()) 
					mask = (result.IsStatic) ? FlagType.Static : FlagType.Dynamic;
				// show private member of current class only only 
				if (!FriendClasses(cClass, tmpClass))
					mask |= FlagType.Public;
				DebugConsole.Trace("Filter members by: "+mask);
				
				// explore members
				bool classExtend = false;
				if (!limitMembers || (tmpClass.ClassName != "Object"))
				while ((tmpClass != null) && (!tmpClass.IsVoid()))
				{
					tmpClass.Sort();
					// add members
					mix.Merge(tmpClass.Methods, mask, classExtend);
					// remove constructor methods
					foreach(ASMember meth in tmpClass.Methods)
					if ((meth.Flags & FlagType.Constructor) > 0) {
						mix.Remove(meth);
						break;
					}
					mix.Merge(tmpClass.Properties, mask, classExtend);
					mix.Merge(tmpClass.Vars, mask, classExtend);
					if (result.IsStatic && (tmpClass.Package != null))
					{
						DebugConsole.Trace("Class is package "+tmpClass.ClassName);
						mix.Merge(tmpClass.Package, 0);
					}
					tmpClass = tmpClass.Extends;
					if (tmpClass != null)
					{
						// static members not inherited in AS3 
						classExtend = tmpClass.IsAS3;

						if (((tmpClass.Flags & FlagType.Intrinsic) == FlagType.Intrinsic)
					    	&& (tmpClass.FileName.StartsWith(ASContext.TopLevelClassPath)))
						{
							if (limitMembers)
								tmpClass = null;
						}
					}
				}
			}
			// known classes / toplevel vars/methods
			if (result.IsNull() || (dotIndex < 0))
			{
				mix.Merge(cClass.ToASMember());
				mix.Merge(cClass.Imports);
				mix.Merge(ASContext.TopLevel.Imports);
				mix.Merge(ASContext.TopLevel.Methods);
				mix.Merge(ASContext.TopLevel.Vars);
				mix.Merge(ASContext.GetBasePackages());
			}
			
			// show
			ArrayList list = new ArrayList();
			foreach(ASMember member in mix)
				list.Add(new MemberItem(member));
			CompletionList.Show(list, autoHide, tail);
			return true;
		}
		#endregion
		
		#region misc_completion
		static private bool HandleNewCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide)
		{
			DebugConsole.Trace("** Complete: new <class>");
			// Context
			ASClass cClass = ASContext.CurrentClass;
			
			// Consolidate known classes
			ASMemberList known = new ASMemberList();
			known.Merge(cClass.ToASMember());
			known.Merge(cClass.Imports);
			known.Merge(ASContext.TopLevel.Imports);
			known.Merge(ASContext.GetBasePackages());
			// show
			ArrayList list = new ArrayList();
			foreach(ASMember member in known)
				list.Add(new MemberItem(member));
			CompletionList.Show(list, autoHide, tail);
			return true;
		}
		
		static private bool HandleImportCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide)
		{
			DebugConsole.Trace("** Complete: import <package>");
			
			// Show
			ASMemberList known = ASContext.GetBasePackages();
			ArrayList list = new ArrayList();
			foreach(ASMember member in known)
				list.Add(new MemberItem(member));
			CompletionList.Show(list, autoHide, tail);
			return true;
		}
		
		static private bool HandleColonCompletion(ScintillaNet.ScintillaControl Sci, string tail, bool autoHide)
		{
			DebugConsole.Trace("** Complete: ':'<class>");
			// Context
			ASClass cClass = ASContext.CurrentClass;
			
			// Valid statement
			int position = Sci.CurrentPos-1;
			string keyword = null;
			int stylemask = (1 << Sci.StyleBits) -1;
			char c;
			while (position > 0) 
			{
				position--;
				c = (char)Sci.CharAt(position);
				if ((c == '{') || (c == '=')) return false;
				else if ((Sci.StyleAt(position) & stylemask) == 19)
				{
					keyword = GetWordLeft(Sci, ref position);
					DebugConsole.Trace("'"+keyword+"'");
					break;
				}
			}
			if (keyword != "var" && keyword != "function" && keyword != "get" && keyword != "set" && keyword != "const")
				return false;
			
			// Consolidate known classes
			ASMemberList known = new ASMemberList();
			known.Merge(cClass.ToASMember());
			known.Merge(cClass.Imports);
			known.Merge(ASContext.TopLevel.Imports);
			known.Merge(ASContext.GetBasePackages());
			
			// show
			ArrayList list = new ArrayList();
			foreach(ASMember member in known)
				list.Add(new MemberItem(member));
			CompletionList.Show(list, autoHide, tail);
			return true;
		}
		#endregion
		
		#region expression_evaluator
		/// <summary>
		/// Find expression type in function context
		/// </summary>
		/// <param name="expression">To evaluate</param>
		/// <param name="context">In context</param>
		/// <param name="inClass">In class</param>
		/// <param name="complete">Complete (sub-expression) or partial (dot-completion) evaluation</param>
		/// <returns>Class/member struct</returns>
		static private ASResult EvalExpression(string expression, ASExpr context, ASClass inClass, bool complete)
		{
			DebugConsole.Trace("** EvalExpression");
			DebugConsole.Trace(expression);
			ASResult notFound = new ASResult();
			Match mSub = null;
			string[] tokens = expression.Split('.');
			
			// eval first token
			string token = tokens[0];
			ASResult head;
			if (token.StartsWith("#"))
			{
				mSub = re_sub.Match(token);
				if (mSub.Success)
				{
					string subExpr = context.SubExpressions[ Convert.ToInt16(mSub.Groups["index"].Value) ];
					// parse sub expression
					subExpr = subExpr.Substring(1,subExpr.Length-2).Trim();
					ASExpr subContext = new ASExpr();
					subContext.SubExpressions = ExtractedSubex = new StringCollection();
					subExpr = re_balancedParenthesis.Replace(subExpr, new MatchEvaluator(ExtractSubex));
					Match m = re_refineExpression.Match(subExpr);
					if (!m.Success) return notFound;
					subExpr = re_dot.Replace( re_whiteSpace.Replace(m.Value, " ") , ".").Trim();
					int space = subExpr.LastIndexOf(' ');
					if (space > 0) subExpr = subExpr.Substring(space+1);
					// eval sub expression
					head = EvalExpression(subExpr, subContext, inClass, true);
					if (head.Member != null) 
						head.Class = ASContext.FindClassFromName(head.Member.Type, head.Class);
				}
				else 
				{
					token = token.Substring(token.IndexOf('~')+1);
					head = EvalVariable(token, context, inClass);
				}
			}
			else head = EvalVariable(token, context, inClass);
			
			// no head, exit
			if (head.IsNull()) return notFound;
			if (!head.IsStatic)
				DebugConsole.Trace(0+" "+token+":"+head.Class.ClassName);
			else if (head.Member != null)
				DebugConsole.Trace(0+" "+token+":"+head.Class.ClassName);
			else 
				DebugConsole.Trace(0+" "+token+"="+head.Class.ClassName);
			
			// eval tail
			int n = tokens.Length;
			if (!complete) n--;
			// context
			ASResult step = head;
			ASClass resultClass = head.Class;
			// look for static or dynamic members?
			FlagType mask = (head.IsStatic) ? FlagType.Static : FlagType.Dynamic;
			// look for public only members?
			ASClass curClass = ASContext.CurrentClass;
			if (!FriendClasses(curClass, step.Class)) 
				mask |= FlagType.Public;
			
			// explore
			for (int i=1; i<n; i++)
			{
				resultClass = step.Class;
				token = tokens[i];
				DebugConsole.Trace(i+" "+token+" "+mask);
				FindMember(token, resultClass, step, mask);
				if (step.Class == null)
					return step;
				if (!step.IsStatic) //(resultClass.Flags != FlagType.Package) && ((step.Class.Flags & FlagType.Class) == 0))
				{
					if ((mask & FlagType.Static) > 0) 
					{
						mask -= FlagType.Static;
						mask |= FlagType.Dynamic;
					}
				}
				if (!FriendClasses(curClass, step.Class))
				    mask |= FlagType.Public;
			}
			// eval package
			if (step.Class.Flags == FlagType.Package)
			{
				DebugConsole.Trace("Complete package "+step.Class.ClassName);
				step.Class.Package = ASContext.FindPackage(step.Class.ClassName, true);
			}
			return step;
		}
		
		/// <summary>
		/// Find variable type in function context 
		/// </summary>
		/// <param name="token">Variable name</param>
		/// <param name="context">In context</param>
		/// <param name="inClass">In class</param>
		/// <returns>Class/member struct</returns>
		static private ASResult EvalVariable(string token, ASExpr context, ASClass inClass)
		{
			DebugConsole.Trace("EvalVariable "+token);
			ASResult result = new ASResult();
			
			// local vars
			if (context.LocalVars != null)
			foreach(ASMember var in context.LocalVars)
			{
				if (var.Name == token)
				{
					result.inClass = null;
					result.Class = ASContext.FindClassFromName(var.Type, inClass);
					result.Member = var;
					return result;
				}
			}
			
			// method parameters
			if (context.ContextFunction != null)
			{
				Match param = Regex.Match(context.ContextFunction, "[(,][\\s]*"+Regex.Escape(token)+"[\\s:,)]");
				if (param.Success)
				{
					//DebugConsole.Trace("Method param "+token);
					param = Regex.Match(context.ContextFunction, "[(,][\\s]*"+Regex.Escape(token)+"[\\s]*:[\\s]*(?<type>[^\\s,)]*)");
					if (param.Success && (param.Groups["type"].Value.Length > 0))
					{
						//DebugConsole.Trace("Type "+param.Groups["type"].Value);
						result.Class = ASContext.FindClassFromName(param.Groups["type"].Value, inClass);
					}
					return result;
				}
			}
			
			// class members
			FindMember(token, inClass, result, 0);
			if (!result.IsNull())
				return result;
			
			// top-level elements
			if (!ASContext.TopLevel.IsVoid())
			{
				FindMember(token, ASContext.TopLevel, result, 0);
				if (!result.IsNull())
					return result;
				// special _levelN
				if (token.StartsWith("_") && re_level.IsMatch(token))
				{
					result.Class = ASContext.FindClassFromName("MovieClip", null);
					return result;
				}
			}
			
			// classes
			int p = token.IndexOf('#');
			string ctoken = (p > 0) ? token.Substring(0,p) : token;
			ASClass aClass = ASContext.FindClassFromName(ctoken, inClass);
			if (!aClass.IsVoid())
			{
				result.Class = aClass;
				result.IsStatic = (p < 0);
				return result;
			}
			
			// packages folders
			ASMemberList package = ASContext.FindPackage(token, false);
			if (package != null)
			{
				result.Class = new ASClass();
				result.Class.ClassName = token;
				result.Class.Flags = FlagType.Package;
				result.Class.Package = package;
				result.IsStatic = true;
			}
			return result;
		}
		
		/// <summary>
		/// Match token to a class' member
		/// </summary>
		/// <param name="token">To match</param>
		/// <param name="inClass">In given class</param>
		/// <param name="result">Class/Member struct</param>
		static private void FindMember(string token, ASClass inClass, ASResult result, FlagType mask)
		{
			DebugConsole.Trace("FindMember "+token+" "+mask);
			ASMember found = null;
			ASClass tmpClass = inClass;
			if (inClass == null) return;
			// variable
			int p = token.IndexOf('#');
			if (p < 0)
			{
				// member
				while ((tmpClass != null) && !tmpClass.IsVoid())
				{
					found = tmpClass.Properties.Search(token, mask);
					if (found != null) break;
					found = tmpClass.Vars.Search(token, mask);
					if (found != null) break;
					found = tmpClass.Methods.Search(token, mask);
					if (found != null) 
					{
						// static members not inherited in AS3
						if (tmpClass != inClass && (found.Flags & FlagType.Static) > 0 && inClass.IsAS3)
							return;
						//DebugConsole.Trace("Method of "+tmpClass.ClassName);
						result.Member = found;
						if ((result.Member.Flags & FlagType.Constructor) > 0)
						{
							result.Class = tmpClass;
							result.IsStatic = true;
						}
						else 
						{
							result.inClass = tmpClass;
							result.Class = ASContext.FindClassFromName("Function", null);
							result.IsStatic = false; //((found.Flags & FlagType.Static) > 0);
						}
						//DebugConsole.Trace("Found static "+found.Name+":"+result.Class.ClassName+" in "+tmpClass.ClassName);
						return;
					}
					tmpClass = tmpClass.Extends;
				}
			}
			// method
			else 
			{
				token = token.Substring(0,p);
				while ((tmpClass != null) && !tmpClass.IsVoid())
				{
					found = tmpClass.Methods.Search(token, mask);
					if (found != null) 
					{
						// static members not inherited in AS3
						if (tmpClass != inClass && (found.Flags & FlagType.Static) > 0 && inClass.IsAS3)
							return;
						
						if ((found.Flags & FlagType.Constructor) > 0)
						{
							result.Class = tmpClass;
							result.Member = found;
							result.IsStatic = false;
							return;
						}
						break;
					}
					tmpClass = tmpClass.Extends;
				}
			}
			
			// result found!
			if (found != null)
			{
				result.inClass = tmpClass;
				result.Class = ASContext.FindClassFromName(found.Type, tmpClass);
				result.Member = found;
				result.IsStatic = false; //((found.Flags & FlagType.Static) > 0);
				DebugConsole.Trace("Found "+found.Name+":"+result.Class.ClassName+" in "+tmpClass.ClassName);
				return;
			}
			// try subpackages
			else if (inClass.Package != null)
			{
				DebugConsole.Trace("Find "+token+" as "+inClass.ClassName+"."+token);
				result.Class = ASContext.FindClassFromName(inClass.ClassName.Replace(System.IO.Path.DirectorySeparatorChar,'.')+"."+token, null);
				if (!result.Class.IsVoid()) 
					return;
				
				// sub packages?
				ASMemberList list = ASContext.FindPackage(inClass.ClassName, false);
				if (list != null || inClass.Flags == FlagType.Package)
				{
					result.Class = new ASClass();
					result.Class.ClassName = inClass.ClassName+System.IO.Path.DirectorySeparatorChar+token;
					result.Class.Flags = FlagType.Package;
					result.Class.Package = list;
					result.IsStatic = true;
					return;
				}
			}
			
			// not found
			result.Class = null;
			result.Member = null;
			DebugConsole.Trace(token+" not found in "+inClass.ClassName);
		}
		
		#endregion
	
		#region main_code_parser
		static private StringCollection ExtractedSubex;
		
		/// <summary>
		/// Find Actionscript expression at cursor position
		/// TODO  Improve this method
		/// </summary>
		/// <param name="sci">Scintilla Control</param>
		/// <param name="position">Cursor position</param>
		/// <returns></returns>
		static private ASExpr GetExpression(ScintillaNet.ScintillaControl Sci, int position)
		{
			ASExpr expression = new ASExpr();
			int startPos = position;
			expression.Position = position;
			expression.separator = ' ';
			
			// get last expression (until ';') excluding comments
			int stylemask = (1 << Sci.StyleBits) -1;
			int style = (position > 0) ? Sci.StyleAt(position-1) & stylemask : 0;
			bool ignoreKey = false;
			if (style == 19)
			{
				DebugConsole.Trace("Ignore keyword");
				ignoreKey = true;
			}
			StringBuilder sb = new StringBuilder();
			char c;
			while ((position > 0) && (style != 19 || ignoreKey)) 
			{
				position--;
				style = Sci.StyleAt(position) & stylemask;
				if (IsTextStyle(style) || ignoreKey)
				{
					c = (char)Sci.CharAt(position);
					if (c == ';')
					{
						expression.separator = c;
						break;
					}
					else if (c == '\n' || c == '\r')
					{
						if (sb.ToString().Trim().Length == 0) 
							break;
					}
					sb.Insert(0,c);
					if (ignoreKey && IsTextStyle(style)) ignoreKey = false;
				}
				// we found a keyword
				else if (style == 19)
				{
					expression.separator = ' ';
					int keywordPos = position;
					string keyword = GetWordLeft(Sci, ref keywordPos);
					
					if ((keyword == "function") || (keyword == "get") || (keyword == "set"))
					{
						// we found a function declaration
						string test = sb.ToString().Trim();
						
						// ignore anonymous function
						if ((keyword == "function") && test.StartsWith("("))
						{
							keyword = null;
							break;
						}
						
						// guess context more precisely
						bool hasBraces = (test.IndexOf('{') >= 0);
						test = re_balancedBraces.Replace(test, ";");
						
						// is it inside the function?
						if (test.IndexOf('{') >= 0)
						{
							c = ' ';
							while ((position < startPos) && (sb.Length > 0))
							{
								position++;
								c = (char)Sci.CharAt(position);
								sb.Remove(0,1);
								if (c == '{') break;
							}
							expression.separator = c;
						}
						// is it NOT inside function parameters?
						else if (test.IndexOf(')') >= 0)
						{
							if (hasBraces)
							{
								expression.separator = '}';
								expression.Value = "";
								return expression;
							}
							else
							{
								// is it before the return type declaration?
								int colon = test.LastIndexOf(':');
								if ((colon < 0) || (colon < test.LastIndexOf(')')))
									// this is invalid
									return expression;
							}
						}
						// inside function parameters?
						else
						{
							int colon = test.LastIndexOf(':');
							if ((colon < 0) || (colon < test.LastIndexOf(',')))
								return expression;
						}
					}
					else expression.Keyword = keyword;
					
					// note that we found a "case" statement
					//else if (keyword == "case") expression.Keyword = "case";
					
					DebugConsole.Trace("Stopped at '"+keyword+"'");
					DebugConsole.Trace("Raw '"+sb.ToString()+"'");
					break;
				}
			}
			position++;
			string expr = sb.ToString();
			
			sb = null;
			if (expr.Length > 0 && (expr[expr.Length-1] <= 32 && Sci.CharAt(startPos) != '('))
			{
				expr = "";
				expression.separator = ' ';
				expression.Position = Sci.CurrentPos;
			}
			else expression.PositionExpression = position;
			
			// refine last expression
			if (expr.Length > 0) 
			{
				expr = re_balancedBraces.Replace(expr, ";");
				expression.SubExpressions = ExtractedSubex = new StringCollection();
				expr = re_balancedParenthesis.Replace(expr, new MatchEvaluator(ExtractSubex));
				//DebugConsole.Trace("Raw '"+expr+"' @"+expression.PositionExpression);
				Match m = re_refineExpression.Match(expr);
				if (!m.Success) return expression;
				if (m.Index > 0)
				{
					expression.separator = expr[m.Index-1];
					expression.PositionExpression = position += m.Index;
					// treat ':' as ';' after a case statement
					if (expression.separator == ':' && expression.Keyword == "case") expression.separator = ';';
					expression.Keyword = null;
				}
				//DebugConsole.Trace("Refined '"+m.Value+"' @"+m.Index);
				expr = re_dot.Replace( re_whiteSpace.Replace(m.Value, " ") , ".");
				expr = re_subexMarker.Replace(expr, "#").Trim();
				int space = Math.Max(expr.LastIndexOf(' '), expr.LastIndexOf(';'));
				if (space > 0) 
				{
					expression.separator = ' ';
					expr = expr.Substring(space+1);
				}
				//ErrorHandler.ShowInfo("Clean '"+expr+"' @"+expression.PositionExpression);
			}
			expression.Value = expr;
			
			// get context function body
			int braceCount = 0;
			StringBuilder body = new StringBuilder();
			StringBuilder context = new StringBuilder();
			while (braceCount >= 0)
			{
				while (position > 0) 
				{
					position--;
					style = Sci.StyleAt(position) & stylemask;
					if (IsTextStyleEx(style))
					{
						c = (char)Sci.CharAt(position);
						if (c == '}') 
						{
							body.Insert(0,c);
							braceCount++;
						}
						else if ((c == '{') && (--braceCount < 0)) break;
						if (braceCount == 0) body.Insert(0,c);
					}
				}
				if (braceCount >= 0) break;
				
				// get context function definition
				while (position > 0) 
				{
					position--;
					style = Sci.StyleAt(position) & stylemask;
					if (IsTextStyleEx(style))
					{
						c = (char)Sci.CharAt(position);
						if ((c == ';') || (c == '}') || (c == '{')) break;
						context.Insert(0,c);
					}
				}
				expression.ContextFunction = context.ToString();
				
				// ignore dynamic function definition
				if (!re_validFunction.IsMatch(expression.ContextFunction)) 
				{
					// stop if we reached the class definition
					if (re_classDefinition.IsMatch(expression.ContextFunction)) 
					{
						expression.ContextFunction = null;
						expression.PositionContext = 0;
						break;
					}
					// continue search for function definition
					body.Insert(0,'{').Insert(0,context.ToString());
					context = new StringBuilder();
					position++;
					braceCount++;
				}
				else {
					expression.ContextBody = body.ToString();
					expression.PositionContext = position+1;
				}
			}
			// result
			LastExpression = expression;
			return expression;
		}
		
		/// <summary>
		/// Parse function body for local var definitions
		/// TODO  ASComplete: parse coma separated local vars definitions
		/// </summary>
		/// <param name="expression">Expression source</param>
		/// <returns>Local vars dictionnary (name, type)</returns>
		static public ASMemberList ParseLocalVars(ASExpr expression)
		{
			ASMemberList vars = new ASMemberList();
			if ((expression.ContextBody == null) || (expression.ContextBody.Length == 0)) 
				return vars;
			// parse
			MatchCollection mcVars = re_variable.Matches(";"+expression.ContextBody);
			Match mVar;
			Match mType;
			string type;
			ASMember var;
			foreach(Match m in mcVars) 
			{
				mVar = re_splitVariable.Match(m.Value);
				if (!mVar.Success) 
					continue;
				mType = re_variableType.Match(mVar.Groups["type"].Value);
				if (mType.Success) type = mType.Groups["type"].Value;
				else type = "Object";
				var = new ASMember();
				var.Flags = FlagType.Variable | FlagType.Dynamic;
				var.Name = mVar.Groups["pname"].Value;
				var.Type = type;
				vars.Add(var);
			}
			// method parameters
			vars.Merge( ParseMethodParameters(expression.ContextFunction) );
			return vars;
		}
		
		/// <summary>
		/// Returns parameters string as member list
		/// </summary>
		/// <param name="parameters">Method parameters</param>
		/// <returns>Member list</returns>
		static public ASMemberList ParseMethodParameters(string parameters)
		{
			ASMemberList list = new ASMemberList();
			if (parameters == null) 
				return list;
			int p = parameters.IndexOf('(');
			if (p >= 0)
				parameters = parameters.Substring(p+1, parameters.IndexOf(')')-p-1);
			parameters = parameters.Trim();
			if (parameters.Length == 0) 
				return list;
			string[] sparam = parameters.Split(',');
			string[] parType;
			ASMember param;
			foreach(string pt in sparam)
			{
				parType = pt.Split(':');
				param = new ASMember();
				param.Name = parType[0].Trim();
				if (param.Name.Length == 0) 
					continue;
				if (parType.Length == 2) param.Type = parType[1].Trim();
				else param.Type = "Object";
				param.Flags = FlagType.Variable | FlagType.Dynamic;
				list.Add(param);
			}
			return list;
		}
		
		/// <summary>
		/// Extract sub-expressions
		/// </summary>
		static private string ExtractSubex(Match m) 
		{
			return "#"+ExtractedSubex.Add( m.Value )+"~";
		}
		#endregion
		
		#region tools_functions		
		static public bool IsTextStyle(int style)
		{
			return (style == 0) || (style == 4) || (style == 5) || /*(style == 6) ||*/ (style == 10) || (style == 11) || (style == 16);
		}
		
		static public bool IsTextStyleEx(int style)
		{
			return (style == 0) || (style == 4) || (style == 5) || (style == 6) || (style == 10) || (style == 11) || (style == 16) || (style == 19);
		}
		
		static public bool IsCommentStyle(int style)
		{
			return (style == 1) || (style == 2) || (style == 3) || (style == 17) || (style == 18);
		}
		
		static public string GetWordLeft(ScintillaNet.ScintillaControl Sci, ref int position)
		{
			string word = "";
			string exclude = "(){};,+*/\\=:.%\"<>";
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
					else if (exclude.IndexOf(c) >= 0) break;
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
			ASExpr expr = GetExpression(sci, position);
			if ((expr.Value == null) || (expr.Value.Length == 0))
				return new ASResult();
			// Context
			expr.LocalVars = ParseLocalVars(expr);
			ASClass aClass = ASContext.CurrentClass; 
			// Expression before cursor
			return EvalExpression(expr.Value, expr, aClass, true);			
		}
		
		/// <summary>
		/// Check wether 'aClass' has acces to 'bClass' private methods
		/// </summary>
		static public bool FriendClasses(ASClass aClass, ASClass bClass)
		{
			ASClass tmpClass = aClass;
			while (tmpClass != null)
			{
				if (tmpClass == bClass)
					return true;
				tmpClass = tmpClass.Extends;
			}
			return false;
		}
		
		/*/// <summary>
		/// List implicit known classes to a class: ie. the class, the extended class, implemented classes
		/// UPDATE: MTASC doesn't automatically known the extended classes
		/// </summary>
		/// <param name="cClass">Reference</param>
		/// <returns>List of members</returns>
		static private ASMemberList GetContextClassesList(ASClass cClass)
		{
			// current class
			ASMemberList list = new ASMemberList();
			list.Add(cClass.ToASMember());
			
			// inheritance
			ASClass tmpClass = cClass.Extends;
			while(tmpClass != null && !tmpClass.IsVoid() 
			    && !tmpClass.FileName.StartsWith(ASContext.TopLevelClassPath))
			{
				list.Add(tmpClass.ToASMember());
				tmpClass = tmpClass.Extends;
			}
			if (list.Count > 1) 
				list.Sort();
			
			// TODO  add other implicitly known classes from the classpath, like interfaces
			return list;
		}*/
		#endregion
		
		#region tooltips formatting
		static public string GetToolTipText(ASResult result)
		{
			if ((result.Member != null) && (result.inClass != null))
				{
					string text = MemberTooltipText(result.Member, result.inClass);
					if (result.inClass == ASContext.TopLevel)
						text = text.Substring(0, text.IndexOf('\n'));
					return text;
				}
				else if ((result.Member != null) && ((result.Member.Flags & FlagType.Constructor) != FlagType.Constructor))
				{
					return ASClass.MemberDeclaration(result.Member);
				}
				else if (result.inClass != null)
				{
					return ASClass.ClassDeclaration(result.inClass);
				}
				else if (result.Class != null) 
				{
					return ASClass.ClassDeclaration(result.Class);
				}
				else return null;
		}
		
		static private string MemberTooltipText(ASMember member, ASClass inClass)
		{
			// modifiers
			FlagType ft = member.Flags;
			string modifiers = "";
			if ((ft & FlagType.Class) == 0)
			{
				if ((ft & FlagType.Static) > 0)
					modifiers += "static ";
				if ((ft & FlagType.Private) > 0)
					modifiers += "private ";
				else if ((ft & FlagType.Public) > 0)
					modifiers += "public ";
			}
			// signature
			if ((ft & FlagType.Function) > 0)
				return String.Format("{0}function {1}\nin {2}", modifiers, member.ToString(), inClass.ClassName);
			else if ((ft & FlagType.Variable) > 0)
				return String.Format("{0}var {1}\nin {2}", modifiers, member.ToString(), inClass.ClassName);
			else if ((ft & (FlagType.Getter | FlagType.Setter)) > 0)
				return String.Format("{0}property {1}\nin {2}", modifiers, member.ToString(), inClass.ClassName);
			else
				return String.Format("{0}{1}\nin {2}", modifiers, member.ToString(), inClass.ClassName);
		}
		#endregion
		
		#region automatic code generation
		static private ASExpr LastExpression;
		
		/// <summary>
		/// Automatically insert import statement when typing a full classname with package
		/// and remove package before the class
		/// </summary>
		/// <param name="label">Completion item label</param>
		/// <param name="type">Completion item type</param>
		/// <returns></returns>
		static private string CodeAutoOnComplete(string label, FlagType type)
		{
			if (type == 0 && ASContext.AutoImportsEnabled && LastExpression != null)
			{
				// context
				string key = LastExpression.Keyword;
				if (key != null && (key == "import" || key == "extends" || key == "implements" || key == "package"))
					return label;
				
				ScintillaNet.ScintillaControl sci = ASContext.MainForm.CurSciControl;
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
					return label;
				
				// check if import is already known;
				int p = package.LastIndexOf('.');
				if (p < 0) 
					return label;
				package = package.Substring(0, p+1)+label;
				ASClass cClass = ASContext.CurrentClass;
				foreach(ASMember import in cClass.Imports)
				if (import.Type == package) 
					return label;
				
				// insert import
				string statement = "import "+package+";"+ASContext.MainForm.GetNewLineMarker(sci.EOLMode);
				int endPos = sci.CurrentPos;
				int position = endPos;
				int line = 0;
				int firstLine = 0;
				int curLine = sci.LineFromPosition(position);
				bool found = false;
				string txt;
				Match mImport;
				while (line < curLine)
				{
					txt = sci.GetLine(line++).TrimStart();
					// HACK  insert imports after AS3 package declaration
					if (txt.StartsWith("package"))
					{
						statement = '\t'+statement;
						firstLine = (txt.IndexOf('{') < 0) ? line+1 : line;
					}
					else if (txt.StartsWith("import")) 
					{
						found = true;
						// insérer dans l'ordre alphabetique
						mImport = ASClassParser.re_import.Match(txt);
						if (mImport.Success && 
						    String.Compare(mImport.Groups["package"].Value, package) > 0)
						{
							line--;
							break;
						}
					}
					else if (found)  {
						line--;
						break;
					}
				}
				if (line == curLine) line = firstLine;
				position = sci.PositionFromLine(line);
				line = sci.FirstVisibleLine;
				sci.SetSel(position, position);
				sci.ReplaceSel(statement);
				sci.LineScroll(0, line-sci.FirstVisibleLine+1);
				
				// prepare insertion of the term as usual
				startPos += statement.Length;
				endPos += statement.Length;
				sci.SetSel(startPos, endPos);
			}
			return label;
		}
		
		/// <summary>
		/// Some characters can fire code generation
		/// </summary>
		/// <param name="sci">Scintilla control</param>
		/// <param name="value">Character</param>
		/// <returns>Code was generated</returns>
		static private bool CodeAutoOnChar(ScintillaNet.ScintillaControl sci, int value)
		{
			if (!ASContext.AutoImportsEnabled) 
				return false;
			
			int position = sci.CurrentPos;
			
			if (value == '*' && position > 1 && sci.CharAt(position-2) == '.' && LastExpression != null)
			{
				// context
				string key = LastExpression.Keyword;
				if (key != null && (key == "import" || key == "extends" || key == "implements" || key == "package"))
					return false;
				
				ASResult context = EvalExpression(LastExpression.Value, LastExpression, ASContext.CurrentClass, true);
				if (context.IsNull() || context.Class.Flags != FlagType.Package)
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
				string statement = "import "+package+"*;"+ASContext.MainForm.GetNewLineMarker(sci.EOLMode);
				int endPos = sci.CurrentPos;
				int line = 0;
				int curLine = sci.LineFromPosition(position);
				int firstLine = 0;
				bool found = false;
				string txt;
				Match mImport;
				while (line < curLine)
				{
					txt = sci.GetLine(line++).TrimStart();
					// HACK  insert imports after AS3 package declaration
					if (txt.StartsWith("package"))
					{
						statement = '\t'+statement;
						firstLine = (txt.IndexOf('{') < 0) ? line+1 : line;
					}
					else if (txt.StartsWith("import")) 
					{
						found = true;
						// insérer dans l'ordre alphabetique
						mImport = ASClassParser.re_import.Match(txt);
						if (mImport.Success && 
						    String.Compare(mImport.Groups["package"].Value, package) > 0)
						{
							line--;
							break;
						}
					}
					else if (found)  {
						line--;
						break;
					}
				}
				if (line == curLine) line = firstLine;
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
				ASClass cClass = ASContext.CurrentClass;
				ArrayList list = new ArrayList();
				foreach(ASMember import in cClass.Imports)
				if (import.Type.StartsWith(package))
					list.Add(new MemberItem(import));
				CompletionList.Show(list, false);
				return true;
			}
			return false;
		}
		
		#endregion
		
		#region completion list
		/// <summary>
		/// Class member completion list item
		/// </summary>
		private class MemberItem : ICompletionListItem
		{
			private ASMember member;
			private int icon;
			
			public MemberItem(ASMember oMember) 
			{
				member = oMember;
				FlagType type = member.Flags;
				icon = 0;
				if ((type & FlagType.Function) > 0)
					icon = ((type & FlagType.Private) > 0) ? 12 : 3;
				else if ((type & FlagType.Variable) > 0)
					icon = ((type & FlagType.Private) > 0) ? 14 : 5;
				else if ((type & (FlagType.Getter | FlagType.Setter)) > 0)
					icon = ((type & FlagType.Private) > 0) ? 13 : 4;
				else if ((type & FlagType.Intrinsic) > 0)
					icon = 7;
				else if (type == FlagType.Package)
					icon = 6;
				else if ((type & FlagType.Template) > 0)
					icon = 8;
			}
			
			public string Label { 
				get { return member.Name; }
			}
			
			public string Description { 
				get {
					string ret = ASClass.MemberDeclaration(member) + ASDocumentation.GetTipDetails(member, null);
					return ret;
				}
			}
			
			public System.Drawing.Bitmap Icon {
				get { return (System.Drawing.Bitmap)ASContext.Panel.treeIcons.Images[icon]; }
			}
			
			public string Value { 
				get { 
					return ASComplete.CodeAutoOnComplete(member.Name, member.Flags);
				}
			}
		}
		
		/// <summary>
		/// Template completion list item
		/// </summary>
		private class TemplateItem : ICompletionListItem
		{
			private string label;
			
			public TemplateItem(string label) 
			{
				this.label = label;
			}
			
			public string Label { 
				get { return label; }
			}
			public string Description { 
				get { return "Declaration template"; }
			}
			
			public System.Drawing.Bitmap Icon {
				get { return (System.Drawing.Bitmap)ASContext.Panel.treeIcons.Images[7]; }
			}
			
			public string Value { 
				get { return label; }
			}
		}
		#endregion
	}
	
	#region expressions_structures
	/// <summary>
	/// Parsed expression with it's function context
	/// </summary>
	sealed public class ASExpr
	{
		public int Position;
		public int PositionExpression;
		public int PositionContext;
		public string Value;
		public char separator;
		public StringCollection SubExpressions;
		public string ContextFunction;
		public string ContextBody;
		public ASMemberList LocalVars;
		public string Keyword;
	}
	
	/// <summary>
	/// Expressions/tokens evaluation result
	/// </summary>
	sealed public class ASResult
	{
		public ASClass Class;
		public ASClass inClass;
		public ASMember Member;
		public bool IsStatic;
		
		public bool IsNull()
		{
			return ((Class == null) && (Member == null));
		}
	}
	#endregion
}


