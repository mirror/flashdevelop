package flash.events
{
	import flash.events.Event;

	public class TransformGestureEvent extends GestureEvent
	{
		public static const GESTURE_PAN : String = "gesturePan";
		public static const GESTURE_ROTATE : String = "gestureRotate";
		public static const GESTURE_SWIPE : String = "gestureSwipe";
		public static const GESTURE_ZOOM : String = "gestureZoom";

		public function get offsetX () : Number;
		public function set offsetX (value:Number) : void;

		public function get offsetY () : Number;
		public function set offsetY (value:Number) : void;

		public function get rotation () : Number;
		public function set rotation (value:Number) : void;

		public function get scaleX () : Number;
		public function set scaleX (value:Number) : void;

		public function get scaleY () : Number;
		public function set scaleY (value:Number) : void;

		public function clone () : Event;

		public function toString () : String;

		public function TransformGestureEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, phase:String = null, localX:Number = 0, localY:Number = 0, scaleX:Number = 1, scaleY:Number = 1, rotation:Number = 0, offsetX:Number = 0, offsetY:Number = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
	}
}
