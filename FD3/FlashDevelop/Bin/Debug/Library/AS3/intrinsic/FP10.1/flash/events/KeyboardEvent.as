package flash.events
{
	import flash.events.Event;

	/// A KeyboardEvent object id dispatched in response to user input through a keyboard.
	public class KeyboardEvent extends Event
	{
		/// Defines the value of the type property of a keyDown event object.
		public static const KEY_DOWN : String = "keyDown";
		/// Defines the value of the type property of a keyUp event object.
		public static const KEY_UP : String = "keyUp";

		/// Indicates whether the Alt key is active (true) or inactive (false) on Windows; indicates whether the Option key is active on Mac OS.
		public function get altKey () : Boolean;
		public function set altKey (value:Boolean) : void;

		/// Contains the character code value of the key pressed or released.
		public function get charCode () : uint;
		public function set charCode (value:uint) : void;

		/// On Windows and Linux, indicates whether the Ctrl key is active (true) or inactive (false); On Mac OS, indicates whether either the Ctrl key or the Command key is active.
		public function get ctrlKey () : Boolean;
		public function set ctrlKey (value:Boolean) : void;

		/// The key code value of the key pressed or released.
		public function get keyCode () : uint;
		public function set keyCode (value:uint) : void;

		/// Indicates the location of the key on the keyboard.
		public function get keyLocation () : uint;
		public function set keyLocation (value:uint) : void;

		/// Indicates whether the Shift key modifier is active (true) or inactive (false).
		public function get shiftKey () : Boolean;
		public function set shiftKey (value:Boolean) : void;

		/// Creates a copy of the KeyboardEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Constructor for KeyboardEvent objects.
		public function KeyboardEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, charCodeValue:uint = 0, keyCodeValue:uint = 0, keyLocationValue:uint = 0, ctrlKeyValue:Boolean = false, altKeyValue:Boolean = false, shiftKeyValue:Boolean = false);

		/// Returns a string that contains all the properties of the KeyboardEvent object.
		public function toString () : String;

		/// Indicates that the display should be rendered after processing of this event completes, if the display list has been modified
		public function updateAfterEvent () : void;
	}
}
