using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace ResultsPanel
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "ResultsPanel";
        private String pluginGuid = "24df7cd8-e5f0-4171-86eb-7b2a577703ba";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds a results panel for console info to FlashDevelop";
        private String pluginAuth = "FlashDevelop Team";
        private static PanelSettings settingsObject;
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
        object IPlugin.Settings
        {
            get { return settingsObject; }
        }
		
		#endregion
		
		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.LoadSettings();
            this.InitBasics();
            this.AddEventHandlers();
            this.CreatePluginPanel();
            this.CreateMenuItem();
        }

		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            // Don't have to do anything :)
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
        public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
        {
            switch (e.Type)
            {
                case EventType.Command:
                    DataEvent evnt = (DataEvent)e;
                    if (evnt.Action == "ResultsPanel.ClearResults")
                    {
                        this.pluginUI.ClearOutput();
                        e.Handled = true;
                    }
                    else if (evnt.Action == "ResultsPanel.ShowResults")
                    {
                        this.pluginUI.DisplayOutput();
                        e.Handled = true;
                    }
                    break;

                case EventType.ProcessStart:
                    this.pluginUI.ClearOutput();
                    break;

                case EventType.ProcessEnd:
                    this.pluginUI.DisplayOutput();
                    break;

                case EventType.Trace:
                    this.pluginUI.AddLogEntries();
                    break;

                case EventType.FileOpen:
                    TextEvent fileOpen = (TextEvent)e;
                    this.pluginUI.AddSquiggles(fileOpen.Value);
                    break;

                case EventType.Keys:
                    KeyEvent ke = (KeyEvent)e;
                    if (ke.Value == settingsObject.NextError)
                    {
                        ke.Handled = true;
                        this.pluginUI.NextEntry(null, null);
                    }
                    else if (ke.Value == settingsObject.PreviousError)
                    {
                        ke.Handled = true;
                        this.pluginUI.PreviousEntry(null, null);
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
            this.pluginImage = PluginBase.MainForm.FindImage("127");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventType eventMask = EventType.ProcessEnd | EventType.ProcessStart | EventType.FileOpen | EventType.Command | EventType.Trace | EventType.Keys;
            EventManager.AddEventHandler(this, eventMask);
        }

        /// <summary>
        /// Creates a menu item for the plugin
        /// </summary>
        public void CreateMenuItem()
        {
            String title = TextHelper.GetString("Label.ViewMenuItem");
            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ViewMenu");
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(title, this.pluginImage, new EventHandler(this.OpenPanel)));
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
        /// Opens the plugin panel if closed
        /// </summary>
        public void OpenPanel(Object sender, System.EventArgs e)
        {
            this.pluginPanel.Show();
        }

		#endregion

        #region Settings

        static string SettingsDir { get { return Path.Combine(PathHelper.DataDir, "ResultsPanel"); } }
        static string SettingsPath { get { return Path.Combine(SettingsDir, "Settings.fdb"); } }

        static public PanelSettings Settings { get { return settingsObject; } }

        private void LoadSettings()
        {
            settingsObject = ObjectSerializer.Deserialize<PanelSettings>(SettingsPath);
            if (settingsObject == null) settingsObject = new PanelSettings();
        }

        #endregion

	}
	
}
