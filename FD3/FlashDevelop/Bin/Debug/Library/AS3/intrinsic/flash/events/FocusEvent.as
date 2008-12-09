package flash.events
{
	/// Flash&#xAE; Player dispatches FocusEvent objects when the user changes the focus from one object in the display list to another.
	public class FocusEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a focusIn event object.
		public static const FOCUS_IN:String = "focusIn";

		/// Defines the value of the type property of a focusOut event object.
		public static const FOCUS_OUT:String = "focusOut";

		/// Defines the value of the type property of a keyFocusChange event object.
		public static const KEY_FOCUS_CHANGE:String = "keyFocusChange";

		/// Defines the value of the type property of a mouseFocusChange event object.
		public static const MOUSE_FOCUS_CHANGE:String = "mouseFocusChange";

		/// A reference to the complementary InteractiveObject instance that is affected by the change in focus.
		public var relatedObject:flash.display.InteractiveObject;

		/// Indicates whether the Shift key modifier is activated, in which case the value is true.
		public var shiftKey:Boolean;

		/// The key code value of the key pressed to trigger a keyFocusChange event.
		public var keyCode:uint;

		/// Indicates whether the relatedObject property was set to null for security reasons.
		public var isRelatedObjectInaccessible:Boolean;

		/// Constructor for FocusEvent objects.
		public function FocusEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, relatedObject:flash.display.InteractiveObject=null, shiftKey:Boolean=false, keyCode:uint=0);

		/// Creates a copy of the FocusEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the FocusEvent object.
		public function toString():String;

	}

}

