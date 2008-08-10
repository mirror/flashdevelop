/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class XMLSocket extends EventDispatcher {
		/**
		 * Indicates whether this XMLSocket object is currently connected. You can also check
		 *  whether the connection succeeded by registering for the connect
		 *  event and ioError event.
		 */
		public function get connected():Boolean;
		/**
		 * Creates a new XMLSocket object. The XMLSocket object is not initially connected to any server. You must call the
		 *  XMLSocket.connect() method to connect the object to a server.
		 *
		 * @param host              <String (default = null)> A fully qualified DNS domain name or an IP address in the form
		 *                            aaa.bbb.ccc.ddd. You can also
		 *                            specify null to connect to the host server
		 *                            on which the SWF file resides. If the calling file is a SWF file running in a web browser,
		 *                            host must be in the same domain as the calling file.
		 * @param port              <int (default = 0)> The TCP port number on the host used to establish a connection. The port
		 *                            number must be 1024 or greater, unless a policy file is being used.
		 */
		public function XMLSocket(host:String = null, port:int = 0);
		/**
		 * Closes the connection specified by the XMLSocket object.
		 *  The close event is dispatched only when the server
		 *  closes the connection; it is not dispatched when you call the close() method.
		 */
		public function close():void;
		/**
		 * Establishes a connection to the specified Internet host using the specified TCP port. By default
		 *  you can only connect to port 1024 or higher, unless you are using a policy file.
		 *
		 * @param host              <String> A fully qualified DNS domain name or an IP address in the form
		 *                            aaa.bbb.ccc.ddd. You can also
		 *                            specify null to connect to the host server
		 *                            on which the SWF file resides. If the calling file is a SWF file is running in a web browser,
		 *                            host must be in the same domain as the file.
		 * @param port              <int> The TCP port number on the host used to establish a connection. The port
		 *                            number must be 1024 or greater, unless a policy file is being used.
		 */
		public function connect(host:String, port:int):void;
		/**
		 * Converts the XML object or data specified in the object parameter
		 *  to a string and transmits it to the server, followed by a zero (0) byte. If object
		 *  is an XML object, the string is the XML textual representation of the XML object. The
		 *  send operation is asynchronous; it returns immediately, but the data may be transmitted at a
		 *  later time. The XMLSocket.send() method does not return a value indicating whether
		 *  the data was successfully transmitted.
		 *
		 * @param object            <*> An XML object or other data to transmit to the server.
		 */
		public function send(object:*):void;
	}
}
