/*
 * Documentation completion/generation
 */

using System;
using System.Text;
using System.Collections;
using System.Text.RegularExpressions;
using PluginCore.Controls;

namespace ASCompletion
{
	public struct CommentBlock
	{
		public string Description;
		public string InfoTip;
		public string Return;
		public ArrayList ParamName;
		public ArrayList ParamDesc;
		public ArrayList TagName;
		public ArrayList TagDesc;
	}
	
	public class ASDocumentation
	{
		static public readonly string DEFAULT_DOC_TAGS = 
			"author exception deprecated link mtasc param return see serial serialData serialField since throws usage version";
		static private ArrayList docVariables;
		static private BoxItem boxSimpleClose;
		static private BoxItem boxMethodParams;
		
		#region regular_expressions
		// function declaration
		static private readonly Regex re_functionDeclaration =
			new Regex("[\\s\\w]*[\\s]function[\\s][\\s\\w$]+\\($", ASClassParser.ro_cs);
		#endregion
		
		static ASDocumentation()
		{
			boxSimpleClose = new BoxItem("Empty");
			boxMethodParams = new BoxItem("Method details");
		}
		
		#region Comments generation
		static public bool OnChar(ScintillaNet.ScintillaControl Sci, int Value, int position, int style)
		{
			if (style == 3)
			{
				switch (Value)
				{
					// documentation tag
					case '@':
						return HandleDocTagCompletion(Sci);
					
					// documentation bloc
					case '*':
						if ((position > 2) && (Sci.CharAt(position-3) == '/') && (Sci.CharAt(position-2) == '*')
					        && ((position == 3) || (Sci.BaseStyleAt(position-4) != 3)))
						HandleBoxCompletion(Sci, position);
						break;
				}
			}
			return false;
		}
		
		static private void CompleteTemplate(string Context)
		{
			// get indentation
			ScintillaNet.ScintillaControl Sci = ASContext.MainForm.CurSciControl;
			if (Sci == null) return;
			int position = Sci.CurrentPos;
			int line = Sci.LineFromPosition(position);
			int indent = Sci.LineIndentPosition(line) - Sci.PositionFromLine(line);
			string tab = Sci.GetLine(line).Substring(0, indent);
			// get EOL
			int eolMode = Sci.EOLMode;
			string newline;
			if (eolMode == 0) newline = "\r\n";
			else if (eolMode == 1) newline = "\r";
			else newline = "\n";
			
			// empty box
			if (Context == null)
			{
				Sci.ReplaceSel(newline+tab+"* "+newline+tab+"*/");
				position += newline.Length+tab.Length+2;
				Sci.SetSel(position, position);
			}
			
			// method details
			else
			{
				string box = newline+tab+"* ";
				Match mFun = ASClassParser.re_splitFunction.Match(Context);
				if (mFun.Success)
				{
					// parameters
					ASMemberList list = ASComplete.ParseMethodParameters(mFun.Groups["params"].Value);
					foreach(ASMember param in list)
						box += newline+tab+"* @param\t"+param.Name;
					// return type
					Match mType = ASClassParser.re_variableType.Match(mFun.Groups["type"].Value);
					if (mType.Success && (mType.Groups["type"].Value.ToLower() != "void"))
						box += newline+tab+"* @return"; //+mType.Groups["type"].Value;
				}
				box += newline+tab+"*/";
				Sci.ReplaceSel(box);
				position += newline.Length+tab.Length+2;
				Sci.SetSel(position, position);
			}
		}
		
		static private bool HandleDocTagCompletion(ScintillaNet.ScintillaControl Sci)
		{
			string txt = Sci.GetLine(Sci.LineFromPosition(Sci.CurrentPos)).TrimStart();
			if (!Regex.IsMatch(txt, "^\\*[\\s]*\\@"))
				return false;
			DebugConsole.Trace("Documentation tag completion");
			
			// build tag list
			if (docVariables == null)
			{
				docVariables = new ArrayList();
				TagItem item;
				string[] tags = ASContext.DocumentationTags.Split(' ');
				foreach(string tag in tags)
				{
					item = new TagItem(tag);
					docVariables.Add(item);
				}				
			}
			
			// show
			CompletionList.Show(docVariables, true, "");
			return true;
		}
		
		static private bool HandleBoxCompletion(ScintillaNet.ScintillaControl Sci, int position)
		{
			DebugConsole.Trace("Documentation tag completion");
			// is the block before a function declaration?
			int len = Sci.TextLength-1;
			char c;
			StringBuilder sb = new StringBuilder();
			while (position < len)
			{
				c = (char)Sci.CharAt(position);
				sb.Append(c);
				if ((c == '(') || (c == ';') || (c == '{')) break;
				position++;
			}
			string signature = sb.ToString();
			if (re_functionDeclaration.IsMatch(signature))
			{
				// get method signature
				position++;
				while (position < len)
				{
					c = (char)Sci.CharAt(position);
					sb.Append(c);
					if ((c == ';') || (c == '{')) break;
					position++;
				}
				signature = sb.ToString();
			}
			else signature = null;
			
			// build templates list
			ArrayList templates = new ArrayList();
			if (signature != null)
			{
				boxMethodParams.Context = signature;
				templates.Add(boxMethodParams);
			}
			templates.Add(boxSimpleClose);
			
			// show
			CompletionList.Show(templates, true, "");
			return true;
		}
		#endregion
		
		#region Tooltips
		
		static private CommentBlock ParseComment(string comment)
		{
			// cleanup
			comment = Regex.Replace(comment, "^[ \t*]+", "");
			comment = Regex.Replace(comment, "[ \t*]+$", "", RegexOptions.RightToLeft);
			string[] lines = Regex.Split(comment, "[\r\n]+");
			int p;
			comment = "";
			foreach(string line in lines)
			{
				p = line.IndexOf('*');
				if (p < 0) comment += '\n'+line.TrimStart();
				else if (p+1 < line.Length) 
				{
					if (line[p+1] == ' ') p++;
					comment += '\n'+line.Substring(p+1);
				}
			}
			// extraction
			CommentBlock cb = new CommentBlock();
			MatchCollection tags = Regex.Matches(comment, "\n@(?<tag>[a-z]+)\\s");
			
			if (tags.Count == 0)
			{
				cb.Description = comment.Trim();
				return cb;
			}
			
			if (tags[0].Index > 0) cb.Description = comment.Substring(0, tags[0].Index).Trim();
			else cb.Description = "";
			cb.TagName = new ArrayList();
			cb.TagDesc = new ArrayList();
			
			Group gTag;
			for(int i=0; i<tags.Count; i++)
			{
				gTag = tags[i].Groups["tag"];
				string tag = gTag.Value;
				int start = gTag.Index+gTag.Length;
				int end = (i<tags.Count-1) ? tags[i+1].Index : comment.Length;
				string desc = comment.Substring(start, end-start).Trim();
				if (tag == "param")
				{
					Match mParam = Regex.Match(desc, "(?<var>[\\w$]+)\\s");
					if (mParam.Success)
					{
						Group mVar = mParam.Groups["var"];
						if (cb.ParamName == null) {
							cb.ParamName = new ArrayList();
							cb.ParamDesc = new ArrayList();
						}
						cb.ParamName.Add(mVar.Value);
						cb.ParamDesc.Add(desc.Substring(mVar.Index+mVar.Length).TrimStart());
					}
				}
				else if (tag == "return")
				{
					cb.Return = desc;
				}
				else if (tag == "infotip")
				{
					cb.InfoTip = desc;
					if (cb.Description.Length == 0) cb.Description = cb.InfoTip;
				}
				cb.TagName.Add(tag);
				cb.TagDesc.Add(desc);
			}
			return cb;
			
		}
		
		static public string GetTipDetails(ASMember member, string highlightParam)
		{
			try
			{
				return (UITools.ShowDetails) ? GetTipFullDetails(member, highlightParam) : GetTipShortDetails(member, highlightParam);
			}
			catch(Exception ex)
			{
				PluginCore.ErrorHandler.ShowError("Error while parsing comments.\n"+ex.Message, ex);
				return "";
			}
		}
		
		/// <summary>
		/// Short contextual details to display in tips
		/// </summary>
		/// <param name="member">Member data</param>
		/// <param name="highlightParam">Parameter to detail</param>
		/// <returns></returns>
		static public string GetTipShortDetails(ASMember member, string highlightParam)
		{
			if (member == null || member.Comments == null || !ASContext.DocumentationInTips) return "";
			CommentBlock cb = ParseComment(member.Comments);
			string details = " …";
			
			// get parameter detail
			if (highlightParam != null && highlightParam.Length > 0)
			{
				if (cb.ParamName != null)
				for(int i=0; i<cb.ParamName.Count; i++)
				{
					if (highlightParam == (string)cb.ParamName[i]) {
						details += "\n[B]"+highlightParam+":[/B] "+(string)cb.ParamDesc[i];
						return details;
					}
				}
			}
			// get description extract
			if (ASContext.DescriptionInTips)
			{
				if (cb.InfoTip != null && cb.InfoTip.Length > 0) details += "\n"+cb.InfoTip;
				else if (cb.Description != null && cb.Description.Length > 0) 
				{
					string[] lines = cb.Description.Split('\n');
					int n = Math.Min(lines.Length, 2);
					for(int i=0; i<n; i++) details += "\n"+lines[i];
					if (lines.Length > 2) details += " …";
				}
			}
			return details;
		}
		
		/// <summary>
		/// Extract member comments for display in the completion list
		/// </summary>
		/// <param name="member">Member data</param>
		/// <param name="member">Parameter to highlight</param>
		/// <returns>Formated comments</returns>
		static public string GetTipFullDetails(ASMember member, string highlightParam)
		{
			if (member == null || member.Comments == null || !ASContext.DocumentationInTips) return "";
			CommentBlock cb = ParseComment(member.Comments);
			
			// details
			string details = "";
			if (cb.Description.Length > 0) 
			{
				string[] lines = cb.Description.Split('\n');
				int n = Math.Min(lines.Length, ASContext.TipsDescriptionMaxLines);
				for(int i=0; i<n; i++) details += lines[i]+"\n";
				if (lines.Length > ASContext.TipsDescriptionMaxLines) details = details.TrimEnd()+" …\n";
			}
			
			// @usage
			if (cb.TagName != null)
			{
				bool hasUsage = false;
				for(int i=0; i<cb.TagName.Count; i++)
				if ((string)cb.TagName[i] == "usage") 
				{
					hasUsage = true;
					details += "\n    "+(string)cb.TagDesc[i];
				}
				if (hasUsage) details += "\n";
			}
			
			// @param
			if (cb.ParamName != null && cb.ParamName.Count > 0)
			{
				details += "\nParam:";
				for(int i=0; i<cb.ParamName.Count; i++)
				{
					details += "\n    ";
					if (highlightParam == (string)cb.ParamName[i]) details += "[B]"+highlightParam+"[/B]: ";
					else details += cb.ParamName[i]+": ";
					details += (string)cb.ParamDesc[i];
				}
			}
			
			// @return
			if (cb.Return != null)
			{
				details += "\n\nReturn:\n    "+cb.Return;
			}
			return "\n\n"+details.Trim();
		}
		#endregion
		
		#region Completion items
		/// <summary>
		/// Box template completion list item
		/// </summary>
		private class BoxItem : ICompletionListItem
		{
			private string label;
			public string Context;
			
			public BoxItem(string label) 
			{
				this.label = label;
			}
			
			public string Label { 
				get { return label; }
			}
			public string Description { 
				get { return "Documentation box template"; }
			}
			
			public System.Drawing.Bitmap Icon {
				get { return (System.Drawing.Bitmap)ASContext.Panel.treeIcons.Images[7]; }
			}
			
			public string Value { 
				get {
					ASDocumentation.CompleteTemplate(Context);
					return null;
				}
			}
		}
		
		/// <summary>
		/// Documentation tag template completion list item
		/// </summary>
		private class TagItem : ICompletionListItem
		{
			private string label;
			
			public TagItem(string label) 
			{
				this.label = label;
			}
			
			public string Label { 
				get { return label; }
			}
			public string Description { 
				get { return "Documentation tag template"; }
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

}
