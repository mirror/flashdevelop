package mx.events
{
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class FlexNativeWindowBoundsEvent extends NativeWindowBoundsEvent
	{
		public static const WINDOW_MOVE : String = "windowMove";
		public static const WINDOW_RESIZE : String = "windowResize";

		public function clone () : Event;

		public function FlexNativeWindowBoundsEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeBounds:Rectangle = null, afterBounds:Rectangle = null);
	}
}
