package flash.ui
{
	import flash.ui.ContextMenuClipboardItems;

	/// The ContextMenuClipboardItems class determines which items are enabled or disabled on the clipboard context menu.
	public class ContextMenuClipboardItems extends Object
	{
		/// Enables or disables the 'Delete' or 'Clear' item on the clipboard menu.
		public function get clear () : Boolean;
		public function set clear (val:Boolean) : void;

		/// Enables or disables the 'Copy' item on the clipboard menu.
		public function get copy () : Boolean;
		public function set copy (val:Boolean) : void;

		/// Enables or disables the 'Cut' item on the clipboard menu.
		public function get cut () : Boolean;
		public function set cut (val:Boolean) : void;

		/// Enables or disables the 'Paste' item on the clipboard menu.
		public function get paste () : Boolean;
		public function set paste (val:Boolean) : void;

		/// Enables or disables the 'Select All' item on the clipboard menu.
		public function get selectAll () : Boolean;
		public function set selectAll (val:Boolean) : void;

		public function clone () : ContextMenuClipboardItems;

		/// Creates a new ContextMenuClipboardItems object so that you can set the properties for Flash Player to enable or disable each menu item.
		public function ContextMenuClipboardItems ();
	}
}
