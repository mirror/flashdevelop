package mx.rpc.remoting
{
	import mx.core.mx_internal;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.utils.ObjectUtil;

	/**
	 * An Operation used specifically by RemoteObjects. An Operation is an individual method on a service. * An Operation can be called either by invoking the * function of the same name on the service or by accessing the Operation as a property on the service and * calling the <code>send()</code> method.
	 */
	public class Operation extends AbstractOperation
	{
		/**
		 * An ordered list of the names of the arguments to pass to a method invocation.  Since the arguments object is     * a hashmap with no guaranteed ordering, this array helps put everything together correctly.     * It will be set automatically by the MXML compiler, if necessary, when the Operation is used in tag form.
		 */
		public var argumentNames : Array;
		private var _makeObjectsBindableSet : Boolean;

		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (b:Boolean) : void;

		/**
		 * Creates a new Operation. This is usually done directly automatically by the RemoteObject     * when an unknown operation has been accessed. It is not recommended that a developer use this constructor     * directly.
		 */
		public function Operation (remoteObject:AbstractService = null, name:String = null);
		/**
		 * @inheritDoc
		 */
		public function send (...args:Array) : AsyncToken;
	}
}
