using System;
using System.IO;
using System.ComponentModel;
using WeifenLuo.WinFormsUI;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Helpers;
using PluginCore;

namespace AS2Context
{
    public class PluginMain : IPlugin
    {
        private String pluginName = "AS2Context";
        private String pluginGuid = "1f387fab-421b-42ac-a985-72a03534f731";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "ActionScript 2 context for the ASCompletion engine.";
        private String pluginAuth = "FlashDevelop Team";
        private String settingFilename;
        private AS2Settings settingObject;
        private Context contextInstance;

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
                case EventType.UIStarted:
                    contextInstance = new Context(settingObject);
                    // Associate this context with AS2 language
                    ASCompletion.Context.ASContext.RegisterLanguage(contextInstance, "as2");
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
            String dataPath = Path.Combine(PathHelper.DataDir, "AS2Context");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary>
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.UIStarted);
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            this.settingObject = ObjectSerializer.Deserialize<AS2Settings>(this.settingFilename) as AS2Settings;
            
            // default values
            if (this.settingObject.MMClassPath == null) this.settingObject.MMClassPath = FindMMClassPath();
            if (this.settingObject.UserClasspath == null)
            {
                if (this.settingObject.MMClassPath != null)
                    this.settingObject.UserClasspath = new String[] { this.settingObject.MMClassPath };
                else this.settingObject.UserClasspath = new String[] { };
            }
            // updating
            AddSettingsListeners();
        }

        void settingObject_OnClasspathChanged()
        {
            // update the classpath if an important setting has changed
            contextInstance.BuildClassPath();
        }

        void AddSettingsListeners()
        {
            this.settingObject.OnClasspathChanged += settingObject_OnClasspathChanged;
        }

        void RemoveSettingsListeners()
        {
            this.settingObject.OnClasspathChanged -= settingObject_OnClasspathChanged;
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            if (this.settingObject != null)
                RemoveSettingsListeners();

            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);

            AddSettingsListeners();
        }

        #endregion

        #region Macromedia/Adobe Flash IDE

        // locations in Application Data
        static readonly private string[] MACROMEDIA_VERSIONS = {
			"\\Adobe\\Flash CS3\\",
			"\\Macromedia\\Flash 8\\", 
			"\\Macromedia\\Flash MX 2004\\"
		};

        /// <summary>
        /// Explore the possible locations for the Macromedia Flash IDE classpath
        /// </summary>
        static private string FindMMClassPath()
        {
            bool found = false;
            string deflang = System.Globalization.CultureInfo.CurrentUICulture.Name;
            deflang = deflang.Substring(0, 2);
            string localAppData = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
            string cp = "";
            foreach (string path in MACROMEDIA_VERSIONS)
            {
                cp = localAppData + path;
                // default language
                if (System.IO.Directory.Exists(cp + deflang + "\\Configuration\\Classes\\"))
                {
                    cp += deflang + "\\Configuration\\Classes\\";
                    found = true;
                }
                // look for other languages
                else if (System.IO.Directory.Exists(cp))
                {
                    string[] dirs = System.IO.Directory.GetDirectories(cp);
                    foreach (string dir in dirs)
                    {
                        if (System.IO.Directory.Exists(dir + "\\Configuration\\Classes\\"))
                        {
                            cp = dir + "\\Configuration\\Classes\\";
                            found = true;
                            break;
                        }
                    }
                }
                if (found) break;
            }
            if (found) return cp;
            else return null;
        }
        #endregion
    }

}

