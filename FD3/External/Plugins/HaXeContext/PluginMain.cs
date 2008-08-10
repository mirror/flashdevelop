using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.IO;
using PluginCore.Localization;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore;

namespace HaXeContext
{
    public class PluginMain : IPlugin
    {
        private String pluginName = "HaXeContext";
        private String pluginGuid = "ccf2c534-db6b-4c58-b90e-cd0b837e61c5";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "HaXe context for the ASCompletion engine.";
        private String pluginAuth = "FlashDevelop Team";
        private String settingFilename;
        private HaXeSettings settingObject;
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

            if (Context.TemporaryOutputFile != null && File.Exists(Context.TemporaryOutputFile))
                File.Delete(Context.TemporaryOutputFile);
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
                    // Associate this context with haXe language
                    ASCompletion.Context.ASContext.RegisterLanguage(contextInstance, "haxe");
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
            String dataPath = Path.Combine(PathHelper.DataDir, "HaXeCompletion");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "HaXeSettings.fdb");
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
            this.settingObject = ObjectSerializer.Deserialize<HaXeSettings>(this.settingFilename) as HaXeSettings;
            if (this.settingObject.HaXePath == null) this.settingObject.HaXePath = @"C:\Program Files\Motion-Twin\haxe"; // default values
            AddSettingsListeners(); // updating
        }

        /// <summary>
        /// Update the classpath if an important setting has changed
        /// </summary>
        void settingObject_OnClasspathChanged()
        {
            contextInstance.BuildClassPath();
        }

        /// <summary>
        /// 
        /// </summary>
        void AddSettingsListeners()
        {
            this.settingObject.OnClasspathChanged += settingObject_OnClasspathChanged;
        }

        /// <summary>
        /// 
        /// </summary>
        void RemoveSettingsListeners()
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
