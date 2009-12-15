package flash.events
{
	import flash.events.Event;

	public class UncaughtErrorEvent extends ErrorEvent
	{
		public static const UNCAUGHT_ERROR : String = "uncaughtError";

		public function get error () : *;

		public function clone () : Event;

		public function toString () : String;

		public function UncaughtErrorEvent (type:String = "uncaughtError", bubbles:Boolean = true, cancelable:Boolean = true, error_in:* = null);
	}
}
