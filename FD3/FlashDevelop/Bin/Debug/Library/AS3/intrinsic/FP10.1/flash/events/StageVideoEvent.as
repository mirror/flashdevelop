package flash.events
{
	public class StageVideoEvent extends Event
	{
		public function get colorSpace () : String;

		public function get status () : String;

		public function StageVideoEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = null, colorSpace:String = null);
	}
}
