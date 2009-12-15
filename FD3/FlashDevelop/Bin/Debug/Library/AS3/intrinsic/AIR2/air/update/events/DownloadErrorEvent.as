package air.update.events
{
	import flash.events.ErrorEvent;
	import flash.events.Event;

	/// A DownloadErrorEvent object is dispatched by an ApplicationUpdater or ApplicationUpdaterUI object when an error happens while downloading the update file.
	public class DownloadErrorEvent extends ErrorEvent
	{
		/// The DownloadErrorEvent.DOWNLOAD_ERROR constant defines the value of the type property of the event object for a downloadError event.
		public static const DOWNLOAD_ERROR : String;
		/// Provides information in addition to the errorId property.
		public var subErrorID : int;

		/// Creates a copy of the object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// The constructor function.
		public function DownloadErrorEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0, subErrorID:int = 0);

		/// Returns a string that contains all the properties of the object.
		public function toString () : String;
	}
}
