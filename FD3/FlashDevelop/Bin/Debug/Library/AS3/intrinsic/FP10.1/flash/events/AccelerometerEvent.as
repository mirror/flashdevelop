package flash.events
{
	import flash.events.Event;

	public class AccelerometerEvent extends Event
	{
		public var accelerationX : Number;
		public var accelerationY : Number;
		public var accelerationZ : Number;
		public var timestamp : Number;
		public static const UPDATE : String = "update";

		public function AccelerometerEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, timestamp:Number = 0, accelerationX:Number = 0, accelerationY:Number = 0, accelerationZ:Number = 0);

		public function clone () : Event;

		public function toString () : String;
	}
}
