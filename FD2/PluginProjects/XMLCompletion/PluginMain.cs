using System;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI;
using PluginCore;
using PluginCore.Controls;

namespace XMLCompletion
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "XMLCompletion";
		private string pluginGuid = "cfdd5c07-1516-4e2b-8791-a3a40eecc277";
		private string pluginAuth = "Philippe Elsass";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "HTML / XML coding helpers";
		private EventType eventMask = EventType.FileSwitch | EventType.LanguageChange | EventType.Shortcut | EventType.SettingUpdate;
		private IPluginHost pluginHost;
		private IMainForm mainForm;
		private DockContent pluginPanel;
		
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

		#region RequiredPluginMethods

		/**
		* Initializes the plugin
		*/
		public void Initialize()
		{
			mainForm = this.pluginHost.MainForm;
			pluginPanel = null;

			// listen to keys
			XMLComplete.Init(mainForm);
			UITools.OnCharAdded += new UITools.CharAddedHandler( XMLComplete.OnChar );
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
				case EventType.FileSwitch:
				case EventType.LanguageChange:
					XMLComplete.CurrentFile = mainForm.CurFile;
					break;
				
				case EventType.Shortcut:
					e.Handled = XMLComplete.OnShortCut( ((KeyEvent)e).Value );
					break;
				
				case EventType.SettingUpdate:
					XMLComplete.UpdateSettings();
					break;
			}
		}

		/**
		* Opens the plugin panel again if closed
		*/
		public void OpenPanel(object sender, System.EventArgs e)
		{
			// show pluginPanel
		}

		#endregion

	}

}
