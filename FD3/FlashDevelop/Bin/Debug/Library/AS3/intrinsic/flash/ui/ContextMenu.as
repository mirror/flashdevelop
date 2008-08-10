/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/*** Manual fix to remove AIR-specific dependency       ***/
/**********************************************************/
package flash.ui {
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	public final  class ContextMenu extends EventDispatcher {
		/**
		 * An object that has the following properties of the ContextMenuBuiltInItems class: forwardAndBack, loop,
		 *  play, print, quality,
		 *  rewind, save, and zoom.
		 *  Setting these properties to false removes the corresponding menu items from the
		 *  specified ContextMenu object. These properties are enumerable and are set to true by
		 *  default.
		 */
		public function get builtInItems():ContextMenuBuiltInItems;
		public function set builtInItems(value:ContextMenuBuiltInItems):void;
		/**
		 * An array of ContextMenuItem objects. Each object in the array represents a context menu item that you
		 *  have defined. Use this property to add, remove, or modify these custom menu items.
		 */
		public function get customItems():Array;
		public function set customItems(value:Array):void;
		/**
		 * Creates a ContextMenu object.
		 */
		public function ContextMenu();
		/**
		 * Hides all built-in menu items (except Settings) in the specified ContextMenu object. If the debugger version of Flash
		 *  Player is running, the Debugging menu item appears, although it is dimmed for SWF files that
		 *  do not have remote debugging enabled.
		 */
		public function hideBuiltInItems():void;
	}
}
