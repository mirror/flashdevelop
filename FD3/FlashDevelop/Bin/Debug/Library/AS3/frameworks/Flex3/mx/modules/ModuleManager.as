package mx.modules
{
	import flash.utils.ByteArray;
	import mx.core.IFlexModuleFactory;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.core.IFlexModuleFactory;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;

include "../core/Version.as"
	/**
	 *  The ModuleManager class centrally manages dynamically loaded modules.
 *  It maintains a mapping of URLs to modules.
 *  A module can exist in a state where it is already loaded
 *  (and ready for use), or in a not-loaded-yet state.
 *  The ModuleManager dispatches events that indicate module status.
 *  Clients can register event handlers and then call the 
 *  <code>load()</code> method, which dispatches events when the factory is ready
 *  (or immediately, if it was already loaded).
	 */
	public class ModuleManager
	{
		/**
		 *  Get the IModuleInfo interface associated with a particular URL.
     *  There is no requirement that this URL successfully load,
     *  but the ModuleManager returns a unique IModuleInfo handle for each unique URL.
     *  
     *  @param url A URL that represents the location of the module.
     *  
     *  @return The IModuleInfo interface associated with a particular URL.
		 */
		public static function getModule (url:String) : IModuleInfo;

		/**
		 *  See if the referenced object is associated with (or, in the managed
     *  ApplicationDomain of) a known IFlexModuleFactory implementation.
     *  
     *  @param object The object that the ModuleManager tries to create.
     * 
     *  @return Returns the IFlexModuleFactory implementation, or <code>null</code>
     *  if the object type cannot be created from the factory.
		 */
		public static function getAssociatedFactory (object:Object) : IFlexModuleFactory;

		/**
		 *  @private
     *  Typed as Object, for now. Ideally this should be IModuleManager.
		 */
		private static function getSingleton () : Object;
	}
	/**
	 *  @private
 *  ModuleManagerImpl is the Module Manager singleton,
 *  hidden from direct access by the ModuleManager class.
 *  See the documentation for ModuleManager for the details on this class.
	 */
	private class ModuleManagerImpl extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private var moduleList : Object;

		/**
		 *  Constructor.
		 */
		public function ModuleManagerImpl ();

		/**
		 *  @private
		 */
		public function getAssociatedFactory (object:Object) : IFlexModuleFactory;

		/**
		 *  @private
		 */
		public function getModule (url:String) : IModuleInfo;
	}
	/**
	 *  @private
 *  The ModuleInfo class encodes the loading state of a module.
 *  It isn't used directly, because there needs to be only one single
 *  ModuleInfo per URL, even if that URL is loaded multiple times,
 *  yet individual clients need their own dedicated events dispatched
 *  without re-dispatching to clients that already received their events.
 *  ModuleInfoProxy holds the public IModuleInfo implementation
 *  that can be externally manipulated.
	 */
	private class ModuleInfo extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private var factoryInfo : FactoryInfo;
		/**
		 *  @private
		 */
		private var limbo : Dictionary;
		/**
		 *  @private
		 */
		private var loader : Loader;
		/**
		 *  @private
		 */
		private var numReferences : int;
		/**
		 *  @private
     *  Storage for the error property.
		 */
		private var _error : Boolean;
		/**
		 *  @private
     *  Storage for the loader property.
		 */
		private var _loaded : Boolean;
		/**
		 *  @private
     *  Storage for the ready property.
		 */
		private var _ready : Boolean;
		/**
		 *  @private
     *  Storage for the setup property.
		 */
		private var _setup : Boolean;
		/**
		 *  @private
     *  Storage for the url property.
		 */
		private var _url : String;

		/**
		 *  @private
		 */
		public function get applicationDomain () : ApplicationDomain;

		/**
		 *  @private
		 */
		public function get error () : Boolean;

		/**
		 *  @private
		 */
		public function get factory () : IFlexModuleFactory;

		/**
		 *  @private
		 */
		public function get loaded () : Boolean;

		/**
		 *  @private
		 */
		public function get ready () : Boolean;

		/**
		 *  @private
		 */
		public function get setup () : Boolean;

		/**
		 *  @private
		 */
		public function get size () : int;

		/**
		 *  @private
		 */
		public function get url () : String;

		/**
		 *  Constructor.
		 */
		public function ModuleInfo (url:String);

		/**
		 *  @private
		 */
		public function load (applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null, bytes:ByteArray = null) : void;

		/**
		 *  @private
		 */
		private function loadBytes (applicationDomain:ApplicationDomain, bytes:ByteArray) : void;

		/**
		 *  @private
		 */
		public function resurrect () : void;

		/**
		 *  @private
		 */
		public function release () : void;

		/**
		 *  @private
		 */
		private function clearLoader () : void;

		/**
		 *  @private
		 */
		public function unload () : void;

		/**
		 *  @private
		 */
		public function publish (factory:IFlexModuleFactory) : void;

		/**
		 *  @private
		 */
		public function addReference () : void;

		/**
		 *  @private
		 */
		public function removeReference () : void;

		/**
		 *  @private
		 */
		public function initHandler (event:Event) : void;

		/**
		 *  @private
		 */
		public function progressHandler (event:ProgressEvent) : void;

		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		public function errorHandler (event:ErrorEvent) : void;

		/**
		 *  @private
		 */
		public function readyHandler (event:Event) : void;

		/**
		 *  @private
		 */
		public function moduleErrorHandler (event:Event) : void;
	}
	/**
	 *  @private
 *  Used for weak dictionary references to a GC-able module.
	 */
	private class FactoryInfo
	{
		/**
		 *  @private
		 */
		public var factory : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public var applicationDomain : ApplicationDomain;
		/**
		 *  @private
		 */
		public var bytesTotal : int;

		/**
		 *  Constructor.
		 */
		public function FactoryInfo ();
	}
	/**
	 *  @private
 *  ModuleInfoProxy implements IModuleInfo and allows each caller of load()
 *  to have their own dedicated module events, while still using the same
 *  backing load state.
	 */
	private class ModuleInfoProxy extends EventDispatcher implements IModuleInfo
	{
		/**
		 *  @private
		 */
		private var info : ModuleInfo;
		/**
		 *  @private
		 */
		private var referenced : Boolean;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;

		/**
		 *  @private
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  @private
		 */
		public function get error () : Boolean;

		/**
		 *  @private
		 */
		public function get factory () : IFlexModuleFactory;

		/**
		 *  @private
		 */
		public function get loaded () : Boolean;

		/**
		 *  @private
		 */
		public function get ready () : Boolean;

		/**
		 *  @private
		 */
		public function get setup () : Boolean;

		/**
		 *  @private
		 */
		public function get url () : String;

		/**
		 *  Constructor.
		 */
		public function ModuleInfoProxy (info:ModuleInfo);

		/**
		 *  @private
		 */
		public function publish (factory:IFlexModuleFactory) : void;

		/**
		 *  @private
		 */
		public function load (applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null, bytes:ByteArray = null) : void;

		/**
		 *  @private
		 */
		public function release () : void;

		/**
		 *  @private
		 */
		public function unload () : void;

		/**
		 *  @private
		 */
		private function moduleEventHandler (event:ModuleEvent) : void;
	}
}
