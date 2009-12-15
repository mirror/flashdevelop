package flash.sensors
{
	import flash.events.EventDispatcher;

	public class Geolocation extends EventDispatcher
	{
		public static function get isSupported () : Boolean;

		public function Geolocation ();

		public function setRequestedUpdateInterval (interval:int) : void;
	}
}
