package flash.events
{
	/// Flash&#xAE; Player dispatches StatusEvent objects when a device, such as a camera or microphone, or an object such as a LocalConnection object reports its status.
	public class StatusEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a status event object.
		public static const STATUS:String = "status";

		/// A description of the object's status.
		public var code:String;

		/// The category of the message, such as "status", "warning" or "error".
		public var level:String;

		/// Constructor for StatusEvent objects.
		public function StatusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, code:String, level:String);

		/// Creates a copy of the StatusEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the StatusEvent object.
		public function toString():String;

	}

}

