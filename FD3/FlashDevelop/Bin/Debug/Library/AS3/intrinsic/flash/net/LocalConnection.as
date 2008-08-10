/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class LocalConnection extends EventDispatcher {
		/**
		 * Indicates the object on which callback methods are invoked. The default object
		 *  is this, the local connection being created. You can set the
		 *  client property to another object, and callback methods are
		 *  invoked on that other object.
		 */
		public function get client():Object;
		public function set client(value:Object):void;
		/**
		 * A string representing the domain of the location of the current file.
		 */
		public function get domain():String;
		/**
		 * Creates a LocalConnection object. You can use LocalConnection objects to enable
		 *  communication between different files that are running on the same client computer.
		 */
		public function LocalConnection();
		/**
		 * Specifies one or more domains that can send LocalConnection calls to this LocalConnection instance.
		 */
		public function allowDomain(... domains):void;
		/**
		 * Specifies one or more domains that can send LocalConnection calls to this LocalConnection object.
		 */
		public function allowInsecureDomain(... domains):void;
		/**
		 * Closes (disconnects) a LocalConnection object. Issue this command when you no longer want the object
		 *  to accept commands - for example, when you want to issue a connect()
		 *  command using the same connectionName parameter in another SWF file.
		 */
		public function close():void;
		/**
		 * Prepares a LocalConnection object to receive commands from a send() command
		 *  (called the sending LocalConnection object). The object used with this command is
		 *  called the receiving LocalConnection object. The receiving and sending objects
		 *  must be running on the same client computer.
		 *
		 * @param connectionName    <String> A string that corresponds to the connection name specified in the
		 *                            send() command that wants to communicate with the receiving LocalConnection object.
		 */
		public function connect(connectionName:String):void;
		/**
		 * Invokes the method named methodName on a connection opened with the
		 *  connect(
		 *  connectionName
		 *  ) method (the receiving LocalConnection
		 *  object). The object used with this command is called the sending LocalConnection object.
		 *  The SWF files that contain the sending and receiving objects must be running on the same client computer.
		 *
		 * @param connectionName    <String> Corresponds to the connection name specified in the connect() command
		 *                            that wants to communicate with the sending LocalConnection object.
		 * @param methodName        <String> The name of the method to be invoked in the receiving LocalConnection object. The
		 *                            following method names cause the command to fail: send, connect,
		 *                            close, allowDomain, allowInsecureDomain,
		 *                            client, and domain.
		 */
		public function send(connectionName:String, methodName:String, ... arguments):void;
	}
}
