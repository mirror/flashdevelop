using System;
using System.IO;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace TaskListPanel
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "TaskListPanel";
        private String pluginGuid = "40feac2b-a68a-498e-ad78-52a8268efa45";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds a task list panel to FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private String settingFilename;
        private Settings settingObject;
        private DockContent pluginPanel;
        private PluginUI pluginUI;
        private Image pluginImage;

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
            this.CreateMenuItem();
            this.CreatePluginPanel();
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            this.SaveSettings();
            this.pluginUI.Terminate();
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            switch (e.Type)
            {
                case EventType.UIStarted:
                    EventManager.AddEventHandler(this, EventType.Command);
                    break;

                case EventType.Command:
                    DataEvent de = (DataEvent)e;
                    if (de.Action == "ProjectManager.Project")
                    {
                        this.pluginUI.InitProject();
                    }
                    break;
            }
		}
		
		#endregion

        #region Custom Methods

        /// <summary>
        /// Access to the mainform
        /// </summary>
        public static IMainForm MainForm 
        { 
            get { return PluginBase.MainForm; } 
        }

        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            this.pluginDesc = TextHelper.GetString("Info.Description");
            String dataPath = Path.Combine(PathHelper.DataDir, "TaskListPanel");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginImage = PluginBase.MainForm.FindImage("75");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.UIStarted);
        }

        /// <summary>
        /// Creates a plugin panel for the plugin
        /// </summary>
        public void CreatePluginPanel()
        {
            this.pluginUI = new PluginUI(this);
            this.pluginUI.Text = TextHelper.GetString("Title.PluginPanel");
            this.pluginPanel = PluginBase.MainForm.CreateDockablePanel(this.pluginUI, this.pluginGuid, this.pluginImage, DockState.DockBottomAutoHide);
        }

        /// <summary>
        /// Creates a menu item for the plugin and adds a ignored key
        /// </summary>
        public void CreateMenuItem()
        {
            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ViewMenu");
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ViewMenuItem"), this.pluginImage, new EventHandler(this.OpenPanel), null));
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
                AddSettingsListeners();
            }
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            this.RemoveSettingsListeners();
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
            this.AddSettingsListeners();
        }

        /// <summary>
        /// Opens the plugin panel if closed
        /// </summary>
        public void OpenPanel(Object sender, System.EventArgs e)
        {
            this.pluginPanel.Show();
        }

        /// <summary>
        /// Adds the listeners to the setting object
        /// </summary>
        private void AddSettingsListeners()
        {
            if (this.settingObject != null)
            {
                this.settingObject.OnExtensionChanged += new ExtensionChangedEvent(this.SettingObjectOnSettingsChanged);
                this.settingObject.OnImagesIndexChanged += new ImagesIndexChangedEvent(this.SettingObjectOnSettingsChanged);
                this.settingObject.OnGroupsChanged += new GroupsChangedEvent(this.SettingObjectOnSettingsChanged);
            }
        }

        /// <summary>
        /// Removes the listeners from the setting object
        /// </summary>
        private void RemoveSettingsListeners()
        {
            if (this.settingObject != null)
            {
                this.settingObject.OnExtensionChanged -= new ExtensionChangedEvent(this.SettingObjectOnSettingsChanged);
                this.settingObject.OnImagesIndexChanged -= new ImagesIndexChangedEvent(this.SettingObjectOnSettingsChanged);
                this.settingObject.OnGroupsChanged -= new GroupsChangedEvent(this.SettingObjectOnSettingsChanged);
            }
        }

        /// <summary>
        /// When settings have changed, refresh!
        /// </summary>
        private void SettingObjectOnSettingsChanged()
        {
            this.pluginUI.UpdateSettings();
        }

		#endregion

	}
	
}
