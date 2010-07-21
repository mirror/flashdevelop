using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI.Docking;
using SourceControl.Resources;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;
using ProjectManager;
using SourceControl.Actions;
using ProjectManager.Projects;
using ProjectManager.Actions;

namespace SourceControl
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "SourceControl";
        private String pluginGuid = "42ac7fab-421b-1f38-a985-5735468ac489";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Source Control integration for FlashDevelop 3.";
        private String pluginAuth = "Philippe Elsass";
        private String settingFilename;
        static private Settings settingObject;
        private Image pluginImage;
        private bool ready;

        static public Settings SCSettings { get { return settingObject; } }

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
            get { return settingObject; }
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
            this.CreateMenuItem();
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            ProjectWatcher.Dispose();
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
                    ProjectWatcher.Init();
                    ready = true;
                    break;

                // Catches Project change event and display the active project path
                case EventType.Command:
                    if (!ready) return;

                    DataEvent de = e as DataEvent;
                    string cmd = de.Action;
                    if (!cmd.StartsWith("ProjectManager.")) return;
                    switch (cmd)
                    {
                        case ProjectManagerEvents.Project:
                            ProjectWatcher.SetProject(de.Data as Project);
                            break;
                        case ProjectManagerEvents.TreeSelectionChanged:
                            ProjectWatcher.SelectionChanged();
                            break;
                        case ProjectManagerEvents.UserRefreshTree:
                            ProjectWatcher.ForceRefresh();
                            break;

                        case ProjectFileActionsEvents.FileBeforeRename:
                            try
                            {
                                de.Handled = ProjectWatcher.HandleFileBeforeRename(de.Data as string);
                            }
                            catch (Exception ex)
                            {
                                ErrorManager.ShowError(ex);
                                de.Handled = true;
                            }
                            break;
                        case ProjectFileActionsEvents.FileRename:
                            try
                            {
                                de.Handled = ProjectWatcher.HandleFileRename(de.Data as string[]);
                            }
                            catch (Exception ex)
                            {
                                ErrorManager.ShowError(ex);
                                de.Handled = true;
                            }
                            break;
                        case ProjectFileActionsEvents.FileDeleteSilent:
                            try
                            {
                                de.Handled = ProjectWatcher.HandleFileDelete(de.Data as string[], false);
                            }
                            catch (Exception ex)
                            {
                                ErrorManager.ShowError(ex);
                                de.Handled = true;
                            }
                            break;
                        case ProjectFileActionsEvents.FileDelete:
                            try
                            {
                                de.Handled = ProjectWatcher.HandleFileDelete(de.Data as string[], true);
                            }
                            catch (Exception ex)
                            {
                                ErrorManager.ShowError(ex);
                                de.Handled = true;
                            }
                            break;
                        case ProjectFileActionsEvents.FileMove:
                            try
                            {
                                de.Handled = ProjectWatcher.HandleFileMove(de.Data as string[]);
                            }
                            catch (Exception ex)
                            {
                                ErrorManager.ShowError(ex);
                                de.Handled = true;
                            }
                            break;
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
            String dataPath = Path.Combine(PathHelper.DataDir, "SourceControl");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginImage = PluginBase.MainForm.FindImage("100");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            // Set events you want to listen (combine as flags)
            EventManager.AddEventHandler(this, EventType.UIStarted | EventType.Command);
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
        /// Creates a menu item for the plugin and adds a ignored key
        /// </summary>
        public void CreateMenuItem()
        {
            
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, settingObject);
                settingObject = (Settings)obj;
            }
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, settingObject);
        }

		#endregion

	}
	
}
