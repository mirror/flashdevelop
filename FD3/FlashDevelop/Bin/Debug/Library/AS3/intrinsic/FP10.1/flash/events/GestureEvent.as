package flash.events
{
	import flash.events.Event;

	public class GestureEvent extends Event
	{
		public static const GESTURE_TWO_FINGER_TAP : String = "gestureTwoFingerTap";

		public function get altKey () : Boolean;
		public function set altKey (value:Boolean) : void;

		public function get ctrlKey () : Boolean;
		public function set ctrlKey (value:Boolean) : void;

		public function get localX () : Number;
		public function set localX (value:Number) : void;

		public function get localY () : Number;
		public function set localY (value:Number) : void;

		public function get phase () : String;
		public function set phase (value:String) : void;

		public function get shiftKey () : Boolean;
		public function set shiftKey (value:Boolean) : void;

		public function get stageX () : Number;

		public function get stageY () : Number;

		public function clone () : Event;

		public function GestureEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, phase:String = null, localX:Number = 0, localY:Number = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);

		public function toString () : String;

		public function updateAfterEvent () : void;
	}
}
