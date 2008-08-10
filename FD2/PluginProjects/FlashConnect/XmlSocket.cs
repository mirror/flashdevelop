using System;
using System.IO;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Xml;
using PluginCore;

namespace FlashConnect
{
	public class XmlSocket
	{
		private Socket server;
		private Socket client;
		public event XmlReceivedEventHandler XmlReceived;
		public event DataReceivedEventHandler DataReceived;
		private StringBuilder packets;
		
		public XmlSocket(string address, int port)
		{
			try
			{
				IPAddress ipAddress = IPAddress.Parse(address);
				this.server = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
				this.server.Bind(new IPEndPoint(ipAddress, port));
				this.server.Listen(10);
				this.server.BeginAccept(new AsyncCallback(this.OnConnectRequest), this.server);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while opening the server.", ex);
			}
		}
		
		/*
		* Accepts the connection request and sets a listener for the next one
		*/
		public void OnConnectRequest(IAsyncResult result)
		{
		    try
			{
				Socket server = (Socket)result.AsyncState;
		    	this.client = server.EndAccept(result);
		    	this.SetupReceiveCallback(client);
		    	server.BeginAccept(new AsyncCallback(this.OnConnectRequest), server);
		    }
		    catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while accepting connection.", ex);
			}
		}
		
		/*
		* Sets up the receive callback for the accepted connection
		*/
		public void SetupReceiveCallback(Socket client)
		{
		    StateObject so = new StateObject(client);
		    try
		    {
		    	AsyncCallback receiveData = new AsyncCallback(this.OnReceivedData);
		        client.BeginReceive(so.Buffer, 0, so.Size, SocketFlags.None, receiveData, so);
		    }
		    catch (SocketException)
		    {
		    	so.Client.Shutdown(SocketShutdown.Both);
		        so.Client.Close();
		    }
		    catch (Exception ex)
		    {
		    	ErrorHandler.ShowError("Error while setting up receive handler.", ex);
		    }
		}
		
		/*
		* Handles the received data and fires XmlReceived event
		*/
		public void OnReceivedData(IAsyncResult result)
		{
		    StateObject so = (StateObject)result.AsyncState;
		    try
		    {
		        int bytesReceived = so.Client.EndReceive(result);
		        if (bytesReceived > 0)
		        {
                    so.Data.Append(Encoding.ASCII.GetString(so.Buffer, 0, bytesReceived));
                    string contents = so.Data.ToString();
                    //
                    this.DataReceived(this, new DataReceivedEventArgs(contents, so.Client));
                    if (packets != null) packets.Append(contents);
                    else if (contents.StartsWith("<")) packets = new StringBuilder(contents);
                    else ErrorHandler.ShowInfo("Incorrect XML message: "+contents);
                    //
                    if (packets != null && contents.EndsWith("\0"))
                    {
                    	string msg = packets.ToString();
                    	packets = null;
                    	// policy file asked
                    	if (msg == "<policy-file-request/>\0") {
                    		string policy = "<cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"*\" /></cross-domain-policy>\0";
                    		so.Client.Send(Encoding.Default.GetBytes(policy));
                    	}
                    	// valid message
                    	else if (msg.EndsWith("</flashconnect>\0")) this.XmlReceived(this, new XmlReceivedEventArgs(msg, so.Client));
                    	// error
						else ErrorHandler.ShowInfo("Incorrect XML message: "+msg);
                    }
		            this.SetupReceiveCallback(so.Client);
		        }
		        else
		        {
		            so.Client.Shutdown(SocketShutdown.Both);
		            so.Client.Close();
		        }
		    }
		    catch (SocketException)
		    {
		    	so.Client.Shutdown(SocketShutdown.Both);
		        so.Client.Close();
		    }
		    catch (Exception ex)
		    {
		        ErrorHandler.ShowError("Error while recieving data from flash movie.", ex);
		    }
		}
		
	}
	
}
