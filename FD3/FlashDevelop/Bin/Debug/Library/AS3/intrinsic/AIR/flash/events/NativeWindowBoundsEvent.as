package flash.events
{
	import flash.geom.Rectangle;
	import flash.events.Event;

	/// A NativeWindow object dispatches a NativeWindowBoundsEvent object when the size or location of the window changes.
	public class NativeWindowBoundsEvent extends Event
	{
		/// [AIR] Defines the value of the type property of a move event object.
		public static const MOVE : String = "move";
		/// [AIR] Defines the value of the type property of a moving event object.
		public static const MOVING : String = "moving";
		/// [AIR] Defines the value of the type property of a resize event object.
		public static const RESIZE : String = "resize";
		/// [AIR] Defines the value of the type property of a resizing event object.
		public static const RESIZING : String = "resizing";

		/// [AIR] The bounds of the window after the change.
		public function get afterBounds () : Rectangle;

		/// [AIR] The bounds of the window before the change.
		public function get beforeBounds () : Rectangle;

		/// [AIR] Creates a copy of the NativeWindowBoundsEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// [AIR] Returns a string that contains all the properties of the NativeWindowBoundsEvent object.
		public function toString () : String;
	}
}
