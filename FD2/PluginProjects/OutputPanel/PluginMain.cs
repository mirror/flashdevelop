using System;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using System.ComponentModel;
using PluginCore;

namespace OutputPanel
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "OutputPanel";
		private string pluginGuid = "54749f71-694b-47e0-9b05-e9417f39f20d";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginAuth = "Mika Palmu & Philippe Elsass";
		private string pluginDesc = "Adds a output panel for debug messages to FlashDevelop.";
		private EventType eventMask = EventType.ProcessStart | EventType.ProcessEnd | EventType.LogEntry | EventType.SettingUpdate;
		private IPluginHost pluginHost;
		private PluginUI pluginUI;
		private DockContent pluginPanel;
		private IMainForm mainForm;

		#region RequiredPluginVariables
		
		public string Name
		{
			get { return this.pluginName; }
		}

		public string Guid
		{
			get { return this.pluginGuid; }
		}
		
		public string Author
		{
			get { return this.pluginAuth; }
		}
		
		public string Description
		{
			get { return this.pluginDesc; }
		}
		
		public string Help
		{
			get { return this.pluginHelp; }
		}
		
		public EventType EventMask
		{
			get { return this.eventMask; }
		}
		
		[Browsable(false)]
		public IPluginHost Host
		{
			get { return this.pluginHost; }
			set	{ this.pluginHost = value; }
		}
		
		[Browsable(false)]
		public DockContent Panel
		{
			get { return this.pluginPanel; }
		}
		
		#endregion
		
		#region PluginProperties
		
		[Browsable(false)]
		public IMainForm MainForm
		{
			get { return this.mainForm; }
		}
		
		#endregion
		
		#region RequiredPluginMethods
		
		/**
		* Initializes the plugin
		*/
		public void Initialize()
		{
			this.mainForm = this.pluginHost.MainForm;
			this.pluginUI = new PluginUI(this);
			System.Drawing.Image image = mainForm.GetSystemImage(22);
			/**
			*  Create panel
			*/
			this.pluginUI.Tag = "Output";
			this.pluginUI.Text = "Output";
			this.pluginPanel = mainForm.CreateDockingPanel(this.pluginUI, this.pluginGuid, image, DockState.DockBottomAutoHide);
			/**
			*  Create menu item
			*/
			CommandBarMenu ViewMenu = mainForm.GetCBMenu("ViewMenu");
			ViewMenu.Items.AddButton(image, "&Output Panel", new EventHandler(this.OpenPanel));
		}
		
		/**
		* Disposes the plugin
		*/
		public void Dispose()
		{
			// free system ressources
		}
		
		/**
		* Handles the incoming events
		* Receives only events in EventMask
		*/
		public void HandleEvent(object sender, NotifyEvent e)
		{
			switch (e.Type)
			{
				case EventType.ProcessStart:
					this.pluginUI.ClearOutput();
					break;
					
				case EventType.ProcessEnd:
					if (this.pluginUI.ShowOnProcessEnd && !this.pluginUI.ShowOnOutput) 
					{
						this.pluginUI.DisplayOutput();
						if (this.MainForm.CurSciControl != null) this.MainForm.CurSciControl.Focus();
					}
					break;
					
				case EventType.LogEntry:
					this.pluginUI.AddLogEntries();
					break;
				
				case EventType.SettingUpdate:
					this.pluginUI.UpdateSettings();
					break;
			}
		}
		
		/**
		* Opens the plugin panel again if closed
		*/
		public void OpenPanel(object sender, System.EventArgs e)
		{
			this.pluginPanel.Show();
		}
		
		#endregion
		
	}
	
}
