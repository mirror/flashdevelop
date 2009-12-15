package flash.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;

	public class TouchEvent extends Event
	{
		public static const TOUCH_BEGIN : String = "touchBegin";
		public static const TOUCH_END : String = "touchEnd";
		public static const TOUCH_MOVE : String = "touchMove";
		public static const TOUCH_OUT : String = "touchOut";
		public static const TOUCH_OVER : String = "touchOver";
		public static const TOUCH_ROLL_OUT : String = "touchRollOut";
		public static const TOUCH_ROLL_OVER : String = "touchRollOver";
		public static const TOUCH_TAP : String = "touchTap";

		public function get altKey () : Boolean;
		public function set altKey (value:Boolean) : void;

		public function get ctrlKey () : Boolean;
		public function set ctrlKey (value:Boolean) : void;

		public function get isPrimaryTouchPoint () : Boolean;
		public function set isPrimaryTouchPoint (value:Boolean) : void;

		public function get isRelatedObjectInaccessible () : Boolean;
		public function set isRelatedObjectInaccessible (value:Boolean) : void;

		public function get localX () : Number;
		public function set localX (value:Number) : void;

		public function get localY () : Number;
		public function set localY (value:Number) : void;

		public function get pressure () : Number;
		public function set pressure (value:Number) : void;

		public function get relatedObject () : InteractiveObject;
		public function set relatedObject (value:InteractiveObject) : void;

		public function get shiftKey () : Boolean;
		public function set shiftKey (value:Boolean) : void;

		public function get sizeX () : Number;
		public function set sizeX (value:Number) : void;

		public function get sizeY () : Number;
		public function set sizeY (value:Number) : void;

		public function get stageX () : Number;

		public function get stageY () : Number;

		public function get touchPointID () : int;
		public function set touchPointID (value:int) : void;

		public function clone () : Event;

		public function toString () : String;

		public function TouchEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, touchPointID:int = 0, isPrimaryTouchPoint:Boolean = false, localX:Number = Non Numérique, localY:Number = Non Numérique, sizeX:Number = Non Numérique, sizeY:Number = Non Numérique, pressure:Number = Non Numérique, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);

		public function updateAfterEvent () : void;
	}
}
