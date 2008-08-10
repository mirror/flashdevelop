/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	import flash.display.InteractiveObject;
	public class ContextMenuEvent extends Event {
		/**
		 * The display list object to which the menu is attached. This could be the mouse target (mouseTarget) or one of its ancestors in the display list.
		 */
		public function get contextMenuOwner():InteractiveObject;
		public function set contextMenuOwner(value:InteractiveObject):void;
		/**
		 * The display list object on which the user right-clicked to display the context menu. This could be the display list object to which the menu is attached (contextMenuOwner) or one of its display list descendants.
		 */
		public function get mouseTarget():InteractiveObject;
		public function set mouseTarget(value:InteractiveObject):void;
		/**
		 * Creates an Event object that contains specific information about menu events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            ContextMenuEvent.MENU_ITEM_SELECT
		 *                            ContextMenuEvent.MENU_SELECT
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param mouseTarget       <InteractiveObject (default = null)> The display list object on which the user right-clicked to display the context menu. This could be the contextMenuOwner or one of its display list descendants.
		 * @param contextMenuOwner  <InteractiveObject (default = null)> The display list object to which the menu is attached. This could be the mouseTarget or one of its ancestors in the display list.
		 */
		public function ContextMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null);
		/**
		 * Creates a copy of the ContextMenuEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new ContextMenuEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the ContextMenuEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the ContextMenuEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a menuItemSelect event object.
		 */
		public static const MENU_ITEM_SELECT:String = "menuItemSelect";
		/**
		 * Defines the value of the type property of a menuSelect event object.
		 */
		public static const MENU_SELECT:String = "menuSelect";
	}
}
