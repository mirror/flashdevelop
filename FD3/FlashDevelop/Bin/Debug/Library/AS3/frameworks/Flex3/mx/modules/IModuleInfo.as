package mx.modules
{
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import mx.core.IFlexModuleFactory;

	/**
	 *  Dispatched by the backing ModuleInfo if there was an error during *  module loading. * *  @eventType mx.events.ModuleEvent.ERROR
	 */
	[Event(name="error", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo at regular intervals  *  while the module is being loaded. * *  @eventType mx.events.ModuleEvent.PROGRESS
	 */
	[Event(name="progress", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo once the module is sufficiently *  loaded to call the <code>IModuleInfo.factory()</code> method and the *  <code>IFlexModuleFactory.create()</code> method. * *  @eventType mx.events.ModuleEvent.READY
	 */
	[Event(name="ready", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo once the module is sufficiently *  loaded to call the <code>IModuleInfo.factory()</code> method and  *  the <code>IFlexModuleFactory.info()</code> method. * *  @eventType mx.events.ModuleEvent.SETUP
	 */
	[Event(name="setup", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo when the module data is unloaded. * *  @eventType mx.events.ModuleEvent.UNLOAD
	 */
	[Event(name="unload", type="mx.events.ModuleEvent")] 

	/**
	 *  An interface that acts as a handle for a particular module. *  From this interface, the module status can be queried, *  its inner factory can be obtained, and it can be loaded or unloaded.
	 */
	public interface IModuleInfo extends IEventDispatcher
	{
		/**
		 *  User data that can be associated with the singleton IModuleInfo     *  for a given URL.
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  A flag that is <code>true</code> if there was an error     *  during module loading.     *       *  <p>This flag is <code>true</code> when the ModuleManager dispatches the     *  <code>ModuleEvent.ERROR</code> event.</p>
		 */
		public function get error () : Boolean;
		/**
		 *  The IFlexModuleFactory implementation defined in the module.     *  This will only be non-<code>null</code> after the     *  <code>ModuleEvent.SETUP</code> event has been dispatched     *  (or the <code>IModuleInfo.setup()</code> method returns <code>true</code>).     *  At this point, the <code>IFlexModuleFactory.info()</code> method can be called.     *  Once a <code>ModuleEvent.READY</code> event is dispatched     *  (or the <code>IModuleInfo.ready()</code> method returns <code>true</code>),     *  it is possible to call the <code>IFlexModuleFactory.create()</code> method.
		 */
		public function get factory () : IFlexModuleFactory;
		/**
		 *  A flag that is <code>true</code> if the <code>load()</code>     *  method has been called on this module.
		 */
		public function get loaded () : Boolean;
		/**
		 *  A flag that is <code>true</code> if the module is sufficiently loaded     *  to get a handle to its associated IFlexModuleFactory implementation     *  and call its <code>create()</code> method.     *       *  <p>This flag is <code>true</code> when the ModuleManager dispatches the     *  <code>ModuleEvent.READY</code> event.</p>
		 */
		public function get ready () : Boolean;
		/**
		 *  A flag that is <code>true</code> if the module is sufficiently loaded     *  to get a handle to its associated IFlexModuleFactory implementation     *  and call its <code>info()</code> method.     *       *  <p>This flag is <code>true</code> when the ModuleManager dispatches the     *  <code>ModuleEvent.SETUP</code> event.</p>
		 */
		public function get setup () : Boolean;
		/**
		 *  The URL associated with this module (for example, "MyImageModule.swf" or      *  "http://somedomain.com/modules/MyImageModule.swf". The URL can be local or remote, but      *  if it is remote, you must establish a trust between the module's domain and the      *  application that loads it.
		 */
		public function get url () : String;

		/**
		 *  Requests that the module be loaded. If the module is already loaded,     *  the call does nothing. Otherwise, the module begins loading and dispatches      *  <code>progress</code> events as loading proceeds.     *       *  @param applicationDomain The current application domain in which your code is executing.     *       *  @param securityDomain The current security "sandbox".     *      *  @param bytes A ByteArray object. The ByteArray is expected to contain      *  the bytes of a SWF file that represents a compiled Module. The ByteArray     *  object can be obtained by using the URLLoader class. If this parameter     *  is specified the module will be loaded from the ByteArray. If this      *  parameter is null the module will be loaded from the url specified in     *  the url property.
		 */
		public function load (applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null, bytes:ByteArray = null) : void;
		/**
		 *  Releases the current reference to the module.     *  This does not unload the module unless there are no other     *  open references to it and the ModuleManager is set up     *  to have only a limited number of loaded modules.     *       *  @see mx.modules.ModuleManager
		 */
		public function release () : void;
		/**
		 *  Unloads the module.     *  Flash Player and AIR will not fully unload and garbage collect this module if     *  there are any outstanding references to definitions inside the     *  module.
		 */
		public function unload () : void;
		/**
		 *  Publishes an interface to the ModuleManager. This allows late (or decoupled)     *  subscriptions to factories with a String handle. Use a URL that starts with     *  <code>publish://</code> to reference factories that are published in this manner.     *       *  @param factory The class that implements the module's IFlexModuleFactory interface.     *       *  @see mx.modules.ModuleManager
		 */
		public function publish (factory:IFlexModuleFactory) : void;
	}
}
