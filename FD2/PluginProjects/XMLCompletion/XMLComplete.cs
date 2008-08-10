using System;
using System.Xml;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections;
using System.Windows.Forms;
using System.Drawing;
using System.IO;
using PluginCore;
using PluginCore.Controls;
using ScintillaNet;

namespace XMLCompletion
{
	/// <summary>
	/// Handles XML completion
	/// </summary>
	public class XMLComplete
	{
		#region Regular Expressions
		// extract tag name
		static private readonly Regex re_TagName = 
			new Regex("<(?<name>[a-z][a-z0-9_:]*)[\\s>]", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		
		// check if the text ends with a closing tag
		static private readonly Regex re_closingTag =
			new Regex("\\</[a-z][a-z0-9_:]*\\>$", RegexOptions.Compiled | RegexOptions.IgnoreCase | RegexOptions.RightToLeft);
		#endregion

		#region Settings
		static readonly private string SETTING_AUTO_INDENT = "XMLCompletion.SmartIndenter";
		static readonly private string SETTING_AUTO_CLOSE = "XMLCompletion.CloseTags";
		static readonly private string SETTING_INSERT_QUOTES = "XMLCompletion.InsertQuotes";
		static readonly private string SETTING_ENABLE_HTML = "XMLCompletion.HTML.EnableCompletion";
		static readonly private string SETTING_LOW_HTML = "XMLCompletion.HTML.LowerCaseTags";
		static readonly private string SETTING_KNOWN = "XMLCompletion.KnownLanguages";
		static private bool autoCloseTags;
		static private bool autoIndent;
		static private bool insertQuotes;
		static private bool enableHtmlCompletion;
		static private bool lowerCaseHtmlTags;
		
		static public bool LowerCaseHtmlTags
		{
			get { return lowerCaseHtmlTags; }
		}
		#endregion
		
		#region Properties
		static public System.Drawing.Bitmap HtmlTagIcon;
		static public System.Drawing.Bitmap HtmlAttributeIcon;
		static public System.Drawing.Bitmap StyleAttributeIcon;
		static public System.Drawing.Bitmap EventAttributeIcon;
		static private IMainForm mainForm;
		static private string cFile;
		static private XMLType cType;
		static private Hashtable languageTags;
		static private ArrayList knownTags;
		static private ArrayList xmlBlocks;
		static private string knownLanguages;
		
		static public IMainForm MainForm
		{
			get { return mainForm; }
		}
		
		static public string CurrentFile
		{
			get { return cFile; }
			set {
				cFile = value;
				string lang = mainForm.CurSciControl.ConfigurationLanguage;
				string ext = Path.GetExtension(mainForm.CurFile).Substring(1);
				if (lang == "html") ext = "html";
				if (Regex.IsMatch(knownLanguages, "[\\s,]"+ext+"[\\s,]"))
				{
					if (languageTags == null) LoadDeclarations();
					if (languageTags[ext] != null)
					{
						cType = XMLType.Known;
						knownTags = languageTags[ext] as ArrayList;
						return;
					}
				}
				if (lang == "xml")
				{
					cType = XMLType.XML;
				}
				else
				{
					cType = XMLType.Invalid;
				}
			}
		}
		#endregion
		
		#region Initialisation
		static public void Init(IMainForm mainForm)
		{
			XMLComplete.mainForm = mainForm;
			
			// settings
			if (!mainForm.MainSettings.HasKey(SETTING_AUTO_CLOSE))
				mainForm.MainSettings.AddValue(SETTING_AUTO_CLOSE, "true");
			if (!mainForm.MainSettings.HasKey(SETTING_AUTO_INDENT))
				mainForm.MainSettings.AddValue(SETTING_AUTO_INDENT, "true");
			if (!mainForm.MainSettings.HasKey(SETTING_INSERT_QUOTES))
				mainForm.MainSettings.AddValue(SETTING_INSERT_QUOTES, "true");
			if (!mainForm.MainSettings.HasKey(SETTING_ENABLE_HTML))
				mainForm.MainSettings.AddValue(SETTING_ENABLE_HTML, "true");
			if (!mainForm.MainSettings.HasKey(SETTING_LOW_HTML))
				mainForm.MainSettings.AddValue(SETTING_LOW_HTML, "true");
			if (!mainForm.MainSettings.HasKey(SETTING_KNOWN))
				mainForm.MainSettings.AddValue(SETTING_KNOWN, "html,mxml");
			UpdateSettings();
			
			// list icons
			try
			{
				System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
				HtmlTagIcon = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("HtmlTag.png"));
				HtmlAttributeIcon = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("HtmlAttribute.png"));
				StyleAttributeIcon = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("StyleAttribute.png"));
				EventAttributeIcon = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("EventAttribute.png"));
			}
			catch(Exception iex)
			{
				ErrorHandler.ShowError("Error while retrieving resource images.\n"+iex.Message, iex);
				if (HtmlTagIcon == null) HtmlTagIcon = new System.Drawing.Bitmap(16,16);
				if (HtmlAttributeIcon == null) HtmlAttributeIcon = new System.Drawing.Bitmap(16,16);
				if (StyleAttributeIcon == null) StyleAttributeIcon = new System.Drawing.Bitmap(16,16);
				if (EventAttributeIcon == null) EventAttributeIcon = new System.Drawing.Bitmap(16,16);
			}
			
			// xmlBlocks
			xmlBlocks = new ArrayList();
			xmlBlocks.Add( new XMLBlockItem("CDATA", "XML Block", "[CDATA[|]]>") );
			xmlBlocks.Add( new XMLBlockItem("Comment", "XML Block", "-- | -->") );
		}
		
		/// <summary>
		/// Load tags/attributes definitions
		/// </summary>
		static private void LoadDeclarations()
		{
			// HTML tags & attributes
			try
			{
				languageTags = new Hashtable();
				
				XmlDocument document = null;
				string file = Path.GetDirectoryName(Application.ExecutablePath)+"\\Data\\XMLCompletion.xml";
				try
				{
					// create default html definition file
					if (!File.Exists(file)) WriteDefaultDeclarations(file);
					// read definitions
					document = new XmlDocument();
					document.PreserveWhitespace = false;
					document.Load(file);
					// old definitions file
					if (document.FirstChild == null || document.FirstChild.Name != "xmlcompletion")
					{
						if (File.Exists(file+".bak")) File.Delete(file+".bak");
						File.Move(file, file+".bak");
						WriteDefaultDeclarations(file);
						document.Load(file);
					}
				}
				catch (Exception ex)
				{
					ErrorHandler.ShowError("Error while opening file:\n"+file, ex);
					return;
				}
				
				if (document != null && document.FirstChild.Name == "xmlcompletion")
				{
					char[] coma = {','};
					foreach(XmlNode language in document.FirstChild.ChildNodes)
					if (language.Name != null && language.Name.Length > 0 && language.Name[0] != '#')
					{
						knownTags = new ArrayList();
						// groupes d'attributs
						Hashtable groups = new Hashtable();
						int index = 0;
						if (language.ChildNodes[index].Name == "groups")
						{
							foreach(XmlNode group in language.ChildNodes[index].ChildNodes)
							if (group.Name == "group") 
							{
								groups.Add(group.Attributes["id"].Value, group.Attributes["at"].Value);
							}
							index++;
						}
						// tags
						HTMLTag htag;
						string temp;
						string[] attributes;
						XmlAttribute isLeaf;
						XmlAttribute ns;
						foreach(XmlNode tag in language.ChildNodes[index].ChildNodes)
						if (tag.Name != null && tag.Name.Length > 0 && tag.Name[0] != '#')
						{
							isLeaf = tag.Attributes["leaf"];
							ns = tag.Attributes["ns"];
							htag = new HTMLTag(tag.Name, 
							                   (ns != null) ? ns.Value : null, 
							                   isLeaf != null && isLeaf.Value == "yes");
							htag.Attributes = new ArrayList();
							temp = tag.Attributes["at"].Value;
							foreach(string key in groups.Keys)
							{
								temp = temp.Replace(key, groups[key].ToString());
							}
							attributes = temp.Split(coma);
							foreach(string attribute in attributes)
							{
								htag.Attributes.Add(attribute);
							}
							htag.Attributes.Sort();
							knownTags.Add(htag);
						}
						// tri et stockage
						knownTags.Sort();
						languageTags[language.Name] = knownTags;
					}
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError("Error while reading XML tags definitions.\n"+ex.Message, ex);
			}
		}
		
		static private void WriteDefaultDeclarations(string file)
		{
			System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
			string content;
			using(StreamReader sr = new StreamReader(assembly.GetManifestResourceStream("XMLCompletion.xml")))
			{
				content = sr.ReadToEnd();
				sr.Close();
			}
			Directory.CreateDirectory(Path.GetDirectoryName(file));
			using(StreamWriter sw = File.CreateText(file))
			{
				sw.Write(content);
				sw.Close();
			}
		}

		
		static public void UpdateSettings()
		{
			autoCloseTags = mainForm.MainSettings.GetBool(SETTING_AUTO_CLOSE);
			autoIndent = mainForm.MainSettings.GetBool(SETTING_AUTO_INDENT);
			insertQuotes = mainForm.MainSettings.GetBool(SETTING_INSERT_QUOTES);
			enableHtmlCompletion = mainForm.MainSettings.GetBool(SETTING_ENABLE_HTML);
			lowerCaseHtmlTags = mainForm.MainSettings.GetBool(SETTING_LOW_HTML);
			knownLanguages = " "+mainForm.MainSettings.GetValue(SETTING_KNOWN)+" ";
		}
		#endregion
		
		#region Event Handlers
		static public void OnChar(ScintillaControl sci, int value)
		{
			if (cType == XMLType.Invalid)
				return;
			
			XMLContextTag ctag;
			int position = sci.CurrentPos;
			char c = ' ';
			switch (value)
			{
				case 10:
					int line = sci.LineFromPosition(position);
					
					// Shift+Enter to insert <BR/>
					if (Control.ModifierKeys == Keys.Shift)
					{
						ctag = GetXMLContextTag(sci, position);
						if (ctag.Tag == null || ctag.Tag.EndsWith(">"))
						{
							int start = sci.PositionFromLine(line)-((sci.EOLMode == 0)? 2:1);
							sci.SetSel(start, position);
							sci.ReplaceSel((lowerCaseHtmlTags)?"<br/>":"<BR/>");
							sci.SetSel(start+5, start+5);
							return;
						}
					}
					if (autoIndent)
					{
						// get last non-empty line
						string text = "";
						int line2 = line-1;
						while (line2 >= 0 && text.Length == 0)
						{
							text = sci.GetLine(line2).TrimEnd();
							line2--;
						}
						
						if ((text.EndsWith(">") && !text.EndsWith("?>") && !text.EndsWith("%>") && !re_closingTag.IsMatch(text)) 
						    || text.EndsWith("<!--") || text.EndsWith("<![CDATA["))
						{
							// get the previous tag
							do {
								position--;
								c = (char)sci.CharAt(position);
							}
							while (position > 0 && c != '>');
							ctag = GetXMLContextTag(sci, position);
							
							if ((char)sci.CharAt(position-1) == '/')
								return;
							
							// insert blank line if we pressed Enter between a tag & it's closing tag
							int indent = sci.GetLineIndentation(line2+1);
							string checkStart = null;
							if (text.EndsWith("<!--")) checkStart = "-->";
							else if (text.EndsWith("<![CDATA[")) checkStart = "]]>";
							else if (ctag.Name != null) checkStart = "</"+ctag.Name;
							if (checkStart != null)
							{
								text = sci.GetLine(line).TrimStart();
								if (text.StartsWith(checkStart))
								{
									sci.SetLineIndentation(line, indent);
									sci.InsertText(sci.PositionFromLine(line), mainForm.GetNewLineMarker(sci.EOLMode));
								}
							}
							
							// indent
							sci.SetLineIndentation(line, indent+sci.Indent);
							position = sci.LineIndentPosition(line);
							sci.SetSel(position, position);
							return;
						}
					}
					break;
					
				case '<':
				case '/':
					if (value == '/')
					{
						if ((position < 2) || ((char)sci.CharAt(position-2) != '<'))
							return;
					}
					else 
					{
						ctag = GetXMLContextTag(sci, position);
						if (ctag.Tag != null)
							return;
					}
					// new tag
					if (enableHtmlCompletion && cType == XMLType.Known)
					{
						ArrayList items = new ArrayList();
						string previous = null;
						foreach(HTMLTag tag in knownTags) 
						if (tag.Name != previous) {
							items.Add( new HtmlTagItem(tag.Name, tag.Tag) );
							previous = tag.Name;
						}
						CompletionList.Show(items, true);
					}
					else
					{
						// allow another plugin to handle this
						mainForm.DispatchEvent(new DataEvent(EventType.CustomData,"XMLCompletion.Element",new XMLContextTag()));
					}
					return;
					
				case '>':
					if (autoCloseTags)
					{
						ctag = GetXMLContextTag(sci, position);
						if (ctag.Name != null && !ctag.Tag.EndsWith("/>"))
						{
							// est-ce un tag sans enfant?
							bool isLeaf = false;
							if (cType == XMLType.Known)
							foreach(HTMLTag tag in knownTags)
							{
								if (String.Compare(tag.Tag, ctag.Name, true) == 0)
								{
									isLeaf = tag.IsLeaf;
									break;
								}
							}
							if (isLeaf)
							{
								sci.SetSel(position-1,position);
								sci.ReplaceSel("/>");
								sci.SetSel(position+1, position+1);
							}
							else
							{
								string closeTag = "</"+ctag.Name+">";
								sci.ReplaceSel(closeTag);
								sci.SetSel(position, position);
							}
						}
					}
					return;
					
				case ' ':
					c = (char)sci.CharAt(position);
					if (c > 32 && c != '/' && c != '>' && c != '<')
						return;
						
					ctag = GetXMLContextTag(sci, position);
					if (ctag.Tag != null)
					{
						if (InQuotes(ctag.Tag) || ctag.Tag.LastIndexOf('"') < ctag.Tag.LastIndexOf('='))
							return;
						//
						if (enableHtmlCompletion && cType == XMLType.Known)
						{
							foreach(HTMLTag tag in knownTags)
							if (String.Compare(tag.Tag, ctag.Name, true) == 0)
							{
								ArrayList items = new ArrayList();
								string previous = null;
								foreach(string attr in tag.Attributes)
								if (attr != previous) {
									items.Add( new HtmlAttributeItem(attr) );
									previous = attr;
								}
								CompletionList.Show(items, true);
								return;
							}
						}
						else
						{
							// allow another plugin to handle this
							object[] o = new object[]{ctag,""};
							mainForm.DispatchEvent(new DataEvent(EventType.CustomData,"XMLCompletion.Attribute",o));
						}
					}
					return;
				
				case '=':
					if (insertQuotes)
					{
						ctag = GetXMLContextTag(sci, position);
						position = sci.CurrentPos-2;
						if (ctag.Tag != null && !InQuotes(ctag.Tag) && (GetWordLeft(sci, ref position).Length > 0))
						{
							position = sci.CurrentPos;
							c = (char)sci.CharAt(position);
							if (c > 32 && c != '>') sci.ReplaceSel("\"\" ");
							else sci.ReplaceSel("\"\"");
							sci.SetSel(position+1, position+1);
						}
					}
					return;
					
				case '?':
				case '%':
					if (autoCloseTags && position > 1)
					{
						ctag = GetXMLContextTag(sci, position-2);
						if (ctag.Tag == null || ctag.Tag.EndsWith(">"))
						{
							if ((char)sci.CharAt(position-2) == '<')
							{
								sci.ReplaceSel((char)value + ">");
								sci.SetSel(position, position);
							}
						}
					}
					break;
				
				case '!':
					if (autoCloseTags && position > 1)
					{
						ctag = GetXMLContextTag(sci, position-2);
						if (ctag.Tag == null || ctag.Tag.EndsWith(">"))
						{
							if ((char)sci.CharAt(position-2) == '<')
							{
								CompletionList.Show(xmlBlocks, true);
							}
						}						
					}
					break;
			}
		}
		
		static public bool OnShortCut(Keys keys)
		{
			if (keys == (Keys.Control | Keys.Space))
			{
				// context
				ScintillaControl sci = mainForm.CurSciControl;
				if (sci == null)
					return false;
				XMLContextTag ctag = GetXMLContextTag(sci, sci.CurrentPos);
				
				// starting tag
				if (ctag.Tag == null && (sci.CurrentPos > 0))
				{
					if ((char)sci.CharAt(sci.CurrentPos-1) == '<') {
						ctag.Tag = "<";
						ctag.Name = "";
					}
					else return false;
				}
				else if (ctag.Tag.EndsWith(">"))
				{
					return false;
				}
				// closing tag
				else if (ctag.Tag.StartsWith("</") && (ctag.Tag.IndexOf(' ') < 0))
				{
					ctag.Name = ctag.Tag.Substring(2);
					ctag.Tag = "<"+ctag.Name;
				}
				
				// element completion
				if (ctag.Name != null && (ctag.Tag.Length == ctag.Name.Length+1))
				{
					if (cType == XMLType.Known)
					{
						ArrayList items = new ArrayList();
						string previous = null;
						foreach(HTMLTag tag in knownTags) 
						if (tag.Name != previous) {
							items.Add( new HtmlTagItem(tag.Name, tag.Tag) );
							previous = tag.Name;
						}
						CompletionList.Show(items, false, ctag.Name);
					}
					else
					{
						// allow another plugin to handle this
						mainForm.DispatchEvent(new DataEvent(EventType.CustomData,"XMLCompletion.Element",ctag));
					}
				}
				
				// attributes completion
				else
				{
					if (InQuotes(ctag.Tag) || ctag.Tag.LastIndexOf('"') < ctag.Tag.LastIndexOf('='))
						return true;
					
					// get word
					int position = sci.CurrentPos-1;
					string word = GetWordLeft(sci, ref position);
					
					if (cType == XMLType.Known)
					{
						foreach(HTMLTag tag in knownTags)
						if (String.Compare(tag.Tag, ctag.Name, true) == 0)
						{
							ArrayList items = new ArrayList();
							string previous = null;
							foreach(string attr in tag.Attributes)
							if (attr != previous) {
								items.Add( new HtmlAttributeItem(attr) );
								previous = attr;
							}
							CompletionList.Show(items, true, word.Trim());
							return true;
						}
					}
					else
					{
						// allow another plugin to handle this
						object[] o = new object[]{ctag,word};
						mainForm.DispatchEvent(new DataEvent(EventType.CustomData,"XMLCompletion.Attribute",o));
					}
				}
				return true;
			}
			return false;
		}
		#endregion
		
		#region XML Parser
		static private XMLContextTag GetXMLContextTag(ScintillaControl sci, int position)
		{
			XMLContextTag xtag = new XMLContextTag();
			if ((position == 0) || (sci == null))
				return xtag;
			StringBuilder tag = new StringBuilder();
			char c = (char)sci.CharAt(position-1);
			position -= 2;
			tag.Append(c);
			while (position >= 0)
			{
				c = (char)sci.CharAt(position);
				tag.Insert(0, c);
				if (c == '>') return xtag;
				if (c == '<') break;
				position--;
			}
			//
			xtag.Position = position;
			xtag.Tag = tag.ToString();
			Match mTag = re_TagName.Match(xtag.Tag+" ");
			if (mTag.Success)
			{
				xtag.Name = mTag.Groups["name"].Value;
				if (xtag.Name.IndexOf(':') > 0)
				{
					xtag.NameSpace = xtag.Name.Substring(0, xtag.Name.IndexOf(':'));
				}
			}
			return xtag;
		}
		
		static private string GetWordLeft(ScintillaNet.ScintillaControl Sci, ref int position)
		{
			string word = "";
			string exclude = "(){};,+*/\\=:.%\"<>";
			char c;
			while (position >= 0) 
			{
				c = (char)Sci.CharAt(position);
				if (c <= ' ') break;
				else if (exclude.IndexOf(c) >= 0) break;
				else word = c+word;
				position--;
			}
			return word;
		}
		
		static private bool InQuotes(string tag)
		{
			if (tag == null)
				return false;
			int n = tag.Length;
			bool inQuotes = false;
			for(int i=0; i<n; i++)
			if (tag[i] == '"')
				inQuotes = !inQuotes;
			return inQuotes;
		}
		#endregion
	}
	
	#region Structures
	
	public class HTMLTag: IComparable
	{
		public string Name;
		public string Tag;
		public ArrayList Attributes;
		public bool IsLeaf;
		
		public HTMLTag(string tag, string ns, bool isLeaf)
		{
			Name = tag;
			Tag = (ns != null) ? ns+":"+tag : tag;
			IsLeaf = isLeaf;
		}
		
		public int CompareTo(object obj)
		{
			if (!(obj is HTMLTag))
				throw new InvalidCastException("This object is not of type HTMLTag");
			return string.Compare(Tag, ((HTMLTag)obj).Tag);
		}
	}
	
	public struct XMLContextTag
	{
		public string Tag;
		public string Name;
		public string NameSpace;
		public int Position;
	}
	
	public enum XMLType
	{
		Unknown = 0,
		Invalid,
		XML,
		Known
	}
	
	/// <summary>
	/// Html completion tag item
	/// </summary>
	public class HtmlTagItem : ICompletionListItem
	{
		private string label;
		private string tag;
		
		public HtmlTagItem(string name, string tag) 
		{
			this.label = (XMLComplete.LowerCaseHtmlTags) ? name : name.ToUpper();
			this.tag = tag;
		}
		
		public string Label { 
			get { return label; }
		}
		public string Description { 
			get { return "Tag <"+tag+">"; }
		}
		
		public System.Drawing.Bitmap Icon {
			get { return XMLComplete.HtmlTagIcon; }
		}
		
		public string Value { 
			get { return tag; }
		}
	}
	
	/// <summary>
	/// Html completion attribute item
	/// </summary>
	public class HtmlAttributeItem : ICompletionListItem
	{
		private string label;
		private string desc;
		private Bitmap icon;
		
		public HtmlAttributeItem(string name) 
		{
			// icone special
			int p = name.IndexOf(':');
			if (p > 0)
			{
				string ic = name.Substring(p+1);
				if (ic == "style") {
					this.icon = XMLComplete.StyleAttributeIcon;
					this.desc = "Styling attribute";
				}
				else if (ic == "event") {
					this.icon = XMLComplete.EventAttributeIcon;
					this.desc = "Event attribute";
				}
				else {
					this.icon = XMLComplete.HtmlAttributeIcon;
					this.desc = "Attribute";
				}
				name = name.Substring(0,p);
			}
			else {
				this.icon = XMLComplete.HtmlAttributeIcon;
				this.desc = "Attribute";
			}
			// texte
			this.label = (XMLComplete.LowerCaseHtmlTags) ? name : name.ToUpper();
		}
		
		public string Label { 
			get { return label; }
		}
		public string Description { 
			get { return desc; }
		}
		
		public Bitmap Icon {
			get { return icon; }
		}
		
		public string Value { 
			get { return label; }
		}
	}
	
	/// <summary>
	/// XML completion block item
	/// </summary>
	public class XMLBlockItem : ICompletionListItem
	{
		private string label;
		private string desc;
		private string replace;
		
		public XMLBlockItem(string label, string desc, string replace)
		{
			this.label = label;
			this.desc = desc;
			this.replace = replace;
		}
		
		public string Label { 
			get { return label; }
		}
		public string Description { 
			get { return desc; }
		}
		
		public System.Drawing.Bitmap Icon {
			get { return XMLComplete.HtmlTagIcon; }
		}
		
		public string Value { 
			get {
				ScintillaControl sci = XMLComplete.MainForm.CurSciControl;
				int position = sci.CurrentPos;
				string[] rep = replace.Split('|');
				sci.ReplaceSel(rep[0]);
				sci.ReplaceSel(rep[1]);
				sci.SetSel(position+rep[0].Length, position+rep[0].Length);
				return null; 
			}
		}
	}
	#endregion
}
