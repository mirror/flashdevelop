using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using PluginCore.Localization;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore;

namespace PHPContext
{
    public class PluginMain : IPlugin
    {
        private String pluginName = "PHPContext";
        private String pluginGuid = "2eecf4ad-08f5-45d7-8060-86b637e94773";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "PHP context for the ASCompletion engine.";
        private String pluginAuth = "FlashDevelop Team";
        private String languageID = "PHP"; // change also in ContextSetting class
        private String associatedSyntax = "HTML"; // ie. coloring syntax file name
        private ContextSettings settingObject;
        private String settingFilename;
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
            /*if (Context.TemporaryOutputFile != null && File.Exists(Context.TemporaryOutputFile))
            {
                File.Delete(Context.TemporaryOutputFile);
            }*/
        }

        /// <summary>
        /// Handles the incoming events
        /// </summary>
        public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
        {
            switch (e.Type)
            {
                case EventType.UIStarted :
                    contextInstance = new Context(settingObject);
                    // Associate this context with a file type
                    ASCompletion.Context.ASContext.RegisterLanguage(contextInstance, associatedSyntax);
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
            String dataPath = Path.Combine(PathHelper.DataDir, languageID + "Completion");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, languageID + "Settings.fdb");
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
            this.settingObject = ObjectSerializer.Deserialize<ContextSettings>(this.settingFilename) as ContextSettings;
            if (this.settingObject.LanguageDefinitions == null) // default values
            {
                this.settingObject.LanguageDefinitions = @"Library\PHP\Intrinsic";
            }
            AddSettingsListeners(); // updating
        }

        /// <summary>
        /// Update the classpath if an important setting has changed
        /// </summary>
        private void settingObject_OnClasspathChanged()
        { 
            contextInstance.BuildClassPath();
        }

        /// <summary>
        /// 
        /// </summary>
        private void AddSettingsListeners()
        {
            this.settingObject.OnClasspathChanged += settingObject_OnClasspathChanged;
        }

        /// <summary>
        /// 
        /// </summary>
        private void RemoveSettingsListeners()
        {
            this.settingObject.OnClasspathChanged -= settingObject_OnClasspathChanged;
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            if (this.settingObject != null) RemoveSettingsListeners();
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
            AddSettingsListeners();
        }

        #endregion

    }

}
