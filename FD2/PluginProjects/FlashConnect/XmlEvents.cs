using System;
using System.Net.Sockets;
using System.Xml;

namespace FlashConnect
{
	/**
	* Delegate for the xml received event
	*/
	public delegate void XmlReceivedEventHandler(object sender, XmlReceivedEventArgs e);
	public delegate void DataReceivedEventHandler(object sender, DataReceivedEventArgs e);
	
	/**
	* Holds data received event arguments
	*/
	public class DataReceivedEventArgs : EventArgs
	{   
		private string text;
		private Socket socket;

		public DataReceivedEventArgs(string text, Socket socket) 
		{
			this.text = text;
			this.socket = socket;
		}
		
		public string Text 
		{
			get { return this.text; }
		}
		
		public Socket Socket
		{
			get { return this.socket; }
		}
		
	}
	
	/**
	* Holds xml received event arguments
	*/
	public class XmlReceivedEventArgs : EventArgs
	{   
		private XmlDocument document;
		private Socket socket;

		public XmlReceivedEventArgs(string text, Socket socket) 
		{
			this.socket = socket;
			this.document = new XmlDocument();
			this.document.LoadXml(text);
		}
		
		public XmlDocument XmlDocument 
		{
			get { return this.document; }
		}
		
		public Socket Socket
		{
			get { return this.socket; }
		}
		
	}
	
}
