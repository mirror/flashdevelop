/*
 * Documentation completion/generation
 */

using System;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Diagnostics;
using PluginCore;
using PluginCore.Managers;
using PluginCore.Controls;
using ASCompletion.Model;
using ASCompletion.Context;
using PluginCore.Localization;

namespace ASCompletion.Completion
{
	public class CommentBlock
	{
		public string Description;
		public string InfoTip;
		public string Return;
		public ArrayList ParamName; // TODO: change ArrayList for List<string>
		public ArrayList ParamDesc;
		public ArrayList TagName;
		public ArrayList TagDesc;
	}
	
	public class ASDocumentation
	{
		static private List<ICompletionListItem> docVariables;
		static private BoxItem boxSimpleClose;
		static private BoxItem boxMethodParams;
		
		#region regular_expressions
        static private RegexOptions ro_cs = RegexOptions.Compiled | RegexOptions.Singleline;
        static private Regex re_splitFunction = new Regex("(?<keys>[\\w\\s]*)[\\s]function[\\s]*(?<fname>[^(]*)\\((?<params>[^()]*)\\)(?<type>.*)", ro_cs);
        static private Regex re_property = new Regex("^(get|set)\\s", RegexOptions.Compiled);
        static private Regex re_variableType = new Regex("[\\s]*:[\\s]*(?<type>[\\w.?*]+)", ro_cs);
        static private Regex re_functionDeclaration = new Regex("[\\s\\w]*[\\s]function[\\s][\\s\\w$]+\\($", ASFileParser.ro_cs);
        static private Regex re_tags = new Regex("<[/]?(p|br)[/]?>", RegexOptions.IgnoreCase | RegexOptions.Compiled);
		#endregion
		
		#region Comment generation
		static ASDocumentation()
		{
			boxSimpleClose = new BoxItem(TextHelper.GetString("Label.CompleteDocEmpty"));
			boxMethodParams = new BoxItem(TextHelper.GetString("Label.CompleteDocDetails"));
		}
		
		static public bool OnChar(ScintillaNet.ScintillaControl Sci, int Value, int position, int style)
		{
			if (style == 3 || style == 124)
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
			ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
			if (Sci == null) return;
			int position = Sci.CurrentPos;
			int line = Sci.LineFromPosition(position);
			int indent = Sci.LineIndentPosition(line) - Sci.PositionFromLine(line);
			string tab = Sci.GetLine(line).Substring(0, indent);
			// get EOL
			int eolMode = Sci.EOLMode;
			string newline = ASComplete.GetNewLineMarker(eolMode);
            string star = PluginBase.Settings.CommentBlockStyle == CommentBlockStyle.Indented ? " *" : "*";
			
			// empty box
            if (Context == null)
            {
                Sci.ReplaceSel(newline + tab + star + " " + newline + tab + star + "/");
                position += newline.Length + tab.Length + 1 + star.Length;
                Sci.SetSel(position, position);
            }

            // method details
            else
            {
                string box = newline + tab + star + " ";
                Match mFun = re_splitFunction.Match(Context);
                if (mFun.Success && !re_property.IsMatch(mFun.Groups["fname"].Value))
                {
                    // parameters
                    MemberList list = ParseMethodParameters(mFun.Groups["params"].Value);
                    foreach (MemberModel param in list)
                        box += newline + tab + star + " @param\t" + param.Name;
                    // return type
                    Match mType = re_variableType.Match(mFun.Groups["type"].Value);
                    if (mType.Success && !mType.Groups["type"].Value.Equals("void", StringComparison.OrdinalIgnoreCase))
                        box += newline + tab + star + " @return"; //+mType.Groups["type"].Value;
                }
                box += newline + tab + star + "/";
                Sci.ReplaceSel(box);
                position += newline.Length + tab.Length + 1 + star.Length;
                Sci.SetSel(position, position);
            }
		}

        /// <summary>
        /// Returns parameters string as member list
        /// </summary>
        /// <param name="parameters">Method parameters</param>
        /// <returns>Member list</returns>
        static private MemberList ParseMethodParameters(string parameters)
        {
            MemberList list = new MemberList();
            if (parameters == null)
                return list;
            int p = parameters.IndexOf('(');
            if (p >= 0)
                parameters = parameters.Substring(p + 1, parameters.IndexOf(')') - p - 1);
            parameters = parameters.Trim();
            if (parameters.Length == 0)
                return list;
            string[] sparam = parameters.Split(',');
            string[] parType;
            MemberModel param;
            foreach (string pt in sparam)
            {
                parType = pt.Split(':');
                param = new MemberModel();
                param.Name = parType[0].Trim();
                if (param.Name.Length == 0)
                    continue;
                if (parType.Length == 2) param.Type = parType[1].Trim();
                else param.Type = ASContext.Context.Features.objectKey;
                param.Flags = FlagType.Variable | FlagType.Dynamic;
                list.Add(param);
            }
            return list;
        }
		
		static private bool HandleDocTagCompletion(ScintillaNet.ScintillaControl Sci)
		{
            if (ASContext.CommonSettings.JavadocTags == null || ASContext.CommonSettings.JavadocTags.Length == 0)
                return false;

            string txt = Sci.GetLine(Sci.LineFromPosition(Sci.CurrentPos)).TrimStart();
			if (!Regex.IsMatch(txt, "^\\*[\\s]*\\@"))
				return false;
			
			// build tag list
			if (docVariables == null)
			{
                docVariables = new List<ICompletionListItem>();
				TagItem item;
                foreach (string tag in ASContext.CommonSettings.JavadocTags)
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
			// is the block before a function declaration?
			int len = Sci.TextLength-1;
			char c;
			StringBuilder sb = new StringBuilder();
			while (position < len)
			{
				c = (char)Sci.CharAt(position);
				sb.Append(c);
				if (c == '(' || c == ';' || c == '{' || c == '}') break;
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
					if (c == ';' || c == '{') break;
					position++;
				}
				signature = sb.ToString();
			}
			else signature = null;
			
			// build templates list
            List<ICompletionListItem> templates = new List<ICompletionListItem>();
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
				get { return TextHelper.GetString("Label.DocBoxTemplate"); }
			}
			
			public System.Drawing.Bitmap Icon {
				get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(PluginUI.ICON_TEMPLATE); }
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
                get { return TextHelper.GetString("Label.DocTagTemplate"); }
			}
			
			public System.Drawing.Bitmap Icon {
				get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(PluginUI.ICON_DECLARATION); }
			}
			
			public string Value { 
				get { return label; }
			}
		}
		#endregion
		
		#region Tooltips
		
		static public CommentBlock ParseComment(string comment)
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
		
		static public string GetTipDetails(MemberModel member, string highlightParam)
		{
			try
			{
                string tip = (UITools.Manager.ShowDetails) ? GetTipFullDetails(member, highlightParam) : GetTipShortDetails(member, highlightParam);
                // remove paragraphs from comments
                return RemoveHTMLTags(tip);
			}
			catch(Exception ex)
			{
				ErrorManager.ShowError(/*"Error while parsing comments.\n"+ex.Message,*/ ex);
				return "";
			}
		}

        static public string RemoveHTMLTags(string tip)
        {
            return re_tags.Replace(tip, "");
        }
		
		/// <summary>
		/// Short contextual details to display in tips
		/// </summary>
		/// <param name="member">Member data</param>
		/// <param name="highlightParam">Parameter to detail</param>
		/// <returns></returns>
		static public string GetTipShortDetails(MemberModel member, string highlightParam)
		{
            if (member == null || member.Comments == null || !ASContext.CommonSettings.SmartTipsEnabled) return "";
			CommentBlock cb = ParseComment(member.Comments);
            return " …" + GetTipShortDetails(cb, highlightParam);
        }

        /// <summary>
        /// Short contextual details to display in tips
        /// </summary>
        /// <param name="cb">Parsed comments</param>
        /// <returns>Formated comments</returns>
        static public string GetTipShortDetails(CommentBlock cb, string highlightParam)
        {
			string details = "";
			
			// get parameter detail
			if (highlightParam != null && highlightParam.Length > 0 && cb.ParamName != null)
			{
				for(int i=0; i<cb.ParamName.Count; i++)
				{
					if (highlightParam == (string)cb.ParamName[i]) {
                        details += "\n[B]" + highlightParam + ":[/B] " + Get2LinesOf((string)cb.ParamDesc[i]).TrimStart();
						return details;
					}
				}
			}
			// get description extract
            if (ASContext.CommonSettings.SmartTipsEnabled)
			{
				if (cb.InfoTip != null && cb.InfoTip.Length > 0) details += "\n"+cb.InfoTip;
				else if (cb.Description != null && cb.Description.Length > 0) 
                    details += Get2LinesOf(cb.Description);
			}
			return details;
		}

        /// <summary>
        /// Split multiline text and return 2 lines or less of text
        /// </summary>
        static public string Get2LinesOf(string text)
        {
            string[] lines = text.Split('\n');
            text = "";
            int n = Math.Min(lines.Length, 2);
            for (int i = 0; i < n; i++) text += "\n" + lines[i];
            if (lines.Length > 2) text += " …";
            return text;
        }
		
		/// <summary>
		/// Extract member comments for display in the completion list
		/// </summary>
		/// <param name="member">Member data</param>
        /// <param name="highlightParam">Parameter to highlight</param>
		/// <returns>Formated comments</returns>
		static public string GetTipFullDetails(MemberModel member, string highlightParam)
		{
            if (member == null || member.Comments == null || !ASContext.CommonSettings.SmartTipsEnabled) return "";
			CommentBlock cb = ParseComment(member.Comments);
            return GetTipFullDetails(cb, highlightParam);
        }

        /// <summary>
        /// Extract comments for display in the completion list
        /// </summary>
        /// <param name="cb">Parsed comments</param>
        /// <returns>Formated comments</returns>
        static public string GetTipFullDetails(CommentBlock cb, string highlightParam)
        {
			string details = "";
			if (cb.Description.Length > 0) 
			{
				string[] lines = cb.Description.Split('\n');
                int n = Math.Min(lines.Length, ASContext.CommonSettings.DescriptionLinesLimit);
				for(int i=0; i<n; i++) details += lines[i]+"\n";
                if (lines.Length > ASContext.CommonSettings.DescriptionLinesLimit) details = details.TrimEnd() + " …\n";
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
	}

}
