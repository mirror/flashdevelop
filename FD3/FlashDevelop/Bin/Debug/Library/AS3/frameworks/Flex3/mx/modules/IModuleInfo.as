/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.modules {
	import mx.core.IFlexModuleFactory;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	public interface IModuleInfo extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * User data that can be associated with the singleton IModuleInfo
		 *  for a given URL.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * A flag that is true if there was an error
		 *  during module loading.
		 */
		public function get error():Boolean;
		/**
		 * The IFlexModuleFactory implementation defined in the module.
		 *  This will only be non-null after the
		 *  ModuleEvent.SETUP event has been dispatched
		 *  (or the IModuleInfo.setup() method returns true).
		 *  At this point, the IFlexModuleFactory.info() method can be called.
		 *  Once a ModuleEvent.READY event is dispatched
		 *  (or the IModuleInfo.ready() method returns true),
		 *  it is possible to call the IFlexModuleFactory.create() method.
		 */
		public function get factory():IFlexModuleFactory;
		/**
		 * A flag that is true if the load()
		 *  method has been called on this module.
		 */
		public function get loaded():Boolean;
		/**
		 * A flag that is true if the module is sufficiently loaded
		 *  to get a handle to its associated IFlexModuleFactory implementation
		 *  and call its create() method.
		 */
		public function get ready():Boolean;
		/**
		 * A flag that is true if the module is sufficiently loaded
		 *  to get a handle to its associated IFlexModuleFactory implementation
		 *  and call its info() method.
		 */
		public function get setup():Boolean;
		/**
		 * The URL associated with this module (for example, "MyImageModule.swf" or
		 *  "http://somedomain.com/modules/MyImageModule.swf". The URL can be local or remote, but
		 *  if it is remote, you must establish a trust between the module's domain and the
		 *  application that loads it.
		 */
		public function get url():String;
		/**
		 * Requests that the module be loaded. If the module is already loaded,
		 *  the call does nothing. Otherwise, the module begins loading and dispatches
		 *  progress events as loading proceeds.
		 *
		 * @param applicationDomain <ApplicationDomain (default = null)> The current application domain in which your code is executing.
		 * @param securityDomain    <SecurityDomain (default = null)> The current security "sandbox".
		 */
		public function load(applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null):void;
		/**
		 * Publishes an interface to the ModuleManager. This allows late (or decoupled)
		 *  subscriptions to factories with a String handle. Use a URL that starts with
		 *  publish:// to reference factories that are published in this manner.
		 *
		 * @param factory           <IFlexModuleFactory> The class that implements the module's IFlexModuleFactory interface.
		 */
		public function publish(factory:IFlexModuleFactory):void;
		/**
		 * Releases the current reference to the module.
		 *  This does not unload the module unless there are no other
		 *  open references to it and the ModuleManager is set up
		 *  to have only a limited number of loaded modules.
		 */
		public function release():void;
		/**
		 * Unloads the module.
		 *  Flash Player and AIR will not fully unload and garbage collect this module if
		 *  there are any outstanding references to definitions inside the
		 *  module.
		 */
		public function unload():void;
	}
}
