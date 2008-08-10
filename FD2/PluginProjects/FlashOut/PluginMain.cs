using System;
using System.IO;
using System.ComponentModel;
using System.Drawing;
using System.Reflection;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using AxShockwaveFlashObjects;
using ScintillaNet;
using PluginCore;

namespace FlashOut
{
	public class PluginMain : IPlugin
	{
		IPluginHost pluginHost; // set by FD

		Icon playerIcon;
		string COMMAND_POPUPSWF = "FlashOut;PopupSwf;";

		#region IPlugin Required Properties
		
		public string Name { get { return "FlashOut"; } }
		public string Guid { get { return "44ba73bf-a4d4-4225-a3a5-590c15ca3310"; } }		
		public string Author { get { return "Nick Farina"; } }
		public string Description { get { return "Adds support for viewing SWFs directly in FlashDevelop."; } }
		public string Help { get { return "www.flashdevelop.org/community/"; } }
		public EventType EventMask { get { return EventType.FileOpen | EventType.Command; } }

		[Browsable(false)]
		public IPluginHost Host
		{
			get { return this.pluginHost; }
			set { this.pluginHost = value; }
		}

		[Browsable(false)] public DockContent Panel { get { return null; } }
		[Browsable(false)] public IMainForm MainForm { get { return this.pluginHost.MainForm; } }

		#endregion

		// Required by IPlugin
		public void Dispose() {}
		
		public void Initialize()
		{
			Assembly assembly = Assembly.GetExecutingAssembly();
			playerIcon = new Icon(assembly.GetManifestResourceStream("Player.ico"));
		}

		// Receives only eventMask events
		public void HandleEvent(object sender, NotifyEvent e)
		{
			if (e.Type == EventType.FileOpen)
			{
				string path = MainForm.CurFile;
				string extension = Path.GetExtension(path);

				if (extension.ToLower() == ".swf")
					DisplaySwf(MainForm.CurFile);
			}
			else if (e.Type == EventType.Command)
			{
				TextEvent te = e as TextEvent;
				if (te.Text.StartsWith(COMMAND_POPUPSWF))
				{
					string[] split = te.Text.Split(';');
					string path = split[2];
					int width = int.Parse(split[3]);
					int height = int.Parse(split[4]);
					PopupSwf(path,width,height);
				}
			}
		}

		private void DisplaySwf(string path)
		{
			DockContent content = MainForm.CurDocument;
			ScintillaControl sci = MainForm.CurSciControl;
			
			if (content.Controls.Count == 1)
			{
				AxShockwaveFlash flash = new AxShockwaveFlash();
				flash.FSCommand += new _IShockwaveFlashEvents_FSCommandEventHandler(flash_FSCommand);
				flash.Dock = DockStyle.Fill;
				sci.Visible = false;
				sci.IsReadOnly = true;
				sci.Enabled = false;
				content.Controls.Add(flash);
				flash.LoadMovie(0,path);
			}
		}

		private void PopupSwf(string path,int width,int height)
		{
			PopupViewer viewer = new PopupViewer();
			viewer.Text = Path.GetFileName(path) + " - Player";
			viewer.Icon = playerIcon;
			viewer.ClientSize = new Size(width,height);
			viewer.Location = MainForm.CommandBarManager.Parent.Location;
			viewer.Left += 6 + 15;
			viewer.Top += 111 + 15;

			AxShockwaveFlash flash = new AxShockwaveFlash();
			flash.FSCommand += new _IShockwaveFlashEvents_FSCommandEventHandler(flash_FSCommand);
			flash.Dock = DockStyle.Fill;
			
			viewer.Controls.Add(flash);
			viewer.Show();

			flash.LoadMovie(0,path);
		}

		private void flash_FSCommand(object sender, _IShockwaveFlashEvents_FSCommandEvent e)
		{
			if (e.command == "trace")
				MainForm.AddTraceLogEntry(e.args,1);
		}
	}
}
