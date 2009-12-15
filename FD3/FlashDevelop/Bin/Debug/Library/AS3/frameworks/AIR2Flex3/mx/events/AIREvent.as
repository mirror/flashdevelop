package mx.events
{
	import flash.events.Event;

	public class AIREvent extends Event
	{
		public static const APPLICATION_ACTIVATE : String = "applicationActivate";
		public static const APPLICATION_DEACTIVATE : String = "applicationDeactivate";
		public static const VERSION : String;
		public static const WINDOW_ACTIVATE : String = "windowActivate";
		public static const WINDOW_COMPLETE : String = "windowComplete";
		public static const WINDOW_DEACTIVATE : String = "windowDeactivate";

		public function AIREvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);

		public function clone () : Event;
	}
}
