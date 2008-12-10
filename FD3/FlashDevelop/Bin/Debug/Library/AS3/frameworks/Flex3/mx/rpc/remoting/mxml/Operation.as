package mx.rpc.remoting.mxml
{
	import mx.core.mx_internal;
	import mx.managers.CursorManager;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.AsyncDispatcher;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.mxml.Concurrency;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.mxml.RemoteObject;
	import mx.validators.Validator;

	/**
	 * The Operation used for RemoteObject when created in an MXML document.
	 */
	public class Operation extends mx.rpc.remoting.Operation implements IMXMLSupport
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _concurrency : String;
		private var _concurrencySet : Boolean;
		private var remoteObject : mx.rpc.remoting.mxml.RemoteObject;
		private var _showBusyCursor : Boolean;
		private var _showBusyCursorSet : Boolean;

		/**
		 * The concurrency for this Operation.  If it has not been explicitly set the setting from the RemoteObject     * will be used.
		 */
		public function get concurrency () : String;
		/**
		 *  @private
		 */
		public function set concurrency (c:String) : void;
		/**
		 * Whether this operation should show the busy cursor while it is executing.     * If it has not been explicitly set the setting from the RemoteObject     * will be used.
		 */
		public function get showBusyCursor () : Boolean;
		public function set showBusyCursor (sbc:Boolean) : void;

		/**
		 * @private
		 */
		public function Operation (remoteObject:mx.rpc.remoting.RemoteObject = null, name:String = null);
		function setService (ro:AbstractService) : void;
		/**
		 * @inheritDoc
		 */
		public function cancel (id:String = null) : AsyncToken;
		/**
		 * @inheritDoc
		 */
		public function send (...args:Array) : AsyncToken;
		/**
		 * @private     * Return the id for the NetworkMonitor
		 */
		function getNetmonId () : String;
		function invoke (message:IMessage, token:AsyncToken = null) : AsyncToken;
		/**
		 * Kill the busy cursor, find the matching call object and pass it back
		 */
		function preHandle (event:MessageEvent) : AsyncToken;
	}
}
