package flash.events
{
	/// Flash&#xAE; Player dispatches DataEvent objects when raw data has completed loading into Flash Player.
	public class DataEvent extends flash.events.TextEvent
	{
		/// Defines the value of the type property of a data event object.
		public static const DATA:String = "data";

		/// Defines the value of the type property of an uploadCompleteData event object.
		public static const UPLOAD_COMPLETE_DATA:String = "uploadCompleteData";

		/// The raw data loaded into Flash Player.
		public var data:String;

		/// Constructor for DataEvent objects.
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:String);

		/// Creates a copy of the DataEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the DataEvent object.
		public function toString():String;

	}

}

