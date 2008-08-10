using System;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using System.ComponentModel;
using PluginCore;

namespace FileExplorer
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "FileExplorer";
		private string pluginGuid = "f534a520-bcc7-4fe4-a4b9-6931948b2686";
		private string pluginAuth = "Mika Palmu & Philippe Elsass";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "Adds a file explorer panel to FlashDevelop.";
		private EventType eventMask = EventType.Command | EventType.FileOpen;
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
			System.Drawing.Image image = mainForm.GetSystemImage(81);
			/**
			*  Create panel
			*/
			this.pluginUI.Tag = "Files";
			this.pluginUI.Text = "File Explorer";
			this.pluginPanel = mainForm.CreateDockingPanel(this.pluginUI, this.pluginGuid, image, DockState.DockRight);
			/**
			*  Create menu item
			*/
			CommandBarMenu ViewMenu = mainForm.GetCBMenu("ViewMenu");
			ViewMenu.Items.AddButton(image, "&File Explorer", new EventHandler(this.OpenPanel));
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
					TextEvent te = (TextEvent)e;
					if (te.Text.StartsWith("BrowseTo;"))
					{
						this.pluginUI.BrowseTo(te.Text.Substring(9));
						te.Handled = true;
						this.OpenPanel(null, null);
					}
					break;
					
				case EventType.FileOpen:
					string file = this.mainForm.CurFile;
					if (System.IO.File.Exists(file)) this.pluginUI.AddToMRU(file);
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
