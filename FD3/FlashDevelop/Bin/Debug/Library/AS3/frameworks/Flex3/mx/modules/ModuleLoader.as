package mx.modules
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import mx.containers.VBox;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.events.FlexEvent;
	import mx.events.ModuleEvent;

	/**
	 *  Dispatched when the ModuleLoader starts to load a URL.
 *
 *  @eventType mx.events.FlexEvent.LOADING
	 */
	[Event(name="loading", type="flash.events.Event")] 

	/**
	 *  Dispatched when the ModuleLoader is given a new URL.
 *
 *  @eventType mx.events.FlexEvent.URL_CHANGED
	 */
	[Event(name="urlChanged", type="flash.events.Event")] 

	/**
	 *  Dispatched when information about the module is 
 *  available (with the <code>info()</code> method), 
 *  but the module is not yet ready.
 *
 *  @eventType mx.events.ModuleEvent.SETUP
	 */
	[Event(name="setup", type="mx.events.ModuleEvent")] 

	/**
	 *  Dispatched when the module is finished loading.
 *
 *  @eventType mx.events.ModuleEvent.READY
	 */
	[Event(name="ready", type="mx.events.ModuleEvent")] 

	/**
	 *  Dispatched when the module throws an error.
 *
 *  @eventType mx.events.ModuleEvent.ERROR
	 */
	[Event(name="error", type="mx.events.ModuleEvent")] 

	/**
	 *  Dispatched at regular intervals as the module loads.
 *
 *  @eventType mx.events.ModuleEvent.PROGRESS
	 */
	[Event(name="progress", type="mx.events.ModuleEvent")] 

	/**
	 *  Dispatched when the module data is unloaded.
 *
 *  @eventType mx.events.ModuleEvent.UNLOAD
	 */
	[Event(name="unload", type="mx.events.ModuleEvent")] 

include "../core/Version.as"
	/**
	 *  ModuleLoader is a component that behaves much like a SWFLoader except
 *  that it follows a contract with the loaded content. This contract dictates that the child
 *  SWF file implements IFlexModuleFactory and that the factory
 *  implemented can be used to create multiple instances of the child class
 *  as needed.
 *
 *  <p>The ModuleLoader is connected to deferred instantiation and ensures that
 *  only a single copy of the module SWF file is transferred over the network by using the
 *  ModuleManager singleton.</p>
 *  
 *  @see mx.controls.SWFLoader
	 */
	public class ModuleLoader extends VBox implements IDeferredInstantiationUIComponent
	{
		/**
		 *  @private
		 */
		private var module : IModuleInfo;
		/**
		 *  @private
		 */
		private var loadRequested : Boolean;
		/**
		 *  The application domain to load your module into.
     *  Application domains are used to partition classes that are in the same 
     *  security domain. They allow multiple definitions of the same class to 
     *  exist and allow children to reuse parent definitions.
     *  
     *  @see flash.system.ApplicationDomain
     *  @see flash.system.SecurityDomain
		 */
		public var applicationDomain : ApplicationDomain;
		/**
		 *  The DisplayObject created from the module factory.
		 */
		public var child : DisplayObject;
		/**
		 *  @private
     *  Storage for the url property.
		 */
		private var _url : String;

		/**
		 *  The location of the module, expressed as a URL.
		 */
		public function get url () : String;
		/**
		 *  @private
		 */
		public function set url (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function ModuleLoader ();

		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;

		/**
		 *  Loads the module. When the module is finished loading, the ModuleLoader adds
     *  it as a child with the <code>addChild()</code> method. This is normally 
     *  triggered with deferred instantiation.
     *  
     *  <p>If the module has already been loaded, this method does nothing. It does
     *  not load the module a second time.</p>
     * 
     *  @param url The location of the module, expressed as a URL. This is an  
     *  optional parameter. If this parameter is null the value of the
     *  <code>url</code> property will be used. If the url parameter is provided
     *  the <code>url</code> property will be updated to the value of the url.
     * 
     *  @param bytes A ByteArray object. The ByteArray is expected to contain 
     *  the bytes of a SWF file that represents a compiled Module. The ByteArray
     *  object can be obtained by using the URLLoader class. If this parameter
     *  is specified the module will be loaded from the ByteArray and the url 
     *  parameter will be used to identify the module in the 
     *  <code>ModuleManager.getModule()</code> method and must be non-null. If
     *  this parameter is null the module will be load from the url, either 
     *  the url parameter if it is non-null, or the url property as a fallback.
		 */
		public function loadModule (url:String = null, bytes:ByteArray = null) : void;

		/**
		 *  Unloads the module and sets it to <code>null</code>.
     *  If an instance of the module was previously added as a child,
     *  this method calls the <code>removeChild()</code> method on the child. 
     *  <p>If the module does not exist or has already been unloaded, this method does
     *  nothing.</p>
		 */
		public function unloadModule () : void;

		/**
		 *  @private
		 */
		private function moduleProgressHandler (event:ModuleEvent) : void;

		/**
		 *  @private
		 */
		private function moduleSetupHandler (event:ModuleEvent) : void;

		/**
		 *  @private
		 */
		private function moduleReadyHandler (event:ModuleEvent) : void;

		/**
		 *  @private
		 */
		private function moduleErrorHandler (event:ModuleEvent) : void;

		/**
		 *  @private
		 */
		private function moduleUnloadHandler (event:ModuleEvent) : void;
	}
}
