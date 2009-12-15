package flash.events
{
	import flash.events.Event;

	public class PressAndTapGestureEvent extends GestureEvent
	{
		public static const GESTURE_PRESS_AND_TAP : String = "gesturePressAndTap";

		public function get tapLocalX () : Number;
		public function set tapLocalX (value:Number) : void;

		public function get tapLocalY () : Number;
		public function set tapLocalY (value:Number) : void;

		public function get tapStageX () : Number;

		public function get tapStageY () : Number;

		public function clone () : Event;

		public function PressAndTapGestureEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, phase:String = null, localX:Number = 0, localY:Number = 0, tapLocalX:Number = 0, tapLocalY:Number = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);

		public function toString () : String;
	}
}
