using System;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using System.ComponentModel;
using PluginCore;

namespace ResultsPanel
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "ResultsPanel";
		private string pluginGuid = "24df7cd8-e5f0-4171-86eb-7b2a577703ba";
		private string pluginAuth = "Mika Palmu & Philippe Elsass";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "Adds a results panel for console info to FlashDevelop.";
		private EventType eventMask = EventType.ProcessStart | EventType.ProcessEnd | EventType.LogEntry | EventType.FileOpen | EventType.Command;
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
			System.Drawing.Image image = mainForm.GetSystemImage(127);
			/**
			*  Create panel
			*/
			this.pluginUI.Tag = "Results";
			this.pluginUI.Text = "Results";
			this.pluginPanel = mainForm.CreateDockingPanel(this.pluginUI, this.pluginGuid, image, DockState.DockBottomAutoHide);
			/**
			*  Create menu item
			*/
			CommandBarMenu ViewMenu = mainForm.GetCBMenu("ViewMenu");
			ViewMenu.Items.AddButton(image, "&Results Panel", new EventHandler(this.OpenPanel));
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
				case EventType.Command:
					if (((TextEvent)e).Text == "ClearResults")
					{
						e.Handled = true;
						this.pluginUI.ClearOutput();
					}
					else if (((TextEvent)e).Text == "ShowResults")
					{
						e.Handled = true;
						this.pluginUI.DisplayOutput();
					}
					break;
					
				case EventType.ProcessStart:
					this.pluginUI.ClearOutput();
					break;
					
				case EventType.ProcessEnd:
					this.pluginUI.DisplayOutput();
					break;
				
				case EventType.LogEntry:
					this.pluginUI.AddLogEntries();
					break;
				
				case EventType.FileOpen:
					this.pluginUI.AddSquiggles( ((TextEvent)e).Text );
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
