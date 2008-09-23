using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.IO;
using PluginCore.Localization;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore.Utilities;
using AS3Context.Compiler;
using System.Text.RegularExpressions;
using PluginCore;

namespace AS3Context
{
    public class PluginMain : IPlugin
    {
        private String pluginName = "AS3Context";
        private String pluginGuid = "ccf2c534-db6b-4c58-b90e-cd0b837e61c4";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "ActionScript 3 context for the ASCompletion engine.";
        private String pluginAuth = "FlashDevelop Team";
        private String settingFilename;
        static private AS3Settings settingObject;
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
        Object IPlugin.Settings
        {
            get { return settingObject; }
        }

        static public AS3Settings Settings
        {
            get { return settingObject as AS3Settings; }
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
            FlexDebugger.Stop();
            this.SaveSettings();
        }

        /// <summary>
        /// Handles the incoming events
        /// </summary>
        public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority priority)
        {
            if (priority == HandlingPriority.Low)
            {
                if (e.Type == EventType.Command)
                {
                    string action = (e as DataEvent).Action;
                    if (!(settingObject as AS3Settings).DisableFDB 
                        && action == "AS3Context.StartDebugger")
                    {
                        string workDir = (PluginBase.CurrentProject != null)
                            ? Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath)
                            : Environment.CurrentDirectory;
                        e.Handled = FlexDebugger.Start(
                            workDir,
                            (settingObject as AS3Settings).FlexSDK,
                            null
                        );
                    }
                }
                return;
            }

            else if (priority == HandlingPriority.Normal)
            {
                switch (e.Type)
                {
                    case EventType.ProcessArgs:
                        TextEvent te = e as TextEvent;
                        if (te.Value.IndexOf("$(FlexSDK)") >= 0)
                        {
                            string path = Regex.Replace(settingObject.FlexSDK, @"[\\/]bin[\\/]?$", "");
                            te.Value = te.Value.Replace("$(FlexSDK)", path);
                        }
                        break;

                    case EventType.UIStarted:
                        contextInstance = new Context(settingObject);
                        // Associate this context with AS3 language
                        ASCompletion.Context.ASContext.RegisterLanguage(contextInstance, "as3");
                        ASCompletion.Context.ASContext.RegisterLanguage(contextInstance, "mxml");
                        break;

                    case EventType.FileSave:
                    case EventType.FileSwitch:
                        if (contextInstance != null) contextInstance.OnFileOperation(e);
                        break;
                }
                return;
            }

            else if (priority == HandlingPriority.High)
            {
                if (e.Type == EventType.Command)
                {
                    string action = (e as DataEvent).Action;
                    if (action == "ProjectManager.Project")
                    {
                        FlexDebugger.Stop();
                    }
                    else if (action.StartsWith("FlashViewer."))
                    {
                        if (action == "FlashViewer.Closed")
                        {
                            FlexDebugger.Stop();
                        }
                        else if (action == "FlashViewer.External" || action == "FlashViewer.Default" 
                            || action == "FlashViewer.Popup" || action == "FlashViewer.Document")
                        {
                            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language == "as3"
                                && PluginBase.CurrentProject.TraceEnabled)
                            {
                                DataEvent de = new DataEvent(EventType.Command, "AS3Context.StartDebugger", null);
                                EventManager.DispatchEvent(this, de);
                            }
                        }
                    }
                }
            }
        }

        #endregion

        #region Custom Methods

        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "AS3Context");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary>
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.UIStarted | EventType.ProcessArgs | EventType.FileSwitch | EventType.FileSave);
            EventManager.AddEventHandler(this, EventType.Command, HandlingPriority.High);
            EventManager.AddEventHandler(this, EventType.Command, HandlingPriority.Low);
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            settingObject = ObjectSerializer.Deserialize<AS3Settings>(this.settingFilename) as AS3Settings;

            // default values
            if (settingObject.AS3ClassPath == null)
                settingObject.AS3ClassPath = @"Library\AS3\intrinsic";
            if (settingObject.FlexSDK == null) 
                settingObject.FlexSDK = @"C:\flex_sdk_3";
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
            settingObject.OnClasspathChanged += settingObject_OnClasspathChanged;
        }

        void RemoveSettingsListeners()
        {
            settingObject.OnClasspathChanged -= settingObject_OnClasspathChanged;
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            if (settingObject != null)
                RemoveSettingsListeners();

            ObjectSerializer.Serialize(this.settingFilename, settingObject);

            AddSettingsListeners();
        }

        /// <summary>
        /// Explore the possible locations for the Macromedia Flash IDE classpath
        /// </summary>
        static public string FindCS3ConfigurationPath(string flashPath)
        {
            string deflang = System.Globalization.CultureInfo.CurrentUICulture.Name;
            deflang = deflang.Substring(0, 2);
            string basePath = flashPath ?? @"C:\Program Files\Adobe\Adobe Flash CS3";
            // default language
            if (Directory.Exists(basePath + deflang + "\\Configuration\\ActionScript 3.0"))
            {
                return basePath + deflang + "\\Configuration\\";
            }
            // look for other languages
            else if (Directory.Exists(basePath))
            {
                string[] dirs = Directory.GetDirectories(basePath);
                foreach (string dir in dirs)
                {
                    if (Directory.Exists(dir + "\\Configuration\\ActionScript 3.0"))
                        return dir + "\\Configuration\\";
                }
            }
            return null;
        }
        #endregion
    
    }

}
