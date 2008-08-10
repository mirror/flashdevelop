/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import flash.display.DisplayObject;
	public interface IFocusManagerContainer extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * The FocusManager for this component.
		 *  The FocusManager must be in a focusManager property.
		 */
		public function get focusManager():IFocusManager;
		public function set focusManager(value:IFocusManager):void;
		/**
		 * Returns the SystemManager object used by this component.
		 */
		public function get systemManager():ISystemManager;
		/**
		 * Determines whether the specified display object is a child
		 *  of the container instance or the instance itself.
		 *  The search includes the entire display list including this container instance.
		 *  Grandchildren, great-grandchildren, and so on each return true.
		 *
		 * @param child             <DisplayObject> The child object to test.
		 * @return                  <Boolean> true if the child object is a child of the container
		 *                            or the container itself; otherwise false.
		 */
		public function contains(child:DisplayObject):Boolean;
	}
}
