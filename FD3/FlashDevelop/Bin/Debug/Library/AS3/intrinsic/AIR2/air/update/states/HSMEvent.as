package air.update.states
{
	import flash.events.Event;

	public class HSMEvent extends Event
	{
		public static const ENTER : String;
		public static const EXIT : String;

		public function HSMEvent (type:String);
	}
}
