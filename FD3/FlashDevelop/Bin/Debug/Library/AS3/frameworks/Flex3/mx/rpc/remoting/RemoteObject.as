/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.remoting {
	import mx.rpc.AbstractService;
	public dynamic  class RemoteObject extends AbstractService {
		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable():Boolean;
		public function set makeObjectsBindable(value:Boolean):void;
		/**
		 * Lets you specify a source value on the client; not supported for destinations that use the JavaAdapter. This allows you to provide more than one source
		 *  that can be accessed from a single destination on the server.
		 */
		public function get source():String;
		public function set source(value:String):void;
		/**
		 * Creates a new RemoteObject.
		 *
		 * @param destination       <String (default = null)> [optional] Destination of the RemoteObject; should match a destination name in the services-config.xml file.
		 */
		public function RemoteObject(destination:String = null);
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 *  created beforehand, a new mx.rpc.remoting.Operation is
		 *  created during this call. Operations are usually accessible by simply
		 *  naming them after the service variable
		 *  (myService.someOperation), but if your Operation name
		 *  happens to match a defined method on the service
		 *  (like setCredentials), you can use this method to get the
		 *  Operation instead.
		 *
		 * @param name              <String> Name of the Operation.
		 * @return                  <AbstractOperation> Operation that executes for this name.
		 */
		public override function getOperation(name:String):AbstractOperation;
		/**
		 * If a remote object is managed by an external service, such a ColdFusion Component (CFC),
		 *  a username and password can be set for the authentication mechanism of that remote service.
		 *
		 * @param remoteUsername    <String> the username to pass to the remote endpoint
		 * @param remotePassword    <String> the password to pass to the remote endpoint
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            remote credentials. The default is null, which implies the legacy charset
		 *                            of ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public override function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null):void;
		/**
		 * Represents an instance of RemoteObject as a String, describing
		 *  important properties such as the destination id and the set of
		 *  channels assigned.
		 */
		public function toString():String;
	}
}
