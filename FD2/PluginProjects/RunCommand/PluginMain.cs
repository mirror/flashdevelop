using System;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI;
using PluginCore;
using System.IO;

namespace RunCommand
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "RunCommand";
		private string pluginGuid = "E4FABF93-8767-4D15-AA35-7B00EE00D90A";
		private string pluginAuth = "Philippe Elsass";
		private string pluginHelp = "http://flashdevelop.org/community/";
		private string pluginDesc = "Add some complex commands to the menus";
		private EventType eventMask = EventType.Command;
		private IPluginHost pluginHost;
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
			get { return null; }
		}
		
		#endregion

		#region RequiredPluginMethods

		/**
		* Initializes the plugin
		*/
		public void Initialize()
		{
			this.mainForm = this.pluginHost.MainForm;
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
			if (e.Type == EventType.Command)
			{
				string command = ((TextEvent)e).Text;
				
				// Run a process captured relative to the project root
				if (command.StartsWith("Run;"))
				{
					string action = mainForm.ProcessArgString(command.Substring(4));

					// environment
					string projectDir = mainForm.ProcessArgString("@PROJECTDIR");
					if (!Directory.Exists(projectDir)) {
						ErrorHandler.ShowInfo("RunCommand error: no active project.");
						return;
					}
					string cmdPath = Environment.SystemDirectory + @"\cmd.exe";
					if (!File.Exists(cmdPath)) {
						ErrorHandler.ShowInfo("RunCommand error: cmd.exe not found.");
						return;
					}
					string currentDir = Directory.GetCurrentDirectory();
					
					// save files?
					if (action.StartsWith("SaveAS;"))
					{
						action = action.Substring(7);
						mainForm.CallCommand("SaveAllModified", ".as");
					}
					else if (action.StartsWith("SaveAll;"))
					{
						action = action.Substring(8);
						mainForm.CallCommand("SaveAllModified", null);
					}
					
					// run process
					try
					{
						System.IO.Directory.SetCurrentDirectory(projectDir);
						mainForm.CallCommand("RunProcessCaptured", cmdPath+";/c "+action);
					}
					catch (Exception ex)
					{
						ErrorHandler.ShowError("RunCommand error: "+ex.Message, ex);
					}
					finally
					{
						System.IO.Directory.SetCurrentDirectory(currentDir);
					}
				}
				
				// Edit a file in FlashDevelop
				else if (command.StartsWith("Edit;"))
				{
					string file = mainForm.ProcessArgString(command.Substring(5));
					
					if (!File.Exists(file)) {
						ErrorHandler.ShowInfo("Edit error: File not found.\n"+file);
						return;
					}
					
					mainForm.OpenSelectedFile(file);
				}
			}
		}

		/**
		* Opens the plugin panel again if closed
		*/
		public void OpenPanel(object sender, System.EventArgs e)
		{
			// no panel
		}

		#endregion

	}

}
