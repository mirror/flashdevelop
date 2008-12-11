package flash.ui
{
	/// Use the ContextMenuItem class to create custom menu items to display in the Flash Player context menu.
	public class ContextMenuItem extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a user selects an item from a context menu.
		 * @eventType flash.events.ContextMenuEvent.MENU_ITEM_SELECT
		 */
		[Event(name="menuItemSelect", type="flash.events.ContextMenuEvent")]

		/// Specifies the menu item caption (text) displayed in the context menu.
		public var caption:String;

		/// Indicates whether the specified menu item is enabled or disabled.
		public var enabled:Boolean;

		/// Indicates whether a separator bar should appear above the specified menu item.
		public var separatorBefore:Boolean;

		/// Indicates whether the specified menu item is visible when the Flash Player context menu is displayed.
		public var visible:Boolean;

		/// Creates a new ContextMenuItem object that can be added to the ContextMenu.customItems array.
		public function ContextMenuItem(caption:String, separatorBefore:Boolean=false, enabled:Boolean=true, visible:Boolean=true);

		/// Creates and returns a copy of the specified ContextMenuItem object.
		public function clone():flash.ui.ContextMenuItem;

	}

}

