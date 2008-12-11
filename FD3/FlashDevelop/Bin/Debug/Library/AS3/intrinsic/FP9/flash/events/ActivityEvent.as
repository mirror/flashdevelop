package flash.events
{
	/// A Camera or Microphone object dispatches an ActivityEvent object whenever a camera or microphone reports that it has become active or inactive.
	public class ActivityEvent extends flash.events.Event
	{
		/// The ActivityEvent.ACTIVITY constant defines the value of the type property of an activity event object.
		public static const ACTIVITY:String = "activity";

		/// Indicates whether the device is activating (true) or deactivating (false).
		public var activating:Boolean;

		/// Constructor for ActivityEvent objects.
		public function ActivityEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, activating:Boolean=false);

		/// Creates a copy of an ActivityEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the ActivityEvent object.
		public function toString():String;

	}

}

