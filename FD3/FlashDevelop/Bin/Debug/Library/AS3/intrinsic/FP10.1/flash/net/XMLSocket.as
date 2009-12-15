package flash.net
{
	import flash.events.EventDispatcher;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 * Dispatched when an input/output error occurs that causes a send or receive operation to fail.
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 

	/**
	 * Dispatched after a successful call to the XMLSocket.connect() method.
	 * @eventType flash.events.Event.CONNECT
	 */
	[Event(name="connect", type="flash.events.Event")] 

	/**
	 * Dispatched when the server closes the socket connection.
	 * @eventType flash.events.Event.CLOSE
	 */
	[Event(name="close", type="flash.events.Event")] 

	/// The XMLSocket class implements client sockets that let the Flash Player or AIR application communicate with a server computer identified by an IP address or domain name.
	public class XMLSocket extends EventDispatcher
	{
		/// Indicates whether this XMLSocket object is currently connected.
		public function get connected () : Boolean;

		/// Indicates the number of milliseconds to wait for a connection.
		public function get timeout () : int;
		public function set timeout (value:int) : void;

		/// Closes the connection specified by the XMLSocket object.
		public function close () : void;

		/// Establishes a connection to the specified Internet host using the specified TCP port.
		public function connect (host:String, port:int) : void;

		/// Converts the XML object or data specified in the object parameter to a string and transmits it to the server, followed by a zero (0) byte.
		public function send (object:*) : void;

		/// Creates a new XMLSocket object.
		public function XMLSocket (host:String = null, port:int = 0);
	}
}
