/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class NetConnection extends EventDispatcher {
		/**
		 * Indicates the object on which callback methods should be invoked. The default is
		 *  this NetConnection instance. If you set the client property to another object,
		 *  callback methods will be invoked on that object.
		 */
		public function get client():Object;
		public function set client(value:Object):void;
		/**
		 * Indicates whether the application is connected to a server through
		 *  a persistent RTMP connection (true) or not (false).
		 *  When connected through HTTP, this property is false, except
		 *  when connected to Flash Remoting services on an application server,
		 *  in which case it is true.
		 */
		public function get connected():Boolean;
		/**
		 * If a successful connection is made, indicates the method that was used to make it:
		 *  a direct connection, the CONNECT method, or HTTP tunneling.
		 *  Possible values are "none",
		 *  "HTTP", "HTTPS", and "CONNECT".
		 *  This property is valid only when a NetConnection object is connected.
		 *  This property is used in Flex applications and Flash Media Server applications.
		 *  This property is applicable only when
		 *  RTMP, RTMPS, or RTMPT is used. The CONNECT method is applicable only to
		 *  users who are connected to the network by a proxy server.
		 */
		public function get connectedProxyType():String;
		/**
		 * The default object encoding for NetConnection objects.
		 *  When an object is written to or read from binary data, the defaultObjectEncoding
		 *  property indicates which Action Message Format (AMF) version is used to serialize the data:
		 *  the ActionScript 3.0 format (ObjectEncoding.AMF3)
		 *  or the ActionScript 1.0 and ActionScript 2.0 format (ObjectEncoding.AMF0).
		 */
		public static function get defaultObjectEncoding():uint;
		public function set defaultObjectEncoding(value:uint):void;
		/**
		 * The object encoding for this NetConnection instance.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * Determines which fallback methods are tried if an
		 *  initial connection attempt to the server fails. You must set the proxyType property before
		 *  calling the NetConnection.connect() method.
		 */
		public function get proxyType():String;
		public function set proxyType(value:String):void;
		/**
		 * The URI passed to the NetConnection.connect() method.
		 *  If NetConnection.connect() hasn't been called or if no URI was passed,
		 *  this property is undefined.
		 */
		public function get uri():String;
		/**
		 * Indicates whether a secure connection was made using native Transport Layer Security (TLS)
		 *  rather than HTTPS. This property is valid only when a NetConnection object is connected.
		 */
		public function get usingTLS():Boolean;
		/**
		 * Creates a NetConnection object. Call connect() to make a connection.
		 */
		public function NetConnection();
		/**
		 * Adds a context header to the Action Message Format (AMF) packet structure. This header is sent with
		 *  every future AMF packet. If you call NetConnection.addHeader()
		 *  using the same name, the new header replaces the existing header, and the new header
		 *  persists for the duration of the NetConnection object. You can remove a header by
		 *  calling NetConnection.addHeader() with the name of the header to remove
		 *  an undefined object.
		 *
		 * @param operation         <String> Identifies the header and the ActionScript object data associated with it.
		 * @param mustUnderstand    <Boolean (default = false)> A value of true indicates that the server must understand
		 *                            and process this header before it handles any of the following headers or messages.
		 * @param param             <Object (default = null)> Any ActionScript object.
		 */
		public function addHeader(operation:String, mustUnderstand:Boolean = false, param:Object = null):void;
		/**
		 * Invokes a command or method on Flash Media Server or on an application server running Flash Remoting.
		 *  Before calling NetConnection.call() you must call NetConnection.connect() to connect to the server.
		 *  You must create a server-side function to pass to this method.
		 *
		 * @param command           <String> A method specified in the form [objectPath/]method. For example,
		 *                            the someObject/doSomething command tells the remote server
		 *                            to invoke the clientObject.someObject.doSomething() method, with all the optional
		 *                            ... arguments parameters. If the object path is missing,
		 *                            clientObject.doSomething() is invoked on the remote server.
		 *                            With Flash Media Server, command is the name of a function
		 *                            defined in an application's server-side script.
		 *                            You do not need to use an object path before command
		 *                            if the server-side script is placed at the root level of
		 *                            the application directory.
		 * @param responder         <Responder> An optional object that is used to handle return values from the server.
		 *                            The Responder object can have two defined methods to handle the returned result:
		 *                            result and status. If an error is returned as the result,
		 *                            status is invoked; otherwise, result is invoked. The Responder object
		 *                            can process errors related to specific operations, while the NetConnection object responds to
		 *                            errors related to the connection status.
		 */
		public function call(command:String, responder:Responder, ... arguments):void;
		/**
		 * Closes the connection that was opened locally or to the server and dispatches
		 *  a netStatus event
		 *  with a code property of NetConnection.Connect.Closed.
		 */
		public function close():void;
		/**
		 * Creates a bidirectional connection between a Flash Player
		 *  or AIR  application and a Flash Media Server application.
		 *  A NetConnection object is like a pipe between the client and the server. Use NetStream objects to send streams through the pipe.
		 *  For information about codecs and file formats supported by Flash Media Server, see
		 *  the Flash Media Server documentation.
		 *
		 * @param command           <String> Set this parameter to null if you are connecting to a
		 *                            video file on the local computer.
		 *                            If you are connecting to a server, set this parameter to the URI of the
		 *                            application that contains the video file on the server. Use the following
		 *                            syntax (items in brackets are optional):
		 *                            protocol:[//host][:port]/appname[/instanceName]
		 *                            To connect to Flash Media Server, use rtmp,
		 *                            rtmpe, rtmps, rtmpt, or rtmpte
		 *                            as the protocol. If the connection is successful, a
		 *                            netStatus event with a code property of
		 *                            NetConnection.Connect.Success is returned.
		 *                            See the NetStatusEvent.info property for a list of
		 *                            all event codes returned in response to calling connect().
		 *                            If the file is served from the same host where the server is installed,
		 *                            you can omit the host parameter. If you omit the instanceName parameter,
		 *                            Flash Player or AIR connects to the application's default instance.
		 */
		public function connect(command:String, ... arguments):void;
	}
}
