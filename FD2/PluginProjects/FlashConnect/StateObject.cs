using System;
using System.Net.Sockets;
using System.Text;

namespace FlashConnect
{
	public class StateObject
	{
		public Socket Client;
		public byte[] Buffer;
		public StringBuilder Data;
		public int Size;
			
		public StateObject(Socket client)
		{
			this.Size = 2048;
			this.Data = new StringBuilder();
			this.Buffer = new byte[this.Size];
			this.Client = client;
		}
		
	}
	
}
