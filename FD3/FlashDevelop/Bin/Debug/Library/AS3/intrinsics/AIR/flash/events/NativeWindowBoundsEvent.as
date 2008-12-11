package flash.events
{
	/// A NativeWindow object dispatches a NativeWindowBoundsEvent object when the size or location of the window changes.
	public class NativeWindowBoundsEvent extends flash.events.Event
	{
		/// [AIR] Defines the value of the type property of a moving event object.
		public static const MOVING:String = "moving";

		/// [AIR] Defines the value of the type property of a move event object.
		public static const MOVE:String = "move";

		/// [AIR] Defines the value of the type property of a resizing event object.
		public static const RESIZING:String = "resizing";

		/// [AIR] Defines the value of the type property of a resize event object.
		public static const RESIZE:String = "resize";

		/// [AIR] The bounds of the window before the change.
		public var beforeBounds:flash.geom.Rectangle;

		/// [AIR] The bounds of the window after the change.
		public var afterBounds:flash.geom.Rectangle;

		/// [AIR] Creates an Event object with specific information relevant to window bounds events.
		public function NativeWindowBoundsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, beforeBounds:flash.geom.Rectangle=null, afterBounds:flash.geom.Rectangle=null);

		/// [AIR] Creates a copy of the NativeWindowBoundsEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the NativeWindowBoundsEvent object.
		public function toString():String;

	}

}

