package flash.events
{
	import flash.geom.Rectangle;
	import flash.events.Event;

	/// A NativeWindow object dispatches a NativeWindowBoundsEvent object when the size or location of the window changes.
	public class NativeWindowBoundsEvent extends Event
	{
		/// Defines the value of the type property of a move event object.
		public static const MOVE : String = "move";
		/// Defines the value of the type property of a moving event object.
		public static const MOVING : String = "moving";
		/// Defines the value of the type property of a resize event object.
		public static const RESIZE : String = "resize";
		/// Defines the value of the type property of a resizing event object.
		public static const RESIZING : String = "resizing";

		/// The bounds of the window after the change.
		public function get afterBounds () : Rectangle;

		/// The bounds of the window before the change.
		public function get beforeBounds () : Rectangle;

		/// Creates a copy of the NativeWindowBoundsEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Creates an Event object with specific information relevant to window bounds events.
		public function NativeWindowBoundsEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeBounds:Rectangle = null, afterBounds:Rectangle = null);

		/// Returns a string that contains all the properties of the NativeWindowBoundsEvent object.
		public function toString () : String;
	}
}
