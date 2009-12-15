package flash.events
{
	import flash.events.Event;

	public class GeolocationEvent extends Event
	{
		public var altitude : Number;
		public var heading : Number;
		public var horizontalAccuracy : Number;
		public var latitude : Number;
		public var longitude : Number;
		public var speed : Number;
		public var timestamp : int;
		public static const UPDATE : String = "update";
		public var verticalAccuracy : Number;

		public function clone () : Event;

		public function GeolocationEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, latitude:Number = 0, longitude:Number = 0, altitude:Number = 0, hAccuracy:Number = 0, vAccuracy:Number = 0, speed:Number = 0, heading:Number = 0, timestamp:Number = 0);

		public function toString () : String;
	}
}
