package flash.ui
{
	import flash.display.NativeMenuItem;
	import flash.ui.ContextMenuItem;

	/**
	 * Dispatched when a user selects an item from a context menu.
	 * @eventType flash.events.ContextMenuEvent.MENU_ITEM_SELECT
	 */
	[Event(name="menuItemSelect", type="flash.events.ContextMenuEvent")] 

	/// Use the ContextMenuItem class to create custom menu items to display in the Flash Player context menu.
	public class ContextMenuItem extends NativeMenuItem
	{
		/// Specifies the menu item caption (text) displayed in the context menu.
		public function get caption () : String;
		public function set caption (value:String) : void;

		/// Indicates whether a separator bar should appear above the specified menu item.
		public function get separatorBefore () : Boolean;
		public function set separatorBefore (value:Boolean) : void;

		/// Indicates whether the specified menu item is visible when the Flash Player context menu is displayed.
		public function get visible () : Boolean;
		public function set visible (value:Boolean) : void;

		/// Creates a copy of the NativeMenuItem object.
		public function clone () : ContextMenuItem;

		/// Creates a new ContextMenuItem object that can be added to the ContextMenu.customItems array.
		public function ContextMenuItem (caption:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true);
	}
}
