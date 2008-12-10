package mx.rpc.remoting
{
	import mx.core.mx_internal;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;

	/**
	 * The RemoteObject class gives you access to classes on a remote application server.
	 */
	public dynamic class RemoteObject extends AbstractService
	{
		/**
		 *  @private
		 */
		private var _source : String;
		/**
		 *  @private
		 */
		private var _makeObjectsBindable : Boolean;

		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (b:Boolean) : void;
		/**
		 * Lets you specify a source value on the client; not supported for destinations that use the JavaAdapter. This allows you to provide more than one source     * that can be accessed from a single destination on the server.      *
		 */
		public function get source () : String;
		public function set source (s:String) : void;

		/**
		 * Creates a new RemoteObject.     * @param destination [optional] Destination of the RemoteObject; should match a destination name in the services-config.xml file.
		 */
		public function RemoteObject (destination:String = null);
		/**
		 * Returns an Operation of the given name. If the Operation wasn't     * created beforehand, a new <code>mx.rpc.remoting.Operation</code> is     * created during this call. Operations are usually accessible by simply     * naming them after the service variable     * (<code>myService.someOperation</code>), but if your Operation name     * happens to match a defined method on the service     * (like <code>setCredentials</code>), you can use this method to get the     * Operation instead.     * @param name Name of the Operation.     * @return Operation that executes for this name.
		 */
		public function getOperation (name:String) : AbstractOperation;
		/**
		 * If a remote object is managed by an external service, such a ColdFusion Component (CFC),     * a username and password can be set for the authentication mechanism of that remote service.     *     * @param remoteUsername the username to pass to the remote endpoint     * @param remotePassword the password to pass to the remote endpoint     * @param charset The character set encoding to use while encoding the     * remote credentials. The default is null, which implies the legacy charset     * of ISO-Latin-1. The only other supported charset is &quot;UTF-8&quot;.
		 */
		public function setRemoteCredentials (remoteUsername:String, remotePassword:String, charset:String = null) : void;
		/**
		 * Represents an instance of RemoteObject as a String, describing     * important properties such as the destination id and the set of     * channels assigned.     *     * @return Returns a String representing an instance of a RemoteObject.
		 */
		public function toString () : String;
	}
}
