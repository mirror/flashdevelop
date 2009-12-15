package flash.events
{
	import flash.events.Event;

	/// The SystemTrayIcon object dispatches events of type ScreenMouseEvent in response to mouse interaction.
	public class ScreenMouseEvent extends MouseEvent
	{
		/// The ScreenMouseEvent.CLICK constant defines the value of the type property of a click event object.
		public static const CLICK : String = "click";
		/// The ScreenMouseEvent.MOUSE_DOWN constant defines the value of the type property of a mouseDown event object.
		public static const MOUSE_DOWN : String = "mouseDown";
		/// The ScreenMouseEvent.MOUSE_UP constant defines the value of the type property of a mouseUp event object.
		public static const MOUSE_UP : String = "mouseUp";
		/// The ScreenMouseEvent.RIGHT_CLICK constant defines the value of the type property of a rightClick event object.
		public static const RIGHT_CLICK : String = "rightClick";
		/// The ScreenMouseEvent.RIGHT_MOUSE_DOWN constant defines the value of the type property of a rightMouseDown event object.
		public static const RIGHT_MOUSE_DOWN : String = "rightMouseDown";
		/// The ScreenMouseEvent.RIGHT_MOUSE_UP constant defines the value of the type property of a rightMouseUp event object.
		public static const RIGHT_MOUSE_UP : String = "rightMouseUp";

		/// The X position of the click in screen coordinates.
		public function get screenX () : Number;

		/// The Y position of the click in screen coordinates.
		public function get screenY () : Number;

		/// Creates a copy of the ScreenMouseEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Constructor for ScreenMouseEvent objects.
		public function ScreenMouseEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, screenX:Number = null, screenY:Number = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false);

		/// Returns a string that contains all the properties of the ScreenMouseEvent object.
		public function toString () : String;
	}
}
