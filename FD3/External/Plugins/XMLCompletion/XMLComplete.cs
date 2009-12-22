using System;
using System.IO;
using System.Xml;
using System.Text;
using System.Drawing;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using PluginCore.Controls;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Helpers;
using ScintillaNet;
using PluginCore;

namespace XMLCompletion
{
	public class XMLComplete
	{
        #region Properties

        public static bool Active { get { return cType != XMLType.Invalid; } }

        public static Bitmap HtmlAttributeIcon;
        public static Bitmap StyleAttributeIcon;
        public static Bitmap EventAttributeIcon;
        public static Bitmap EffectAttributeIcon;
        public static Bitmap HtmlTagIcon;
        public static Bitmap NamespaceTagIcon;

        private static String cFile;
        private static XMLType cType;
        private static List<HTMLTag> knownTags;
        private static List<string> namespaces;
        private static string defaultNS;
        private static Dictionary<string, LanguageDef> languageTags;
        private static List<ICompletionListItem> xmlBlocks;
        private static int justInsertedQuotesAt;

        /// <summary>
        /// Gets or sets the current editable file
        /// </summary> 
        public static String CurrentFile
        {
            get { return cFile; }
            set
            {
                cFile = value;
                cType = XMLType.Invalid;

                if (cFile == null) return;

                String lang = PluginBase.MainForm.CurrentDocument.SciControl.ConfigurationLanguage;
                String ext = Path.GetExtension(value);
                if (ext.Length == 0) return;
                ext = ext.Substring(1);
                if (lang == "html") ext = "html";
                if (languageTags == null) languageTags = new Dictionary<string, LanguageDef>();
                if (!languageTags.ContainsKey(ext)) TryLoadDeclaration(ext);
                if (languageTags[ext] != null)
                {
                    cType = XMLType.Known;
                    LanguageDef def = languageTags[ext];
                    knownTags = def.KnownTags;
                    namespaces = def.Namespaces;
                    defaultNS = def.DefaultNS;
                    return;
                }
                if (lang == "xml" || lang == "html") cType = XMLType.XML;
            }
        }

        /// <summary>
        /// Gets an instance of the settings class
        /// </summary> 
        private static Settings PluginSettings
        {
            get { return Settings.Instance; }
        }

        #endregion

        #region Regular Expressions
		
        /**
        * Extract the tag name
        */
		private static readonly Regex tagName = new Regex("<(?<name>[a-z][-a-z0-9_:]*)[\\s>]", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		
		/**
        * Check if the text ends with a closing tag
        */
		private static readonly Regex closingTag = new Regex("\\</[a-z][-a-z0-9_:]*\\>$", RegexOptions.Compiled | RegexOptions.IgnoreCase | RegexOptions.RightToLeft);
		
        #endregion
		
		#region Initialization

        /// <summary>
        /// Initializes the completion engine
        /// </summary> 
		public static void Init()
		{
            xmlBlocks = new List<ICompletionListItem>();
            xmlBlocks.Add(new XMLBlockItem("CDATA", "XML Block", "[CDATA[|]]>"));
            xmlBlocks.Add(new XMLBlockItem("Comment", "XML Block", "-- | -->"));
            EventAttributeIcon = new Bitmap(PluginBase.MainForm.FindImage("243"));
            EffectAttributeIcon = new Bitmap(PluginBase.MainForm.FindImage("198"));
            StyleAttributeIcon = new Bitmap(PluginBase.MainForm.FindImage("408"));
            HtmlAttributeIcon = new Bitmap(PluginBase.MainForm.FindImage("272"));
            HtmlTagIcon = new Bitmap(PluginBase.MainForm.FindImage("417"));
            NamespaceTagIcon = new Bitmap(PluginBase.MainForm.FindImage("98"));
            UITools.Manager.OnCharAdded += new UITools.CharAddedHandler(OnChar);
		}
		
		/// <summary>
		/// Loads the tag and attribute definitions
		/// </summary>
		private static void TryLoadDeclaration(string ext)
		{
            try
			{
				XmlDocument document = null;
                String path = Path.Combine(PathHelper.DataDir, "XMLCompletion");
                String file = Path.Combine(path, ext + ".xml");
				try
				{
                    if (!File.Exists(file) && !WriteDefaultDeclarations(ext, file))
                    {
                        languageTags[ext] = null;
                        return;
                    }
					document = new XmlDocument();
					document.PreserveWhitespace = false;
					document.Load(file);
				}
				catch (Exception ex)
				{
					ErrorManager.ShowError(ex);
					return;
				}
                if (document != null && document.FirstChild.Name == "declarations")
				{
                    bool toUpper = (ext == "html" && PluginSettings.UpperCaseHtmlTags);
					Char[] coma = {','};
                    XmlNode language = document.FirstChild;
                    Int32 index = 0;
                    knownTags = new List<HTMLTag>();
                    namespaces = new List<string>();
                    Dictionary<string, string> groups = new Dictionary<string, string>();
                    XmlNode defs = language.ChildNodes[index];
					if (defs.Name == "groups")
					{
						foreach(XmlNode group in defs.ChildNodes)
						if (group.Name == "group") 
						{
							groups.Add(group.Attributes["id"].Value, group.Attributes["at"].Value);
						}
						index++;
					}
					
                    HTMLTag htag;
					String temp; String[] attributes;
					XmlAttribute isLeaf; XmlAttribute ns;
                    defs = language.ChildNodes[index];
                    if (defs.Name != "tags") 
                        return;
                    if (defs.Attributes["defaultNS"] == null) defaultNS = null;
                    else defaultNS = defs.Attributes["defaultNS"].Value;

					foreach(XmlNode tag in defs.ChildNodes)
					if (tag.Name != null && tag.Name.Length > 0 && tag.Name[0] != '#')
					{
						isLeaf = tag.Attributes["leaf"];
						ns = tag.Attributes["ns"];
						htag = new HTMLTag(
                            (toUpper) ? tag.Name.ToUpper() : tag.Name, 
                            (ns != null) ? ns.Value : null, isLeaf != null && isLeaf.Value == "yes");
                        if (htag.NS != null && htag.NS.Length > 0 && !namespaces.Contains(htag.NS))
                            namespaces.Add(htag.NS);
						htag.Attributes = new List<string>();
						temp = tag.Attributes["at"].Value;
                        if (temp.IndexOf('@') >= 0)
                        {
                            attributes = temp.Split(coma);
                            temp = "";
                            foreach (String attribute in attributes)
                            {
                                if (attribute.StartsWith("@"))
                                {
                                    if (groups.ContainsKey(attribute))
                                        temp += "," + groups[attribute];
                                    continue;
                                }
                                temp += "," + attribute;
                            }
                            temp = temp.Substring(1);
                        }
						attributes = temp.Split(coma);
                        foreach (String attribute in attributes)
						{
                            string aname = attribute.Trim();
                            if (aname.Length > 0) htag.Attributes.Add(aname);
						}
						htag.Attributes.Sort();
						knownTags.Add(htag);
					}
					knownTags.Sort();
                    namespaces.Sort();
                    languageTags[ext] = new LanguageDef(knownTags, namespaces, defaultNS);
				}
			}
			catch (Exception ex)
			{
                ErrorManager.ShowError(ex);
			}
		}
		
        /// <summary>
        /// Copies the default declarations to the disk
        /// </summary> 
        private static bool WriteDefaultDeclarations(String ext, String file)
		{
            try
            {
                Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
                Stream src = assembly.GetManifestResourceStream("XMLCompletion.Resources." + ext + ".xml");
                if (src == null) return false;

                String content;
                using (StreamReader sr = new StreamReader(src))
                {
                    content = sr.ReadToEnd();
                    sr.Close();
                }
                Directory.CreateDirectory(Path.GetDirectoryName(file));
                using (StreamWriter sw = File.CreateText(file))
                {
                    sw.Write(content);
                    sw.Close();
                }
                return true;
            }
            catch
            {
                return false;
            }
		}

		#endregion
		
		#region Event Handlers
        
        /// <summary>
        /// Handles the incoming character
        /// </summary> 
		public static void OnChar(ScintillaControl sci, Int32 value)
		{
            if (cType == XMLType.Invalid) return;
			XMLContextTag ctag;
			Int32 position = sci.CurrentPos;
			Char c = ' ';
            DataEvent de;
			switch (value)
			{
				case 10:
                    // Shift+Enter to insert <BR/>
                    Int32 line = sci.LineFromPosition(position);
					if (Control.ModifierKeys == Keys.Shift)
					{
						ctag = GetXMLContextTag(sci, position);
						if (ctag.Tag == null || ctag.Tag.EndsWith(">"))
						{
							int start = sci.PositionFromLine(line)-((sci.EOLMode == 0)? 2:1);
							sci.SetSel(start, position);
                            sci.ReplaceSel((PluginSettings.UpperCaseHtmlTags) ? "<BR/>" : "<br/>");
							sci.SetSel(start+5, start+5);
							return;
						}
					}
                    if (PluginSettings.SmartIndenter)
					{
                        // Get last non-empty line
						String text = "";
                        Int32 line2 = line - 1;
						while (line2 >= 0 && text.Length == 0)
						{
							text = sci.GetLine(line2).TrimEnd();
							line2--;
						}
						if ((text.EndsWith(">") && !text.EndsWith("?>") && !text.EndsWith("%>") && !closingTag.IsMatch(text)) || text.EndsWith("<!--") || text.EndsWith("<![CDATA["))
						{
                            // Get the previous tag
                            do
                            {
								position--;
								c = (Char)sci.CharAt(position);
							}
							while (position > 0 && c != '>');
							ctag = GetXMLContextTag(sci, position);
							if ((Char)sci.CharAt(position-1) == '/') return;
                            // Insert blank line if we pressed Enter between a tag & it's closing tag
                            Int32 indent = sci.GetLineIndentation(line2 + 1);
							String checkStart = null;
                            bool subIndent = true;
							if (text.EndsWith("<!--")) { checkStart = "-->"; subIndent = false; }
							else if (text.EndsWith("<![CDATA[")) { checkStart = "]]>"; subIndent = false; }
                            else if (ctag.Name != null)
                            {
                                checkStart = "</" + ctag.Name;
                                if (ctag.Name.ToLower() == "script" || ctag.Name.ToLower() == "style") 
                                    subIndent = false;
                                if (ctag.Tag.IndexOf('\r') > 0 || ctag.Tag.IndexOf('\n') > 0)
                                    subIndent = false;
                            }
							if (checkStart != null)
							{
								text = sci.GetLine(line).TrimStart();
								if (text.StartsWith(checkStart))
								{
									sci.SetLineIndentation(line, indent);
									sci.InsertText(sci.PositionFromLine(line), LineEndDetector.GetNewLineMarker(sci.EOLMode));
								}
							}
                            // Indent the code
                            if (subIndent) indent += sci.Indent;
                            sci.SetLineIndentation(line, indent);
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
						if ((position < 2) || ((Char)sci.CharAt(position-2) != '<')) return;
					}
					else 
					{
						ctag = GetXMLContextTag(sci, position);
						if (ctag.Tag != null) return;
					}
                    // Allow another plugin to handle this
                    de = new DataEvent(EventType.Command, "XMLCompletion.Element", new XMLContextTag());
                    EventManager.DispatchEvent(PluginBase.MainForm, de);
                    if (de.Handled) return;
                    // New tag
                    if (PluginSettings.EnableXMLCompletion && cType == XMLType.Known)
					{
                        List<ICompletionListItem> items = new List<ICompletionListItem>();
						String previous = null;
                        foreach (string ns in namespaces)
                        {
                            items.Add(new NamespaceItem(ns));
                        }
                        foreach (HTMLTag tag in knownTags) 
						    if (tag.Name != previous && (tag.NS == "" || tag.NS == defaultNS)) 
                            {
							    items.Add( new HtmlTagItem(tag.Name, tag.Tag));
							    previous = tag.Name;
						    }
                        items.Sort(new ListItemComparer());
                        CompletionList.Show(items, true);
					}
					return;

                case ':':
                    ctag = GetXMLContextTag(sci, position);
                    if (ctag.NameSpace == null) return;
                    // Allow another plugin to handle this
                    de = new DataEvent(EventType.Command, "XMLCompletion.Namespace", new XMLContextTag());
                    EventManager.DispatchEvent(PluginBase.MainForm, de);
                    if (de.Handled) return;
                    // Show namespace's tags
                    if (PluginSettings.EnableXMLCompletion && cType == XMLType.Known)
                    {
                        List<ICompletionListItem> items = new List<ICompletionListItem>();
                        String previous = null;
                        foreach (HTMLTag tag in knownTags)
                            if (tag.Name != previous && tag.NS == ctag.NameSpace)
                            {
                                items.Add(new HtmlTagItem(tag.Name, tag.Name));
                                previous = tag.Name;
                            }
                        CompletionList.Show(items, true);
                    }
                    return;

				case '>':
                    if (PluginSettings.CloseTags)
					{
						ctag = GetXMLContextTag(sci, position);
						if (ctag.Name != null && !ctag.Tag.EndsWith("/>"))
						{
                            // Allow another plugin to handle this
                            de = new DataEvent(EventType.Command, "XMLCompletion.CloseElement", ctag);
                            EventManager.DispatchEvent(PluginBase.MainForm, de);
                            if (de.Handled) return;

							Boolean isLeaf = false;
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
								String closeTag = "</"+ctag.Name+">";
								sci.ReplaceSel(closeTag);
								sci.SetSel(position, position);
							}
						}
					}
					return;
					
				case ' ':
					c = (char)sci.CharAt(position);
					if (c > 32 && c != '/' && c != '>' && c != '<') return;
					ctag = GetXMLContextTag(sci, position);
                    if (ctag.Tag != null)
                    {
                        if (InQuotes(ctag.Tag) || ctag.Tag.LastIndexOf('"') < ctag.Tag.LastIndexOf('=')) return;
                        if (PluginSettings.EnableXMLCompletion && cType == XMLType.Known)
                        {
                            foreach (HTMLTag tag in knownTags)
                                if (String.Compare(tag.Tag, ctag.Name, true) == 0)
                                {
                                    List<ICompletionListItem> items = new List<ICompletionListItem>();
                                    String previous = null;
                                    foreach (String attr in tag.Attributes)
                                        if (attr != previous)
                                        {
                                            items.Add(new HtmlAttributeItem(attr));
                                            previous = attr;
                                        }
                                    CompletionList.Show(items, true);
                                    return;
                                }
                        }
                        else // Allow another plugin to handle this
                        {
                            Object[] obj = new Object[] { ctag, "" };
                            de = new DataEvent(EventType.Command, "XMLCompletion.Attribute", obj);
                            EventManager.DispatchEvent(PluginBase.MainForm, de);
                        }
                    }
                    /*else
                    {
                        if (Control.ModifierKeys == Keys.Shift)
                        {
                            sci.SetSel(position - 1, position);
                            sci.ReplaceSel("&nbsp;");
                        }
                    }*/
					return;
				
				case '=':
					if (PluginSettings.InsertQuotes)
					{
						ctag = GetXMLContextTag(sci, position);
						position = sci.CurrentPos-2;
						if (ctag.Tag != null && !ctag.Tag.StartsWith("<!") && !InQuotes(ctag.Tag) && (GetWordLeft(sci, ref position).Length > 0))
						{
							position = sci.CurrentPos;
							c = (Char)sci.CharAt(position);
							if (c > 32 && c != '>') sci.ReplaceSel("\"\" ");
							else sci.ReplaceSel("\"\"");
							sci.SetSel(position+1, position+1);
                            justInsertedQuotesAt = position+1;
                            // Allow another plugin to handle this
                            de = new DataEvent(EventType.Command, "XMLCompletion.AttributeValue", new XMLContextTag());
                            EventManager.DispatchEvent(PluginBase.MainForm, de);
						}
					}
					return;

                case '"':
                    ctag = GetXMLContextTag(sci, position);
                    if (position > 1 && ctag.Tag != null && !ctag.Tag.StartsWith("<!"))
                    {
                        // TODO  Colorize text change to highlight what's been done
                        if (justInsertedQuotesAt == position - 1)
                        {
                            justInsertedQuotesAt = -1;
                            c = (Char)sci.CharAt(position - 2);
                            if (c == '"' && (Char)sci.CharAt(position-2) == '"')
                            {
                                sci.SetSel(position - 2, position);
                                sci.ReplaceSel("\"");
                            }
                            // Allow another plugin to handle this
                            de = new DataEvent(EventType.Command, "XMLCompletion.AttributeValue", new XMLContextTag());
                            EventManager.DispatchEvent(PluginBase.MainForm, de);
                        }
                        else
                        {
                            c = (Char)sci.CharAt(position - 1);
                            if (c == '"' && (Char)sci.CharAt(position) == '"')
                            {
                                sci.SetSel(position - 1, position + 1);
                                sci.ReplaceSel("\"");
                            }
                        }
                    }
                    break;
					
				case '?':
				case '%':
					if (PluginSettings.CloseTags && position > 1)
					{
						ctag = GetXMLContextTag(sci, position-2);
						if (ctag.Tag == null || ctag.Tag.EndsWith(">"))
						{
							if ((Char)sci.CharAt(position-2) == '<')
							{
								sci.ReplaceSel((Char)value + ">");
								sci.SetSel(position, position);
							}
						}
					}
					break;
				
				case '!':
                    if (PluginSettings.CloseTags && position > 1)
					{
						ctag = GetXMLContextTag(sci, position-2);
						if (ctag.Tag == null || ctag.Tag.EndsWith(">"))
						{
							if ((Char)sci.CharAt(position-2) == '<')
							{
								CompletionList.Show(xmlBlocks, true);
							}
						}						
					}
					break;

                case '\t':
                    if (sci.SelText == "")
                    {
                        ctag = GetXMLContextTag(sci, position - 2);
                        if (ctag.Tag == null)
                        {

                        }
                    }
                    break;
			}
		}
		
        /// <summary>
        /// Handles the incoming keys object
        /// </summary> 
		public static Boolean OnShortCut(Keys keys)
		{
            if (cType == XMLType.Invalid) return false;
            if (keys == (Keys.Control | Keys.Space))
			{
                ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
                if (!document.IsEditable) return false;
                ScintillaControl sci = document.SciControl;
				XMLContextTag ctag = GetXMLContextTag(sci, sci.CurrentPos);
                // Starting tag
				if (ctag.Tag == null && (sci.CurrentPos > 0))
				{
					if ((Char)sci.CharAt(sci.CurrentPos-1) == '<') 
                    {
						ctag.Tag = "<";
						ctag.Name = "";
					}
					else return false;
				}
				else if (ctag.Tag.EndsWith(">"))
				{
					return false;
				}
                // Closing tag
				else if (ctag.Tag.StartsWith("</") && (ctag.Tag.IndexOf(' ') < 0))
				{
					ctag.Name = ctag.Tag.Substring(2);
					ctag.Tag = "<"+ctag.Name;
				}
                // Element completion
				if (ctag.Name != null && (ctag.Tag.Length == ctag.Name.Length+1))
				{
					if (cType == XMLType.Known)
					{
                        List<ICompletionListItem> items = new List<ICompletionListItem>();
						String previous = null;
						foreach (HTMLTag tag in knownTags) 
						if (tag.Name != previous) 
                        {
							items.Add( new HtmlTagItem(tag.Name, tag.Tag) );
							previous = tag.Name;
						}
						CompletionList.Show(items, false, ctag.Name);
					}
                    else // Allow another plugin to handle this
					{
                        DataEvent de = new DataEvent(EventType.Command, "XMLCompletion.Element", ctag);
						EventManager.DispatchEvent(PluginBase.MainForm, de);
					}
				}
                // Attribute completion
				else
				{
					if (InQuotes(ctag.Tag) || ctag.Tag.LastIndexOf('"') < ctag.Tag.LastIndexOf('=')) return true;
					Int32 position = sci.CurrentPos - 1;
					String word = GetWordLeft(sci, ref position);
					if (cType == XMLType.Known)
					{
						foreach (HTMLTag tag in knownTags)
						if (String.Compare(tag.Tag, ctag.Name, true) == 0)
						{
                            List<ICompletionListItem> items = new List<ICompletionListItem>();
							String previous = null;
							foreach (String attr in tag.Attributes)
							if (attr != previous) 
                            {
								items.Add( new HtmlAttributeItem(attr) );
								previous = attr;
							}
							CompletionList.Show(items, true, word.Trim());
							return true;
						}
					}
					else // Allow another plugin to handle this
					{
						Object[] obj = new Object[]{ctag,word};
                        DataEvent de = new DataEvent(EventType.Command, "XMLCompletion.Attribute", obj);
                        EventManager.DispatchEvent(PluginBase.MainForm, de);
					}
				}
				return true;
			}
			return false;
		}

		#endregion
		
		#region XML Parser

        /// <summary>
        /// Gets the xml context tag
        /// </summary> 
		private static XMLContextTag GetXMLContextTag(ScintillaControl sci, Int32 position)
		{
			XMLContextTag xtag = new XMLContextTag();
			if ((position == 0) || (sci == null)) return xtag;
			StringBuilder tag = new StringBuilder();
            Char c = (Char)sci.CharAt(position - 1);
			position -= 2;
			tag.Append(c);
			while (position >= 0)
			{
				c = (Char)sci.CharAt(position);
				tag.Insert(0, c);
				if (c == '>') return xtag;
				if (c == '<') break;
				position--;
			}
			xtag.Position = position;
			xtag.Tag = tag.ToString();
            Match mTag = tagName.Match(xtag.Tag + " ");
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

        /// <summary>
        /// Gets the word from the specified position
        /// </summary> 
		private static string GetWordLeft(ScintillaControl sci, ref Int32 position)
		{
            Char c; String word = "";
            String exclude = "(){};,+///\\=:.%\"<>";
			while (position >= 0) 
			{
                c = (Char)sci.CharAt(position);
				if (c <= ' ') break;
				else if (exclude.IndexOf(c) >= 0) break;
				else word = c + word;
				position--;
			}
			return word;
		}

        /// <summary>
        /// Validates the if the tag is in quotes
        /// </summary> 
		private static Boolean InQuotes(String tag)
		{
			if (tag == null) return false;
			Int32 n = tag.Length;
			Boolean inQuotes = false;
            for (Int32 i = 0; i < n; i++)
            {
                if (tag[i] == '"') inQuotes = !inQuotes;
            }
			return inQuotes;
		}

		#endregion

    }

    public class LanguageDef
    {
        public List<HTMLTag> KnownTags;
        public List<string> Namespaces;
        public string DefaultNS;

        public LanguageDef(List<HTMLTag> knownTags, List<string> namespaces, string defaultNS)
        {
            KnownTags = knownTags;
            Namespaces = namespaces;
            DefaultNS = defaultNS;
        }
    }
}
