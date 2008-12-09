package flash.ui
{
	/// The ContextMenu class provides control over the items in the Flash Player context menu.
	public class ContextMenu extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a user first generates a context menu but before the contents of the context menu are displayed.
		 * @eventType flash.events.ContextMenuEvent.MENU_SELECT
		 */
		[Event(name="menuSelect", type="flash.events.ContextMenuEvent")]

		/// An object that has the following properties of the ContextMenuBuiltInItems class: forwardAndBack, loop, play, print, quality, rewind, save, and zoom.
		public var builtInItems:flash.ui.ContextMenuBuiltInItems;

		/// An array of ContextMenuItem objects.
		public var customItems:Array;

		/// The URLRequest of the link.
		public var link:flash.net.URLRequest;

		/// Specifies whether or not the clipboard menu should be used.
		public var clipboardMenu:Boolean;

		/// An object that has the following properties of the ContextMenuClipboardItems class: cut, copy, paste, delete, selectAll.
		public var clipboardItems:flash.ui.ContextMenuClipboardItems;

		/// Creates a ContextMenu object.
		public function ContextMenu();

		/// Creates a copy of the specified ContextMenu object.
		public function clone():flash.ui.ContextMenu;

		/// Hides all built-in menu items (except Settings) in the specified ContextMenu object.
		public function hideBuiltInItems():void;

	}

}

