package flash.events
{
	import flash.events.Event;

	/// The SystemTrayIcon object dispatches events of type ScreenMouseEvent in response to mouse interaction.
	public class ScreenMouseEvent extends MouseEvent
	{
		public static const CLICK : String = "click";
		public static const MOUSE_DOWN : String = "mouseDown";
		public static const MOUSE_UP : String = "mouseUp";
		public static const RIGHT_CLICK : String = "rightClick";
		public static const RIGHT_MOUSE_DOWN : String = "rightMouseDown";
		public static const RIGHT_MOUSE_UP : String = "rightMouseUp";

		/// [AIR] The X position of the click in screen coordinates.
		public function get screenX () : Number;

		/// [AIR] The Y position of the click in screen coordinates.
		public function get screenY () : Number;

		/// [AIR] Creates a copy of the ScreenMouseEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// [AIR] Returns a string that contains all the properties of the ScreenMouseEvent object.
		public function toString () : String;
	}
}
