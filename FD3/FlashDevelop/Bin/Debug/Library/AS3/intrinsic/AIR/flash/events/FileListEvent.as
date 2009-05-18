package flash.events
{
	/// A File object dispatches a FileListEvent object when a call to the getDirectoryListingAsync() method of a File object successfully enumerates a set of files and directories or when a user selects files after a call to the browseForOpenMultiple() method.
	public class FileListEvent extends Event
	{
		/// [AIR] The FileListEvent.DIRECTORY_LISTING constant defines the value of the type property of the event object for a directoryListing event.
		public static const DIRECTORY_LISTING : String = "directoryListing";
		/// [AIR] An array of File objects representing the files and directories found or selected.
		public var files : Array;
		/// [AIR] The FileListEvent.SELECT_MULTIPLE constant defines the value of the type property of the event object for a selectMultiple event.
		public static const SELECT_MULTIPLE : String = "selectMultiple";

		/// [AIR] The constructor function for a FileListEvent object.
		public function FileListEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, files:Array = null);
	}
}
