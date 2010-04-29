using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore.Utilities;
using PluginCore;

namespace CodeAnalyzer
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "CodeAnalyzer";
        private String pluginGuid = "a6bab962-9ee8-4ed7-b5f7-08c3367eaf5e";
		private String pluginDesc = "Integrates Flex PMD code analyzer into FlashDevelop.";
        private String pluginHelp = "www.flashdevelop.org/community/";
		private String pluginAuth = "FlashDevelop Team";
        private ToolStripMenuItem menuItem;
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
			this.CreateMenuItem();
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
                case EventType.ApplySettings:
                    PluginBase.MainForm.IgnoredKeys.Add(this.settingObject.AnalyzeShortcut);
                    this.menuItem.ShortcutKeys = this.settingObject.AnalyzeShortcut;
                    break;

                case EventType.Command:
                    if (((DataEvent)e).Action == "ProjectManager.Project")
                    {
                        IProject project = PluginBase.CurrentProject;
                        this.menuItem.Enabled = (project != null && project.Language == "as3");
                    }
                    break;
            }
		}
		
		#endregion

		#region Custom Methods
		
		/// <summary>
		/// Initializes important variables
		/// </summary>
		private void InitBasics()
		{
            String dataPath = Path.Combine(PathHelper.DataDir, "CodeAnalyzer");
			if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
			this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Decription");
		}

        /// <summary>
        /// Listen for the necessary events
        /// </summary>
        private void AddEventHandlers()
        {
            EventType events = EventType.ApplySettings | EventType.Command;
            EventManager.AddEventHandler(this, events);
        }

		/// <summary>
		/// Creates a menu item for the plugin and adds a ignored key
		/// </summary>
		private void CreateMenuItem()
		{
            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("FlashToolsMenu");
            this.menuItem = new ToolStripMenuItem(TextHelper.GetString("Label.AnalyzeProject"), null, new EventHandler(this.Analyze), this.settingObject.AnalyzeShortcut);
			PluginBase.MainForm.IgnoredKeys.Add(this.settingObject.AnalyzeShortcut);
            viewMenu.DropDownItems.Insert(2, this.menuItem);
            this.menuItem.Enabled = false;
		}

        /// <summary>
        /// Analyzes the current project
        /// </summary>
        private void Analyze(Object sender, System.EventArgs e)
        {
            if (PluginBase.CurrentProject != null)
            {
                String pmdDir = Path.Combine(PathHelper.ToolDir, "flexpmd");
                String pmdJar = Path.Combine(pmdDir, "flex-pmd-command-line-1.1.jar");
                String ruleFile = Path.Combine(this.GetProjectPath(), "Ruleset.xml");
                if (!File.Exists(ruleFile)) ruleFile = settingObject.PMDRuleset; // Use default...
                PMDRunner.Analyze(pmdJar, this.GetProjectPath(), this.GetSourcePath(), ruleFile);
            }
        }

        /// <summary>
        /// Gets the first available source path
        /// </summary>
        private String GetSourcePath()
        {
            if (PluginBase.CurrentProject.SourcePaths.Length > 0)
            {
                String first = PluginBase.CurrentProject.SourcePaths[0];
                return Path.Combine(this.GetProjectPath(), first);
            }
            else return Path.Combine(this.GetProjectPath(), "src");
        }

        /// <summary>
        /// Gets the root directory of a project
        /// </summary>
        private String GetProjectPath()
        {
            return Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
        }

		/// <summary>
		/// Loads the plugin settings
		/// </summary>
		private void LoadSettings()
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
		private void SaveSettings()
		{
			ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
		}

		#endregion

	}
	
}