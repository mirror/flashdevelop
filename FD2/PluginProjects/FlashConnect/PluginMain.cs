using System;
using System.Text;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using System.Net.Sockets;
using System.ComponentModel;
using System.Web;
using System.IO;
using System.Xml;
using PluginCore;

namespace FlashConnect
{
	public class PluginMain : IPlugin
	{
		private string pluginName = "FlashConnect";
		private string pluginGuid = "425ae753-fdc2-4fdf-8277-c47c39c2e26b";
		private string pluginAuth = "Mika Palmu";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "Adds a xml socket to FlashDevelop that let's you trace messages from outside of FlashDevelop.";
		private readonly byte[] RESULT_INVALID = Encoding.Default.GetBytes("<flashconnect status='1'/>\0");
		private readonly byte[] RESULT_NOTFOUND = Encoding.Default.GetBytes("<flashconnect status='2'/>\0");
		private EventType eventMask = EventType.CustomData;
		private IPluginHost pluginHost;
		private XmlSocket xmlSocket;
		private IMainForm mainForm;
		private string cHost;
		private bool cEnabled;
		private bool cDebug;
		private int cPort;

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
			try
			{
				/**
				* Check settings
				*/
				if (!this.mainForm.MainSettings.HasKey("FlashConnect.Host"))
				{
					this.mainForm.MainSettings.AddValue("FlashConnect.Host", "127.0.0.1");
				}
				if (!this.mainForm.MainSettings.HasKey("FlashConnect.Enabled"))
				{
					this.mainForm.MainSettings.AddValue("FlashConnect.Enabled", "true");
				}
				if (!this.mainForm.MainSettings.HasKey("FlashConnect.Port"))
				{
					this.mainForm.MainSettings.AddValue("FlashConnect.Port", "6969");
				}
				if (!this.mainForm.MainSettings.HasKey("FlashConnect.Debug"))
				{
					this.mainForm.MainSettings.AddValue("FlashConnect.Debug", "false");
				}
				/**
				* Retrieve settings
				*/
				this.cHost = this.mainForm.MainSettings.GetValue("FlashConnect.Host");
				this.cEnabled = this.mainForm.MainSettings.GetBool("FlashConnect.Enabled");
				this.cDebug = this.mainForm.MainSettings.GetBool("FlashConnect.Debug");
				this.cPort = this.mainForm.MainSettings.GetInt("FlashConnect.Port");
				/**
				* Set up xml socket
				*/
				if (this.cEnabled)
				{
					this.xmlSocket = new XmlSocket(this.cHost, this.cPort);
					this.xmlSocket.XmlReceived += new XmlReceivedEventHandler(this.HandleXml);
					this.xmlSocket.DataReceived += new DataReceivedEventHandler(this.HandleData);
				}
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while initializing FlashConnect plugin.", ex);
			}
		}
		
		/**
		* Disposes the plugin
		*/
		public void Dispose()
		{
			// Free system ressources
		}
		
		/**
		* Creates the Flash Player trust file for requested path
		*/
		public void HandleEvent(object sender, NotifyEvent e)
		{
			try 
			{
				if (e.Type == EventType.CustomData)
				{
					if (((DataEvent)e).Action != "CreateTrustFile") return;
					string[] chunks = ((DataEvent)e).Data.ToString().Split(';');
					/**
					* path to user trusted files
					*/
					string sep = Path.DirectorySeparatorChar.ToString();
					string target = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)+sep+"Macromedia"+sep+"Flash Player";
					if (!System.IO.Directory.Exists(target))
					{
						ErrorHandler.ShowInfo("The Flash Player does not seem to be installed on your system.");
					}
					target += sep+"#Security"+sep+"FlashPlayerTrust";
					if (!System.IO.Directory.Exists(target)) System.IO.Directory.CreateDirectory(target);
					/**
					* write the trust file
					*/
					target += sep+chunks[0];
					try
					{
						using (StreamWriter sw = new StreamWriter(target))
		            	{
							sw.Write(chunks[1]);
		            	}
						e.Handled = true;
					}
					catch (Exception ex)
					{
						ErrorHandler.ShowError("Error while writing the Flash trust file: "+target, ex);
					}
				}
			} 
			catch  (Exception ex2)
			{
				ErrorHandler.ShowError("Error while writing the Flash trust file.", ex2);
			}
		}
		
		#endregion
		
		#region SocketDataHandlingMethods
		
		/**
		* Handles the incoming data
		*/
		public void HandleData(object sender, DataReceivedEventArgs e)
		{
			this.cDebug = this.mainForm.MainSettings.GetBool("FlashConnect.Debug");
			if (this.cDebug)
			{
				string note = "FlashConnect recieved a packet:\r\n";
				this.mainForm.AddTraceLogEntry(note+e.Text, 1);
			}
		}
		
		/**
		* Handles the incoming xml message
		*/
		public void HandleXml(object sender, XmlReceivedEventArgs e)
		{
			try 
			{
				XmlDocument message = e.XmlDocument;
				XmlNode mainNode = message.FirstChild;
				for (int i = 0; i<mainNode.ChildNodes.Count; i++)
				{
					XmlNode cmdNode = mainNode.ChildNodes[i];
					if(XmlUtils.HasAttribute(cmdNode, "cmd"))
					{
						string cmd = XmlUtils.GetAttribute(cmdNode, "cmd");
						switch(cmd)
						{
							case "trace":
								this.HandleTraceMsg(cmdNode, e.Socket);
								break;
							case "notify":
								this.HandleNotifyMsg(cmdNode, e.Socket);
								break;
							case "getsetting":
								this.HandleGetSettingsMsg(cmdNode, e.Socket);
								break;
							case "return":
								this.HandleReturnMsg(cmdNode, e.Socket);
								break;
							default:
								ErrorHandler.ShowError("Received xml message was invalid.", null);
								break;
						}
					} 
					else 
					{
						ErrorHandler.ShowError("Received xml message was invalid.", null);
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while handling the xml data.", ex);
			}
		}
		
		/**
		* Handles the trace message
		*/
		public void HandleTraceMsg(XmlNode msgNode, Socket client)
		{
			try 
			{
				string message = HttpUtility.UrlDecode(XmlUtils.GetValue(msgNode));
				int state = Convert.ToInt32(XmlUtils.GetAttribute(msgNode, "state"));
				this.mainForm.AddTraceLogEntry(message, state);
			} 
			catch
			{
				client.Send(RESULT_INVALID);
			}
		}
		
		/**
		* Handles the distribute message
		*/
		public void HandleNotifyMsg(XmlNode msgNode, Socket client)
		{
			try 
			{
				string message = HttpUtility.UrlDecode(XmlUtils.GetValue(msgNode));
				string guid = XmlUtils.GetAttribute(msgNode, "guid");
				IPlugin plugin = this.mainForm.FindPlugin(guid);
				if (plugin != null)
				{
					plugin.HandleEvent(this, new DataEvent(EventType.CustomData, "FlashConnect", message));
				}
				else client.Send(RESULT_NOTFOUND);
			} 
			catch
			{
				client.Send(RESULT_INVALID);
			}
		}
		
		/**
		* Handles the get setting message
		*/
		public void HandleGetSettingsMsg(XmlNode msgNode, Socket client)
		{
			try 
			{
				string key = HttpUtility.UrlDecode(XmlUtils.GetValue(msgNode));
				if (this.mainForm.MainSettings.HasKey(key))
				{
					string val = this.mainForm.MainSettings.GetValue(key);
					XmlDocument xmlDoc = new XmlDocument();
					xmlDoc.LoadXml("<flashconnect><message cmd=\"getsetting\" key=\""+key+"\">"+HttpUtility.UrlEncode(val)+"</message></flashconnect>");
					byte[] data = Encoding.Default.GetBytes(xmlDoc.OuterXml+"\0");
					client.Send(data);
				}
			} 
			catch
			{
				client.Send(RESULT_INVALID);
			}
		}
		
		/**
		* Handles the return message
		*/
		public void HandleReturnMsg(XmlNode msgNode, Socket client)
		{
			try 
			{
				byte[] data = Encoding.Default.GetBytes(msgNode.InnerXml+"\0");
				client.Send(data);
			} 
			catch
			{
				client.Send(RESULT_INVALID);
			}
		}
		
		#endregion
	
	}
	
}
