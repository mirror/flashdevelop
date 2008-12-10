package mx.rpc
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import mx.core.mx_internal;
	import mx.messaging.ChannelSet;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.events.AbstractEvent;
	import mx.utils.ObjectUtil;

	/**
	 * The invoke event is dispatched when a service Operation is invoked so long as * an Error is not thrown before the Channel attempts to send the message. * @eventType mx.rpc.events.InvokeEvent.INVOKE
	 */
	[Event(name="invoke", type="mx.rpc.events.InvokeEvent")] 
	/**
	 * The result event is dispatched when a service call successfully returns and * isn't handled by the Operation itself. * @eventType mx.rpc.events.ResultEvent.RESULT
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 * The fault event is dispatched when a service call fails and isn't handled by * the Operation itself. * @eventType mx.rpc.events.FaultEvent.FAULT
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 

	/**
	 * The AbstractService class is the base class for the WebService and * RemoteObject classes. This class does the work of creating Operations * which do the actual execution of remote procedure calls.
	 */
	flash_proxy dynamic class AbstractService extends Proxy implements IEventDispatcher
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 * @private
		 */
		local var _operations : Object;
		private var nextNameArray : Array;
		local var _availableChannelIds : Array;
		local var asyncRequest : AsyncRequest;
		private var eventDispatcher : EventDispatcher;

		/**
		 *  Provides access to the ChannelSet used by the service. The     *  ChannelSet can be manually constructed and assigned, or it will be      *  dynamically created to use the configured Channels for the     *  <code>destination</code> for this service.
		 */
		public function get channelSet () : ChannelSet;
		/**
		 *  @private
		 */
		public function set channelSet (value:ChannelSet) : void;
		/**
		 * The destination of the service. This value should match a destination     * entry in the services-config.xml file.
		 */
		public function get destination () : String;
		public function set destination (name:String) : void;
		/**
		 * @private     * This is required by data binding.
		 */
		public function get operations () : Object;
		/**
		 * The Operations array is usually only set by the MXML compiler if you     * create a service using an MXML tag.
		 */
		public function set operations (ops:Object) : void;
		/**
		 *  Provides access to the request timeout in seconds for sent messages.      *  A value less than or equal to zero prevents request timeout.
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;

		/**
		 *  Constructor.     *       *  @param destination The destination of the service.
		 */
		public function AbstractService (destination:String = null);
		/**
		 * @private
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * @private
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 * @private
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 * @private
		 */
		public function hasEventListener (type:String) : Boolean;
		/**
		 * @private
		 */
		public function willTrigger (type:String) : Boolean;
		/**
		 * @private
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 * @private
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
		/**
		 * @private
		 */
		flash_proxy function callProperty (name:*, ...args:Array) : *;
		/**
		 * @private
		 */
		flash_proxy function nextNameIndex (index:int) : int;
		/**
		 * @private
		 */
		flash_proxy function nextName (index:int) : String;
		/**
		 * @private
		 */
		flash_proxy function nextValue (index:int) : *;
		function getLocalName (name:Object) : String;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't     * created beforehand, subclasses are responsible for creating it during     * this call. Operations are usually accessible by simply naming them after     * the service variable (<code>myService.someOperation</code>), but if your     * Operation name happens to match a defined method on the service (like     * <code>setCredentials</code>), you can use this method to get the     * Operation instead.     * @param name Name of the Operation.     * @return Operation that executes for this name.
		 */
		public function getOperation (name:String) : AbstractOperation;
		/**
		 *  Disconnects the service's network connection and removes any pending     *  request responders.     *  This method does not wait for outstanding network operations to complete.
		 */
		public function disconnect () : void;
		/**
		 * Sets the credentials for the destination accessed by the service when using Data Services on the server side.     * The credentials are applied to all services connected over the same     * ChannelSet. Note that services that use a proxy or a third-party adapter     * to a remote endpoint will need to setRemoteCredentials instead.     *      * @param username The username for the destination.     * @param password The password for the destination.     * @param charset The character set encoding to use while encoding the     * credentials. The default is null, which implies the legacy charset of     * ISO-Latin-1. The only other supported charset is &quot;UTF-8&quot;.
		 */
		public function setCredentials (username:String, password:String, charset:String = null) : void;
		/**
		 * Logs the user out of the destination.      * Logging out of a destination applies to everything connected using the     * same ChannelSet as specified in the server configuration. For example,     * if you're connected over the my-rtmp channel and you log out using one     * of your RPC components, anything that was connected over the same     * ChannelSet is logged out.
		 */
		public function logout () : void;
		/**
		 * The username and password to be used to authenticate a user when     * accessing a remote, third-party endpoint such as a web service through a     * proxy or a remote object through a custom adapter when using Data Services on the server side.     *     * @param remoteUsername the username to pass to the remote endpoint     * @param remotePassword the password to pass to the remote endpoint     * @param charset The character set encoding to use while encoding the     * remote credentials. The default is null, which implies the legacy charset     * of ISO-Latin-1. The only other supported charset is &quot;UTF-8&quot;.
		 */
		public function setRemoteCredentials (remoteUsername:String, remotePassword:String, charset:String = null) : void;
		/**
		 * Returns this service.     *      * @private
		 */
		public function valueOf () : Object;
		/**
		 * @private
		 */
		function hasTokenResponders (event:Event) : Boolean;
	}
}
