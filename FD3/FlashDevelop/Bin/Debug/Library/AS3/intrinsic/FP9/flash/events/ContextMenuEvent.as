package flash.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;

	/// Flash&#xAE; Player dispatches ContextMenuEvent objects when a user generates or interacts with the context menu.
	public class ContextMenuEvent extends Event
	{
		/// Defines the value of the type property of a menuItemSelect event object.
		public static const MENU_ITEM_SELECT : String = "menuItemSelect";
		/// Defines the value of the type property of a menuSelect event object.
		public static const MENU_SELECT : String = "menuSelect";

		/// The display list object to which the menu is attached.
		public function get contextMenuOwner () : InteractiveObject;
		public function set contextMenuOwner (value:InteractiveObject) : void;

		/// The display list object on which the user right-clicked to display the context menu.
		public function get mouseTarget () : InteractiveObject;
		public function set mouseTarget (value:InteractiveObject) : void;

		/// Creates a copy of the ContextMenuEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Constructor for ContextMenuEvent objects.
		public function ContextMenuEvent (type:String = null, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null);

		/// Returns a string that contains all the properties of the ContextMenuEvent object.
		public function toString () : String;
	}
}
