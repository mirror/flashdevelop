package flash.events
{
	/// Flash&#xAE; Player dispatches ContextMenuEvent objects when a user generates or interacts with the context menu.
	public class ContextMenuEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a menuItemSelect event object.
		public static const MENU_ITEM_SELECT:String = "menuItemSelect";

		/// Defines the value of the type property of a menuSelect event object.
		public static const MENU_SELECT:String = "menuSelect";

		/// The display list object on which the user right-clicked to display the context menu.
		public var mouseTarget:flash.display.InteractiveObject;

		/// The display list object to which the menu is attached.
		public var contextMenuOwner:flash.display.InteractiveObject;

		/// Indicates whether the mouseTarget property was set to null for security reasons.
		public var isMouseTargetInaccessible:Boolean;

		/// Constructor for ContextMenuEvent objects.
		public function ContextMenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, mouseTarget:flash.display.InteractiveObject=null, contextMenuOwner:flash.display.InteractiveObject=null);

		/// Creates a copy of the ContextMenuEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the ContextMenuEvent object.
		public function toString():String;

	}

}

