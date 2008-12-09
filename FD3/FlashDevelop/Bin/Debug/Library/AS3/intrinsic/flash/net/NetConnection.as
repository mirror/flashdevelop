package flash.net
{
	/// The NetConnection class creates a bidirectional connection between Flash Player and a Flash Media Server application or between Flash Player and an application server running Flash Remoting.
	public class NetConnection extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a NetConnection object is reporting its status or error condition.
		 * @eventType flash.events.NetStatusEvent.NET_STATUS
		 */
		[Event(name="netStatus", type="flash.events.NetStatusEvent")]

		/** 
		 * Dispatched if a call to NetConnection.call() attempts to connect to a server outside the caller's security sandbox.
		 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
		 */
		[Event(name="securityError", type="flash.events.SecurityErrorEvent")]

		/** 
		 * Dispatched when an input or output error occurs that causes a network operation to fail.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * Dispatched when an exception is thrown asynchronously -- that is, from native asynchronous code.
		 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
		 */
		[Event(name="asyncError", type="flash.events.AsyncErrorEvent")]

		/// Indicates whether Flash Player is connected to a server through a persistent RTMP connection (true) or not (false).
		public var connected:Boolean;

		/// The URI passed to the NetConnection.connect() method.
		public var uri:String;

		/// Indicates the object on which callback methods should be invoked.
		public var client:Object;

		/// The default object encoding for NetConnection objects created in the SWF file.
		public var defaultObjectEncoding:uint;

		/// The object encoding for this NetConnection instance.
		public var objectEncoding:uint;

		/// Determines which fallback methods are tried if an initial connection attempt to the server fails.
		public var proxyType:String;

		/// The proxy type used to make a successful NetConnection.connect() call to Flash Media Server: "none", "HTTP", "HTTPS", or "CONNECT".
		public var connectedProxyType:String;

		/// Indicates whether a secure connection was made using native Transport Layer Security (TLS) rather than HTTPS.
		public var usingTLS:Boolean;

		/// The protocol used to establish the connection.
		public var protocol:String;

		/// The total number of inbound and outbound peer connections that this instance of Flash Player or Adobe AIR allows.
		public var maxPeerConnections:uint;

		/// The identifier of this Flash Player or Adobe AIR instance for this NetConnection instance.
		public var nearID:String;

		/// The identifier of the Flash Media Server instance to which this Flash Player or Adobe AIR instance is connected.
		public var farID:String;

		/// A value chosen substantially by this Flash Player or Adobe AIR instance, unique to this connection.
		public var nearNonce:String;

		/// A value chosen substantially by Flash Media Server, unique to this connection.
		public var farNonce:String;

		/// An object that holds all of the peer subscriber NetStream objects that are not associated with publishing NetStream objects.
		public var unconnectedPeerStreams:Array;

		/// Creates a NetConnection object.
		public function NetConnection();

		/// Closes the connection that was opened locally or to the server and dispatches a netStatus event with a code property of NetConnection.Connect.Closed.
		public function close():void;

		/// Adds a context header to the Action Message Format (AMF) packet structure.
		public function addHeader(operation:String, mustUnderstand:Boolean=false, param:Object=null):void;

		/// Invokes a command or method on Flash Media Server or on an application server running Flash Remoting.
		public function call(command:String, responder:flash.net.Responder, ...arguments):void;

		/// Creates a bidirectional connection between Flash Player and a Flash Media Server application.
		public function connect(command:String, ...arguments):void;

	}

}

