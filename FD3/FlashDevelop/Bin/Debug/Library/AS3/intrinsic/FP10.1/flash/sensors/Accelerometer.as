package flash.sensors
{
	import flash.events.EventDispatcher;

	public class Accelerometer extends EventDispatcher
	{
		public static function get isSupported () : Boolean;

		public function Accelerometer ();

		public function setRequestedUpdateInterval (interval:Number) : void;
	}
}
