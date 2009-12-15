package flash.automation
{
	import flash.events.Event;

	public class StageCaptureEvent extends Event
	{
		public static const CAPTURE : String;

		public function get checksum () : uint;

		public function get url () : String;

		public function clone () : Event;

		public function StageCaptureEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, url:String = "", checksum:uint = 0);

		public function toString () : String;
	}
}
