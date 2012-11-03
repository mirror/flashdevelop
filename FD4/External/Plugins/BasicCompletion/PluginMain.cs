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
        private Hashtable workerTable = new Hashtable();
        private Hashtable baseTable = new Hashtable();
        private Hashtable fileTable = new Hashtable();
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
            BackgroundWorker updateWorker;
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
                    }
                    break;
                }
                case EventType.FileSave:
                {
                    String file = (e as TextEvent).Value;
                    document = DocumentManager.FindDocument(file);
                    if (document != null && document.IsEditable && this.IsSupported(document))
                    {
                        if (!this.workerTable.ContainsKey(document.FileName))
                        {
                            updateWorker = new BackgroundWorker();
                            updateWorker.DoWork += new DoWorkEventHandler(this.UpdateWorkerDoWork);
                            this.workerTable[document.FileName] = updateWorker;
                        }
                        else updateWorker = this.workerTable[document.FileName] as BackgroundWorker;
                        if (!updateWorker.IsBusy) updateWorker.RunWorkerAsync(document);
                    }
                    break;
                }
            }
		}

        /// <summary>
        /// Updates the document keywords on a background worker
        /// </summary>
        private void UpdateWorkerDoWork(Object sender, DoWorkEventArgs e)
        {
            ITabbedDocument document = e.Argument as ITabbedDocument;
            this.AddDocumentKeywords(document);
        }

		#endregion

        #region Custom Methods

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
                    String entry = Regex.Replace(kc.val, @"\t|\n|\r", "");
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
            List<String> keywords = new List<String>();
            String textLang = document.SciControl.ConfigurationLanguage;
            Language language = ScintillaControl.Configuration.GetLanguage(textLang);
            if (language.characterclass != null)
            {
                String wordCharsRegex = "[" + language.characterclass.Characters + "]+";
                MatchCollection matches = Regex.Matches(document.SciControl.Text, wordCharsRegex);
                for (Int32 i = 0; i < matches.Count; i++)
                {
                    if (!keywords.Contains(matches[i].Value) && matches[i].Value.Length > 3)
                    {
                        keywords.Add(matches[i].Value);
                    }
                }
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
                List<String> fileWords = this.fileTable[file] as List<String>;
                for (Int32 i = 0; i < fileWords.Count; i++)
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
            String lang = sci.ConfigurationLanguage.ToLower();
            if (this.settingObject.EnableAutoCompletion && this.settingObject.EnabledLanguages.Contains(lang))
            {
                List<ICompletionListItem> items = this.GetCompletionListItems(lang, sci.FileName);
                if (items != null && items.Count > 0)
                {
                    items.Sort();
                    String curWord = sci.GetWordFromPosition(sci.CurrentPos);
                    if (curWord != null && curWord.Length > 2)
                    {
                        Language language = ScintillaControl.Configuration.GetLanguage(sci.ConfigurationLanguage);
                        if (language.characterclass.Characters.Contains(Char.ToString((char)value)))
                        {
                            CompletionList.Show(items, true, curWord);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Checks if the language should use basic completion 
        /// </summary>
        public Boolean IsSupported(ITabbedDocument document)
        {
            String lang = document.SciControl.ConfigurationLanguage;
            return this.settingObject.EnabledLanguages.Contains(lang);
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

