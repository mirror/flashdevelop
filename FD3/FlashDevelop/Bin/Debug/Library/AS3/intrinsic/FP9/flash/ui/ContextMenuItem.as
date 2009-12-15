package flash.ui
{
	import flash.events.EventDispatcher;
	import flash.ui.ContextMenuItem;

	/// Use the ContextMenuItem class to create custom menu items to display in the Flash Player context menu.
	public class ContextMenuItem extends EventDispatcher
	{
		/// Specifies the menu item caption (text) displayed in the context menu.
		public function get caption () : String;
		public function set caption (value:String) : void;

		public function get enabled () : Boolean;
		public function set enabled (value:Boolean) : void;

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
