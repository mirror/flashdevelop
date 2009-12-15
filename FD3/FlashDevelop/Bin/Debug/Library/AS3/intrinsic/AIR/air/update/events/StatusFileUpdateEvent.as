package air.update.events
{
	import flash.events.Event;

	/// Dispatched after the updater successfully validates the file in the call to the installFromAIRFile() method.
	public class StatusFileUpdateEvent extends UpdateEvent
	{
		/// Indicates if if there is a different version available than one of the current application (true); false otherwise (same version).
		public var available : Boolean;
		/// The StatusUpdateEvent.UPDATE_STATUS constant defines the value of the type property of the event object for a updateStatus event.
		public static const FILE_UPDATE_STATUS : String;
		/// The nativePath property of the update File object specified by the airFile parameter in a call to the installFromAIRFile() method.
		public var path : String;
		/// Indicates the version of the new update.
		public var version : String;

		/// Creates a copy of the object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// The constructor function.
		public function StatusFileUpdateEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, available:Boolean = false, version:String = "", path:String = "");

		/// Returns a string that contains all the properties of the object.
		public function toString () : String;
	}
}
