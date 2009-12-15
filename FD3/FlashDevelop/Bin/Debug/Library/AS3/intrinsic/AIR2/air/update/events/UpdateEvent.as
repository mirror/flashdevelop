package air.update.events
{
	import flash.events.Event;

	/// A UpdateEvent is dispatched by a ApplicationUpdater object during the update process.
	public class UpdateEvent extends Event
	{
		/// The UpdateEvent.BEFORE_INSTALL constant defines the value of the type property of the event object for a beforeInstall event.
		public static const BEFORE_INSTALL : String;
		/// The UpdateEvent.CHECK_FOR_UPDATE constant defines the value of the type property of the event object for a checkForUpdate event.
		public static const CHECK_FOR_UPDATE : String;
		/// The UpdateEvent.DOWNLOAD_COMPLETE constant defines the value of the type property of the event object for a downloadComplete event.
		public static const DOWNLOAD_COMPLETE : String;
		/// The UpdateEvent.DOWNLOAD_START constant defines the value of the type property of the event object for a downloadStart event.
		public static const DOWNLOAD_START : String;
		/// The UpdateEvent.INITIALIZED constant defines the value of the type property of the event object for a initialized event.
		public static const INITIALIZED : String;

		/// Creates a copy of the object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Returns a string that contains all the properties of the object.
		public function toString () : String;

		/// The constructor function.
		public function UpdateEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);
	}
}
