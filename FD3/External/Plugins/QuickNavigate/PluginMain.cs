using System;
using System.IO;
using System.Collections.Generic;
using System.Windows.Forms;
using System.ComponentModel;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore.Localization;
using PluginCore;

namespace QuickNavigate
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "QuickNavigate";
        private String pluginGuid = "ac04a177-f578-47d7-87f1-0cbc0f834446";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds quick navigation capabilities to FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private ControlClickManager controlClickManager;
        private String settingFilename;
        private Settings settingObject;

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
            if (this.settingObject.CtrlClickEnabled)
            {
                this.controlClickManager = new ControlClickManager();
            }
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
            if (e.Type == EventType.Command)
            {
                DataEvent de = (DataEvent)e;
                if (de.Action == "ProjectManager.Menu")
                {
                    this.CreateMenuItems(de.Data as ToolStripMenuItem);
                }
            }
            else if (e.Type == EventType.FileSwitch)
            {
                if (this.controlClickManager != null)
                {
                    this.controlClickManager.SciControl = PluginBase.MainForm.CurrentDocument.SciControl;
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
            String dataPath = Path.Combine(PathHelper.DataDir, this.pluginName);
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary>
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileSwitch | EventType.Command);
        }

        /// <summary>
        /// Create the menu items
        /// </summary>
        public void CreateMenuItems(ToolStripMenuItem projectMenu)
        {
            ToolStripMenuItem item = new ToolStripMenuItem(TextHelper.GetString("Label.OpenResource"), PluginBase.MainForm.FindImage("209"), new EventHandler(this.ShowResourceForm), this.settingObject.OpenResourceShortcut);
            projectMenu.DropDownItems.Insert(4, new ToolStripSeparator());
            projectMenu.DropDownItems.Insert(5, item);
            PluginBase.MainForm.IgnoredKeys.Add(this.settingObject.OpenResourceShortcut);
        }

        /// <summary>
        /// Shows the resource form
        /// </summary>
        private void ShowResourceForm(Object sender, EventArgs e)
	    {
            if (PluginBase.CurrentProject != null)
            {
                new OpenResourceForm(this).ShowDialog();
            }
	    }

        /// <summary>
        /// Gets a list of project related files
        /// </summary>
        public List<String> GetProjectFiles()
        {
            List<String> files = new List<String>();
            List<String> folders = this.GetProjectFolders();
            foreach (String folder in folders)
            {
                if (Directory.Exists(folder))
                {
                    files.AddRange(Directory.GetFiles(folder, "*.*", SearchOption.AllDirectories));
                }
            }
            return files;
        }

        /// <summary>
        /// Gets a list of project related folders
        /// </summary>
        public List<String> GetProjectFolders()
        {
            String projectFolder = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            List<String> folders = new List<String>();
            folders.Add(projectFolder);
            if (!settingObject.SearchExternalClassPath) return folders;
            foreach (String path in PluginBase.CurrentProject.SourcePaths)
            {
                if (Path.IsPathRooted(path)) folders.Add(path);
                else
                {
                    String folder = Path.GetFullPath(Path.Combine(projectFolder, path));
                    if (!folder.StartsWith(projectFolder)) folders.Add(folder);
                }
            }
            return folders;
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

		#endregion

	}
	
}
