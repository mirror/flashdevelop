using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.ComponentModel;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Controls;
using PluginCore.Localization;
using ScintillaNet.Configuration;
using ScintillaNet;
using PluginCore;

namespace BasicCompletion
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "BasicCompletion";
        private String pluginGuid = "c5564dec-5288-4bbb-b286-a5678536698b";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds global basic code completion support to FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private Hashtable updateTable = new Hashtable();
        private Hashtable baseTable = new Hashtable();
        private Hashtable fileTable = new Hashtable();
        private System.Timers.Timer updateTimer;
        private String settingFilename;
        private Settings settingObject;

	    #region Required Properties

        /// <summary>
        /// Api level of the plugin
        /// </summary>
        public Int32 Api
        {
            get { return 1; }
        }

        /// <summary>
        /// Name of the plugin
        /// </summary> 
        public String Name
		{
			get { return this.pluginName; }
		}

        /// <summary>
        /// GUID of the plugin
        /// </summary>
        public String Guid
		{
			get { return this.pluginGuid; }
		}

        /// <summary>
        /// Author of the plugin
        /// </summary> 
        public String Author
		{
			get { return this.pluginAuth; }
		}

        /// <summary>
        /// Description of the plugin
        /// </summary> 
        public String Description
		{
			get { return this.pluginDesc; }
		}

        /// <summary>
        /// Web address for help
        /// </summary> 
        public String Help
		{
			get { return this.pluginHelp; }
		}

        /// <summary>
        /// Object that contains the settings
        /// </summary>
        [Browsable(false)]
        public Object Settings
        {
            get { return this.settingObject; }
        }
		
		#endregion
		
		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.InitTimer();
            this.InitBasics();
            this.LoadSettings();
            this.AddEventHandlers();
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            this.SaveSettings();
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document == null || !document.IsEditable) return;
            switch (e.Type)
            {
                case EventType.Keys:
                {
                    Keys keys = (e as KeyEvent).Value;
                    if (this.IsSupported(document) && keys == (Keys.Control | Keys.Space))
                    {
                        String lang = document.SciControl.ConfigurationLanguage;
                        List<ICompletionListItem> items = this.GetCompletionListItems(lang, document.FileName);
                        if (items != null && items.Count > 0)
                        {
                            items.Sort();
                            Int32 curPos = document.SciControl.CurrentPos;
                            String curWord = document.SciControl.GetWordFromPosition(curPos);
                            if (curWord == null) curWord = String.Empty;
                            CompletionList.Show(items, false, curWord);
                            e.Handled = true;
                        }
                    }
                    else if (this.IsSupported(document) && keys == (Keys.Control | Keys.Alt | Keys.Space))
                    {
                        PluginBase.MainForm.CallCommand("InsertSnippet", "null");
                        e.Handled = true;
                    }
                    break;
                }
                case EventType.FileSwitch:
                case EventType.SyntaxChange:
                case EventType.ApplySettings:
                {
                    if (this.IsSupported(document))
                    {
                        String language = document.SciControl.ConfigurationLanguage;
                        if (!this.baseTable.ContainsKey(language)) this.AddBaseKeywords(language);
                        if (!this.fileTable.ContainsKey(document.FileName)) this.AddDocumentKeywords(document);
                        if (this.updateTable.ContainsKey(document.FileName)) // Need to update after save?
                        {
                            this.updateTable.Remove(document.FileName);
                            this.AddDocumentKeywords(document);
                        }
                        this.updateTimer.Stop();
                    }
                    break;
                }
                case EventType.FileSave:
                {
                    TextEvent te = e as TextEvent;
                    if (te.Value == document.FileName && this.IsSupported(document)) this.AddDocumentKeywords(document);
                    else
                    {
                        ITabbedDocument saveDoc = DocumentManager.FindDocument(te.Value);
                        if (saveDoc != null && saveDoc.IsEditable && this.IsSupported(saveDoc))
                        {
                            this.updateTable[te.Value] = true;
                        }
                    }
                    break;
                }
            }
		}

		#endregion

        #region Custom Methods

        /// <summary>
        /// Initializes the update timer
        /// </summary>
        public void InitTimer()
        {
            this.updateTimer = new System.Timers.Timer();
            this.updateTimer.SynchronizingObject = PluginCore.PluginBase.MainForm as Form;
            this.updateTimer.Elapsed += new System.Timers.ElapsedEventHandler(this.UpdateTimerElapsed);
            this.updateTimer.Interval = 500;
        }

        /// <summary>
        /// After the timer elapses, update doc keywords
        /// </summary>
        private void UpdateTimerElapsed(Object sender, System.Timers.ElapsedEventArgs e)
        {
            ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;
            if (doc != null && doc.IsEditable && this.IsSupported(doc))
            {
                this.AddDocumentKeywords(doc);
            }
        }

        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "BasicCompletion");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            UITools.Manager.OnCharAdded += new UITools.CharAddedHandler(this.SciControlCharAdded);
            UITools.Manager.OnTextChanged += new UITools.TextChangedHandler(this.SciControlTextChanged);
            EventType eventTypes = EventType.Keys | EventType.FileSave | EventType.ApplySettings | EventType.SyntaxChange | EventType.FileSwitch;
            EventManager.AddEventHandler(this, eventTypes);
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            this.settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
                this.settingObject = (Settings)obj;
            }
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

        /// <summary>
        /// Adds base keywords from config file to hashtable
        /// </summary>
        public void AddBaseKeywords(String language)
        {
            List<String> keywords = new List<String>();
            Language lang = ScintillaControl.Configuration.GetLanguage(language);
            for (Int32 i = 0; i < lang.usekeywords.Length; i++)
            {
                UseKeyword usekeyword = lang.usekeywords[i];
                KeywordClass kc = ScintillaControl.Configuration.GetKeywordClass(usekeyword.cls);
                if (kc != null)
                {
                    String entry = Regex.Replace(kc.val, @"\t|\n|\r", " ");
                    String[] words = entry.Split(new char[]{' '}, StringSplitOptions.RemoveEmptyEntries);
                    for (Int32 j = 0; j < words.Length; j++)
                    {
                        if (words[j].Length > 3 && !keywords.Contains(words[j]) && !words[j].StartsWith("\x5E"))
                        {
                            keywords.Add(words[j]);
                        }
                    }
                }
            }
            this.baseTable[language] = keywords;
        }

        /// <summary>
        /// Adds document keywords from config file to hashtable
        /// </summary>
        public void AddDocumentKeywords(ITabbedDocument document)
        {
            String textLang = document.SciControl.ConfigurationLanguage;
            Language language = ScintillaControl.Configuration.GetLanguage(textLang);
            if (language.characterclass != null)
            {
                String wordCharsRegex = "[" + language.characterclass.Characters + "]{2,}";
                MatchCollection matches = Regex.Matches(document.SciControl.Text, wordCharsRegex);
                Dictionary<Int32, String> words = new Dictionary<Int32, String>();
                for (Int32 i = 0; i < matches.Count; i++)
                {
                    String word = matches[i].Value;
                    Int32 hash = word.GetHashCode();
                    if (words.ContainsKey(hash)) continue;
                    words.Add(hash, word);
                }
                String[] keywords = new String[words.Values.Count];
                words.Values.CopyTo(keywords, 0);
                this.fileTable[document.FileName] = keywords;
            }
        }

        /// <summary>
        /// Gets the completion list items combining base and doc keywords
        /// </summary>
        public List<ICompletionListItem> GetCompletionListItems(String lang, String file)
        {
            List<String> allWords = new List<String>();
            if (this.baseTable.ContainsKey(lang))
            {
                List<String> baseWords = this.baseTable[lang] as List<String>;
                allWords.AddRange(baseWords);
            }
            if (this.fileTable.ContainsKey(file))
            {
                String[] fileWords = this.fileTable[file] as string[];
                for (Int32 i = 0; i < fileWords.Length; i++)
                {
                    if (!allWords.Contains(fileWords[i])) allWords.Add(fileWords[i]);
                }
            }
            List<ICompletionListItem> items = new List<ICompletionListItem>();
            for (Int32 j = 0; j < allWords.Count; j++) items.Add(new CompletionItem(allWords[j]));
            return items;
        }

        /// <summary>
        /// Shows the completion list automaticly after typing three chars
        /// </summary>
        private void SciControlCharAdded(ScintillaControl sci, Int32 value)
        {
            String language = sci.ConfigurationLanguage.ToLower();
            if (this.IsSupported(language))
            {
                List<ICompletionListItem> items = this.GetCompletionListItems(language, sci.FileName);
                if (items != null && items.Count > 0)
                {
                    items.Sort();
                    String curWord = sci.GetWordFromPosition(sci.CurrentPos);
                    if (curWord != null && curWord.Length > 2)
                    {
                        Language config = ScintillaControl.Configuration.GetLanguage(sci.ConfigurationLanguage);
                        if (config.characterclass.Characters.Contains(Char.ToString((char)value)))
                        {
                            CompletionList.Show(items, true, curWord);
                            CompletionList.DisableAutoInsertion();
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Starts the timer for the document keywords updating
        /// </summary>
        private void SciControlTextChanged(ScintillaControl sci, int position, int length, int linesAdded)
        {
            String language = sci.ConfigurationLanguage.ToLower();
            if (this.IsSupported(language))
            {
                this.updateTimer.Stop();
                this.updateTimer.Interval = Math.Max(500, sci.Length / 10);
                this.updateTimer.Start();
            }
        }

        /// <summary>
        /// Checks if the language/document should use basic completion 
        /// </summary>
        public Boolean IsSupported(String language)
        {
            var count = this.settingObject.SupportedLanguages.Count;
            if (this.settingObject.DisableAutoCompletion) return false;
            else if (count > 0) return this.settingObject.SupportedLanguages.Contains(language);
            else return BasicCompletion.Settings.DEFAULT_LANGUAGES.Contains(language);
        }
        public Boolean IsSupported(ITabbedDocument document)
        {
            String language = document.SciControl.ConfigurationLanguage.ToLower();
            return this.IsSupported(language);
        }

		#endregion

	}

    #region Extra Classes

    /// <summary>
    /// Simple completion list item
    /// </summary>
    public class CompletionItem : ICompletionListItem, IComparable, IComparable<ICompletionListItem>
    {
        private string label;
        public CompletionItem(string label)
        {
            this.label = label;
        }
        public string Label
        {
            get { return label; }
        }
        public string Description
        {
            get { return TextHelper.GetString("Info.CompletionItemDesc"); }
        }
        public System.Drawing.Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)PluginBase.MainForm.FindImage("315"); }
        }
        public string Value
        {
            get { return label; }
        }
        Int32 IComparable.CompareTo(Object obj)
        {
            return String.Compare(Label, (obj as ICompletionListItem).Label, true);
        }
        Int32 IComparable<ICompletionListItem>.CompareTo(ICompletionListItem other)
        {
            return String.Compare(Label, other.Label, true);
        }
    }

    #endregion

}

