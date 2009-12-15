package flash.ui
{
	import flash.events.EventDispatcher;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenu;

	/// The ContextMenu class provides control over the items displayed in context menus.
	public class ContextMenu extends EventDispatcher
	{
		/// An object that has the following properties of the ContextMenuBuiltInItems class: forwardAndBack, loop, play, print, quality, rewind, save, and zoom.
		public function get builtInItems () : ContextMenuBuiltInItems;
		public function set builtInItems (value:ContextMenuBuiltInItems) : void;

		/// An array of ContextMenuItem objects.
		public function get customItems () : Array;
		public function set customItems (value:Array) : void;

		/// Creates a copy of the menu and all items.
		public function clone () : ContextMenu;

		/// Creates a ContextMenu object.
		public function ContextMenu ();

		/// Hides all built-in menu items (except Settings) in the specified ContextMenu object.
		public function hideBuiltInItems () : void;
	}
}
