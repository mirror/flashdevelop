using System;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using System.ComponentModel;
using PluginCore;

namespace SnippetsPanel
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "SnippetsPanel";
		private string pluginGuid = "bd02784a-da47-401f-a703-4605fb4b98c4";
		private string pluginAuth = "Mika Palmu & Philippe Elsass";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "Adds a snippet manager panel to FlashDevelop.";
		private EventType eventMask = 0;
		private IPluginHost pluginHost;
		private DockContent pluginPanel;
		private PluginUI pluginUI;
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
			System.Drawing.Image image = mainForm.GetSystemImage(117);
			/**
			*  Create panel
			*/
			this.pluginUI.Tag = "Snippets";
			this.pluginUI.Text = "Snippets";
			this.pluginPanel = mainForm.CreateDockingPanel(this.pluginUI, this.pluginGuid, image, DockState.DockBottomAutoHide);
			/**
			*  Create menu item
			*/
			CommandBarMenu ViewMenu = mainForm.GetCBMenu("ViewMenu");
			ViewMenu.Items.AddButton(image, "&Snippets Panel", new EventHandler(this.OpenPanel));
		}
		
		/**
		* Disposes the plugin
		*/
		public void Dispose()
		{
			// Free system ressources
		}
		
		/**
		* Handles the incoming events
		* Receives only events in EventMask
		*/
		public void HandleEvent(object sender, NotifyEvent e)
		{
			// No events to handle
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
