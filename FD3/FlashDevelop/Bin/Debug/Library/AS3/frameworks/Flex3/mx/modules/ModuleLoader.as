/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.modules {
	import mx.containers.VBox;
	import mx.core.IDeferredInstantiationUIComponent;
	public class ModuleLoader extends VBox implements IDeferredInstantiationUIComponent {
		/**
		 * The application domain to load your module into.
		 *  Application domains are used to partition classes that are in the same
		 *  security domain. They allow multiple definitions of the same class to
		 *  exist and allow children to reuse parent definitions.
		 */
		public var applicationDomain:ApplicationDomain;
		/**
		 * The DisplayObject created from the module factory.
		 */
		public var child:DisplayObject;
		/**
		 * The location of the module, expressed as a URL.
		 */
		public function get url():String;
		public function set url(value:String):void;
		/**
		 * Constructor.
		 */
		public function ModuleLoader();
		/**
		 * Loads the module. When the module is finished loading, the ModuleLoader adds
		 *  it as a child with the addChild() method. This is normally
		 *  triggered with deferred instantiation.
		 */
		public function loadModule():void;
		/**
		 * Unloads the module and sets it to null.
		 *  If an instance of the module was previously added as a child,
		 *  this method calls the removeChild() method on the child.
		 */
		public function unloadModule():void;
	}
}
