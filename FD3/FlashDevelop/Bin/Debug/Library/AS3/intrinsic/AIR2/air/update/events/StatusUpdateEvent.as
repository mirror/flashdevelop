package air.update.events
{
	import flash.events.Event;

	/// An updater object dispatches a StatusUpdateEvent object after the updater successfully downloads and interprets the update descriptor file.
	public class StatusUpdateEvent extends UpdateEvent
	{
		/// Indicates if an update is available.
		public var available : Boolean;
		/// An array defining the details string for each of the supported languages.
		public var details : Array;
		/// The StatusUpdateEvent.UPDATE_STATUS constant defines the value of the type property of the event object for a updateStatus event.
		public static const UPDATE_STATUS : String;
		/// The string representing the new available version.
		public var version : String;

		/// Creates a copy of the object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// The constructor function.
		public function StatusUpdateEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, available:Boolean = false, version:String = "", details:Array = null);

		/// Returns a string that contains all the properties of the object.
		public function toString () : String;
	}
}
