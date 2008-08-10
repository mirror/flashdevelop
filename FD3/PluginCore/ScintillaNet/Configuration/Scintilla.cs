using System;
using System.Runtime;
using System.Xml.Serialization;

namespace ScintillaNet.Configuration
{
    [SerializableAttribute()]
    public class Scintilla : ConfigFile
    {
        private Language[] _languages;
        
    	[XmlArrayItemAttribute("value")]
        [XmlArrayAttribute("globals")]
        public Value[] globals;

        [XmlArrayAttribute("style-classes")]
        [XmlArrayItemAttribute("style-class")]
        public StyleClass[] styleclasses;

        [XmlArrayItemAttribute("keyword-class")]
        [XmlArrayAttribute("keyword-classes")]
        public KeywordClass[] keywordclass;

        [XmlArrayItemAttribute("language")]
        [XmlArrayAttribute("languages")]
        public Language[] languages;

		[XmlArrayItemAttribute("charcacter-class")]
		[XmlArrayAttribute("character-classes")]
		public CharacterClass[] characterclasses;

        protected override Scintilla ChildScintilla
        {
            get { return this; }
        }
        
		public bool IsKnownFile(string file)
		{
			string filemask = System.IO.Path.GetExtension(file).ToLower().Substring(1);
			foreach (Language lang in this.AllLanguages)
			{
				string extensions = ","+lang.fileextensions+",";
				if (extensions.IndexOf(","+filemask+",") >- 1)
				{
					return true;
				}
			}
			return false;
		}

		public string GetLanguageFromFile(string file)
		{
			string defaultLanguage = "text";
			string filemask = System.IO.Path.GetExtension(file);
			if (filemask.Length == 0) return defaultLanguage;
			filemask = filemask.ToLower().Substring(1);
			foreach (Language lang in this.AllLanguages)
			{
				string extensions = ","+lang.fileextensions+",";
				if (extensions.IndexOf(",*,") > -1)
				{
					defaultLanguage = lang.name;
				}
				if (extensions.IndexOf(","+filemask+",") > -1)
				{
					return lang.name;
				}
			}
			return defaultLanguage;
		}
		
		public Language[] AllLanguages
		{
			get
			{
				if (_languages == null)
				{
					System.Collections.Hashtable result = new System.Collections.Hashtable();
					if (MasterScintilla == this)
					{
						// Check the children first (from the end)
						for (int i = includedFiles.Length-1; i>-1; i--)
						{
							Scintilla child = (Scintilla)(includedFiles[i]);
							Language[] kids = child.AllLanguages;
							foreach (Language k in kids)
							{
								if (!result.ContainsKey(k.name )) result.Add(k.name, k);
							}
						}
					}
					// Other wise just check here.
					for (int i = languages.Length-1; i>-1; i--)
					{
						if (!result.ContainsKey(languages[i].name)) result.Add(languages[i].name, languages[i]);
					}
					_languages = new Language[result.Count];
					result.Values.CopyTo(_languages, 0);
				}
				return _languages;	
			}
		}

		public Value GetValue(string keyName)
		{
			Value result = null;
			if (MasterScintilla == this)
			{
				// Check the children first (from the end)
				for (int i = includedFiles.Length-1; i>-1; i--)
				{
					Scintilla child = (Scintilla)(includedFiles[i]);
					result = child.GetValue(keyName);
					if (result != null) return result;
				}
			}
			// Other wise just check here.
			for (int i = globals.Length-1; i>-1; i--)
			{
				if (globals[i].name.Equals(keyName)) result = globals[i];
			}
			return result;	
		}
		
		public CharacterClass GetCharacterClass(string keyName)
		{
			CharacterClass result = null;
			if (MasterScintilla == this)
			{
				// Check the children first (from the end)
				for (int i = includedFiles.Length-1; i>-1; i--)
				{
					Scintilla child = (Scintilla)(includedFiles[i]);
					result = child.GetCharacterClass(keyName);
					if (result != null) return result;
				}
			}
			// Other wise just check here.
			for (int i = characterclasses.Length-1; i>-1 ;i--)
			{
				if (characterclasses[i].name.Equals(keyName)) result = characterclasses[i];
			}
			return result;	
		}


        public StyleClass GetStyleClass(string styleName)
        {
			StyleClass result = null;
			if (MasterScintilla == this)
			{
				// Check the children first (from the end)
				for (int i = includedFiles.Length-1; i>-1; i--)
				{
					Scintilla child = (Scintilla)(includedFiles[i]);
					result = child.GetStyleClass(styleName);
					if (result != null) return result;
				}
			}
			// Other wise just check here.
			for (int i = styleclasses.Length-1; i>-1; i--)
			{
				if (styleclasses[i].name.Equals(styleName)) result = styleclasses[i];
			}
			return result;	
		}

        public KeywordClass GetKeywordClass(string keywordName)
        {
			KeywordClass result = null;
			if (MasterScintilla == this)
			{
				// Check the children first (from the end)
				for (int i = includedFiles.Length-1; i>-1; i--)
				{
					Scintilla child = (Scintilla)(includedFiles[i]);
					result = child.GetKeywordClass(keywordName);
					if (result != null) return result;
				}
			}
			// Other wise just check here.
			for (int i = keywordclass.Length-1; i>-1; i--)
			{
				if (keywordclass[i].name.Equals(keywordName)) result = keywordclass[i];
			}
			return result;	
		}

        public Language GetLanguage(string languageName)
        {
			Language result = null;
			if (MasterScintilla == this)
			{
				// Check the children first (from the end)
				for (int i = includedFiles.Length-1; i>-1; i--)
				{
					Scintilla child = (Scintilla)(includedFiles[i]);
					result = child.GetLanguage(languageName);
					if (result != null) return result;
				}
			}
			// Other wise just check here.
			for (int i = languages.Length-1; i>-1; i--)
			{
				if (languages[i].name.Equals(languageName)) result = languages[i];
			}
			return result;	
		}

        public override void init(ConfigurationUtility utility, ConfigFile theParent)
        {
            base.init(utility, theParent);
            if (languages == null) languages = new Language[0];
            if (styleclasses == null)  styleclasses = new StyleClass[0];
            if (keywordclass == null) keywordclass = new KeywordClass[0];
            if (globals == null) globals = new Value[0];
            for (int i2 = 0; i2<languages.Length; i2++)
            {
                languages[i2].init(utility, _parent);
            }
            for (int k = 0; k<styleclasses.Length; k++)
            {
                styleclasses[k].init(utility, _parent);
            }
            for (int j = 0; j<keywordclass.Length; j++)
            {
                keywordclass[j].init(utility, _parent);
            }
			for (int i1 = 0; i1<globals.Length; i1++)
			{
				globals[i1].init(utility, _parent);
			}
			if (characterclasses == null) characterclasses = new CharacterClass[0];
			for (int k = 0; k<characterclasses.Length; k++)
			{
				characterclasses[k].init(utility, _parent);
			}
		}
        
    }

}
