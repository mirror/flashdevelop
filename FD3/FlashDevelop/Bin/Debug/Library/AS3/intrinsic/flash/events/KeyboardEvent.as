package flash.events
{
	/// Flash&#xAE; Player dispatches KeyboardEvent objects in response to user input through a keyboard.
	public class KeyboardEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a keyDown event object.
		public static const KEY_DOWN:String = "keyDown";

		/// Defines the value of the type property of a keyUp event object.
		public static const KEY_UP:String = "keyUp";

		/// Contains the character code value of the key pressed or released.
		public var charCode:uint;

		/// The key code value of the key pressed or released.
		public var keyCode:uint;

		/// Indicates the location of the key on the keyboard.
		public var keyLocation:uint;

		/// Indicates whether the Control key is active (true) or inactive (false).
		public var ctrlKey:Boolean;

		/// Indicates whether the Alt key is active (true) or inactive (false).
		public var altKey:Boolean;

		/// Indicates whether the Shift key modifier is active (true) or inactive (false).
		public var shiftKey:Boolean;

		/// Constructor for KeyboardEvent objects.
		public function KeyboardEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, charCode:uint=0, keyCode:uint=0, keyLocation:uint=0, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false);

		/// Creates a copy of the KeyboardEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the KeyboardEvent object.
		public function toString():String;

		/// Instructs Flash Player to render after processing of this event completes, if the display list has been modified
		public function updateAfterEvent():void;

	}

}

