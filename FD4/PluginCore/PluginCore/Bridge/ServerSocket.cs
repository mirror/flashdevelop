using System;
using System.IO;
using System.Text;
using System.Net;
using System.Net.Sockets;

namespace PluginCore.Bridge
{
	public class ServerSocket
	{
		static protected readonly byte[] EOL = new byte[] { 13 };
		
		protected IPAddress ipAddress;
		protected int portNum;
        protected Socket conn;
        
        public event DataReceivedEventHandler DataReceived;
		
        public ServerSocket(String address, Int32 port)
        {
            if (address == null || address == "invalid") return;
        	ipAddress = IPAddress.Parse(address);
        	portNum = port;
        }
		
		public IPAddress IP {
			get { return ipAddress; }
		}
		
		public int PortNum {
			get { return portNum; }
		}
		
		
		#region SERVER
		
		public bool StartServer()
		{
			try
			{
				conn = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
				conn.Bind(new IPEndPoint(ipAddress, portNum));
				conn.Listen(10);
				conn.BeginAccept(new AsyncCallback(this.OnConnectRequest), conn);
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				return false;
			}
			return true;
		}
		
		/// <summary>
		/// Accepts the connection request and sets a listener for the next one
		/// </summary>
		protected void OnConnectRequest(IAsyncResult result)
		{
		    try
			{
				Socket server = (Socket)result.AsyncState;
		    	Socket client = server.EndAccept(result);
		    	this.SetupReceiveCallback(client);
		    	server.BeginAccept(new AsyncCallback(this.OnConnectRequest), server);
		    }
		    catch (Exception ex)
			{
                Console.WriteLine(ex.Message);
			}
		}
		
		#endregion
		
		
		#region CLIENT
		
        public bool ConnectClient()
		{
			try
			{
				conn = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.IP);
				conn.Connect(new IPEndPoint(ipAddress, portNum));
				SetupReceiveCallback(conn);
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				return false;
			}
			return true;
		}
		
		public int Send(string message)
		{
			return SendTo(conn, message);
		}

        public void Disconnect()
        {
            if (conn != null)
            {
                conn.Disconnect(false);
                conn = null;
            }
        }
		
		#endregion
		
		
		#region DATA
		
		static public int SendTo(Socket socket, string message)
		{
			int len = socket.Send(Encoding.UTF8.GetBytes(message));
			return len + socket.Send(EOL);
		}
		
		/// <summary>
		/// Sets up the receive callback for the accepted connection
		/// </summary>
		protected void SetupReceiveCallback(Socket client)
		{
		    StateObject so = new StateObject(client);
		    try
		    {
		    	AsyncCallback receiveData = new AsyncCallback(this.OnReceivedData);
		        so.Client.BeginReceive(so.Buffer, 0, so.Size, SocketFlags.None, receiveData, so);
		    }
		    catch (SocketException)
		    {
		    	so.Client.Shutdown(SocketShutdown.Both);
		        so.Client.Close();
		    }
		    catch (Exception ex)
		    {
                Console.WriteLine(ex.Message);
		    }
		}
		
		/// <summary>
		/// Handles the received data and fires DataReceived event
		/// </summary>
		protected void OnReceivedData(IAsyncResult result)
		{
			StateObject so = (StateObject)result.AsyncState;
			try
		    {
				Int32 bytesReceived = so.Client.EndReceive(result);
				if (bytesReceived > 0)
		        {
					String chunk = Encoding.UTF8.GetString(so.Buffer, 0, bytesReceived);

                    int star = chunk.IndexOf('*');
                    if (star >= 0)// .EndsWith("\0"))
                    {
						so.Data.Append(chunk.Substring(0, star));
                   		if (this.DataReceived != null) 
							this.DataReceived(this, new DataReceivedEventArgs(so.Data.ToString(), so.Client));
						so.Data = new StringBuilder();
                        so.Data.Append(chunk.Substring(star + 1));
                    }
					else so.Data.Append(chunk);
					
					so.Client.BeginReceive(so.Buffer, 0, so.Size, SocketFlags.None, 
					                       new AsyncCallback(this.OnReceivedData), so);
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
                Console.WriteLine(ex.Message);
		    }
		}
		
		#endregion
		
	}
	
	
	#region STRUCTS
	
	public delegate void DataReceivedEventHandler(Object sender, DataReceivedEventArgs e);
	
	public class DataReceivedEventArgs : EventArgs
	{
        private String text;
		private Socket socket;

		public DataReceivedEventArgs(String text, Socket socket) 
		{
			this.text = text;
			this.socket = socket;
		}

        public String Text 
		{
			get { return this.text; }
		}

		public Socket Socket
		{
			get { return this.socket; }
		}
		
	}
	
	
	public class StateObject
	{
        public Int32 Size; 
        public Socket Client;
		public StringBuilder Data;
        public Byte[] Buffer;
        
		public StateObject(Socket client)
		{
			this.Size = 1024;
			this.Data = new StringBuilder();
            this.Buffer = new Byte[this.Size];
			this.Client = client;
		}
		
	}
	
	#endregion
	
}
