package flash.ui
{
	import flash.display.NativeMenu;
	import flash.display.Stage;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.net.URLRequest;
	import flash.ui.ContextMenuClipboardItems;
	import flash.display.NativeMenuItem;

	/**
	 * Dispatched when a user first generates a context menu but before the contents of the context menu are displayed.
	 * @eventType flash.events.ContextMenuEvent.MENU_SELECT
	 */
	[Event(name="menuSelect", type="flash.events.ContextMenuEvent")] 

	/// The ContextMenu class provides control over the items displayed in context menus.
	public class ContextMenu extends NativeMenu
	{
		/// An object that has the following properties of the ContextMenuBuiltInItems class: forwardAndBack, loop, play, print, quality, rewind, save, and zoom.
		public function get builtInItems () : ContextMenuBuiltInItems;
		public function set builtInItems (value:ContextMenuBuiltInItems) : void;

		/// An object that has the following properties of the ContextMenuClipboardItems class: cut, copy, paste, delete, selectAll.
		public function get clipboardItems () : ContextMenuClipboardItems;
		public function set clipboardItems (value:ContextMenuClipboardItems) : void;

		/// Specifies whether or not the clipboard menu should be used.
		public function get clipboardMenu () : Boolean;
		public function set clipboardMenu (value:Boolean) : void;

		/// An array of ContextMenuItem objects.
		public function get customItems () : Array;
		public function set customItems (value:Array) : void;

		/// The array of NativeMenuItem objects in this menu.
		public function get items () : Array;
		public function set items (itemArray:Array) : void;

		/// The URLRequest of the link.
		public function get link () : URLRequest;
		public function set link (value:URLRequest) : void;

		/// The number of NativeMenuItem objects in this menu.
		public function get numItems () : int;

		/// Inserts a menu item at the specified position.
		public function addItemAt (item:NativeMenuItem, index:int) : NativeMenuItem;

		/// Creates a copy of the menu and all items.
		public function clone () : NativeMenu;

		/// Reports whether this menu contains the specified menu item.
		public function containsItem (item:NativeMenuItem) : Boolean;

		/// Creates a ContextMenu object.
		public function ContextMenu ();

		/// Pops up this menu at the specified location.
		public function display (stage:Stage, stageX:Number, stageY:Number) : void;

		/// Gets the menu item at the specified index.
		public function getItemAt (index:int) : NativeMenuItem;

		/// Gets the position of the specified item.
		public function getItemIndex (item:NativeMenuItem) : int;

		/// Hides all built-in menu items (except Settings) in the specified ContextMenu object.
		public function hideBuiltInItems () : void;

		/// Removes all items fromt the menu.
		public function removeAllItems () : void;

		/// Removes and returns the menu item at the specified index.
		public function removeItemAt (index:int) : NativeMenuItem;
	}
}
