package flash.events
{
	import flash.events.Event;

	/// An object dispatches a DataEvent object when raw data has completed loading.
	public class DataEvent extends TextEvent
	{
		/// Defines the value of the type property of a data event object.
		public static const DATA : String = "data";
		/// Defines the value of the type property of an uploadCompleteData event object.
		public static const UPLOAD_COMPLETE_DATA : String = "uploadCompleteData";

		/// The raw data loaded into Flash Player or Adobe AIR.
		public function get data () : String;
		public function set data (value:String) : void;

		/// Creates a copy of the DataEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Constructor for DataEvent objects.
		public function DataEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "");

		/// Returns a string that contains all the properties of the DataEvent object.
		public function toString () : String;
	}
}
