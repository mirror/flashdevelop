using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI.Docking;
using EnhancedArguments.Resources;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using EnhancedArguments.Dialogs;

namespace EnhancedArguments
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "EnhancedArguments";
		private String pluginGuid = "b1bb68f6-a84c-49aa-ae29-995fe41f8146";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds enhanced functionality to argument processing.";
        private String pluginAuth = "Mike McMullin";
        private String settingFilename;
        private Settings settingObject;

		private Dictionary<String, String> userArgs;
		private Regex reUserArgs = new Regex("\\$\\$\\(([a-z0-9]+)\\=?([^\\)]+)?\\)", RegexOptions.IgnoreCase | RegexOptions.Compiled); //\\$\\$\\(([a-z0-9]+)\\=?([a-z0-9, ]+)?\\) old
        private Regex reEnvironArgs = new Regex("\\$\\$\\(\\%([a-z]+)\\%\\)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        private Regex reSpecialArgs = new Regex("\\$\\$\\(\\#([a-z]+)\\#=?([^\\)]+)?\\)", RegexOptions.IgnoreCase | RegexOptions.Compiled);

	    #region Required Properties

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
            this.InitLocalization();
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
            switch (e.Type)
            {
                case EventType.ProcessArgs:
                    // Cast event as TextEvent
					TextEvent te = e as TextEvent;

                    if (te.Value.IndexOf("$$(") < 0) return;

                    //Special Arguments
                    if (reSpecialArgs.IsMatch(te.Value))
                        te.Value = reSpecialArgs.Replace(te.Value, new MatchEvaluator(ReplaceSpecialArgs));
                    
                    //Environmental Arguments
                    if (reEnvironArgs.IsMatch(te.Value))
                        te.Value = reEnvironArgs.Replace(te.Value, new MatchEvaluator(ReplaceEnvironmentArgs));

					//User Arguments
					if (reUserArgs.IsMatch(te.Value))
					{
						ReplaceVariablesDialog rvd = new ReplaceVariablesDialog(te.Value, reUserArgs);
						if (rvd.ShowDialog() == DialogResult.OK)
						{
							userArgs = rvd.ArgDictionary;
							te.Value = reUserArgs.Replace(te.Value, new MatchEvaluator(ReplaceUserArgs));
						}
						else
						{
							te.Value = "";
							te.Handled = true;
						}
					}

                    break;
            }
		}

		#endregion

        #region Custom Methods
       
        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "EnhancedArguments");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            // Set events you want to listen (combine as flags)
			EventManager.AddEventHandler(this, EventType.ProcessArgs, HandlingPriority.High);
            
        }

        /// <summary>
        /// Initializes the localization of the plugin
        /// </summary>
        public void InitLocalization()
        {
            LocaleVersion locale = PluginBase.MainForm.Settings.LocaleVersion;
            switch (locale)
            {
                /*
                case LocaleVersion.fi_FI : 
                    // We have Finnish available... or not. :)
                    LocaleHelper.Initialize(LocaleVersion.fi_FI);
                    break;
                */
                default : 
                    // Plugins should default to English...
                    LocaleHelper.Initialize(LocaleVersion.en_US);
                    break;
            }
            this.pluginDesc = LocaleHelper.GetString("Info.Description");
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
        /// Match evaluator for User Arguments
        /// </summary>
		private String ReplaceUserArgs(Match match)
		{
            if (match.Groups.Count > 0)
				return userArgs[match.Groups[1].Value];

			return match.Value;
		}

        /// <summary>
        /// Match evaluator for Environment Variables
        /// </summary>
		private String ReplaceEnvironmentArgs(Match match)
		{
			if (match.Groups.Count > 0)
				return System.Environment.GetEnvironmentVariable(match.Groups[1].Value);

			return match.Value;
		}

        /// <summary>
        /// Match evaluator for Special Arguments
        /// </summary>
        private String ReplaceSpecialArgs(Match match)
        {
            if (match.Groups.Count > 0)
            {
                switch (match.Groups[1].Value.ToUpper())
                {
                    case "DATETIME":
                        String dateFormat = "";
                        if (match.Groups.Count == 3) dateFormat = match.Groups[2].Value;
                        return(DateTime.Now.ToString(dateFormat));
                }
            }
            return match.Value;
        }

		#endregion

	}
	
}
