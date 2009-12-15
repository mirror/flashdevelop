package flash.net
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * Dispatched when the user selects a file for upload or download from the file-browsing dialog box.
	 * @eventType flash.events.Event.SELECT
	 */
	[Event(name="select", type="flash.events.Event")] 

	/**
	 * Dispatched when an upload or download operation starts.
	 * @eventType flash.events.Event.OPEN
	 */
	[Event(name="open", type="flash.events.Event")] 

	/**
	 * Dispatched when download is complete or when upload generates an HTTP status code of 200.
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/**
	 * Dispatched when a file upload or download is canceled through the file-browsing dialog box by the user.
	 * @eventType flash.events.Event.CANCEL
	 */
	[Event(name="cancel", type="flash.events.Event")] 

	/// The FileReference class provides a means to upload and download files between a user's computer and a server.
	public class FileReference extends EventDispatcher
	{
		/// The creation date of the file on the local disk.
		public function get creationDate () : Date;

		/// The Macintosh creator type of the file, which is only used in Mac OS versions prior to Mac OS X.
		public function get creator () : String;

		/// The ByteArray object representing the data from the loaded file after a successful call to the load() method.
		public function get data () : ByteArray;

		/// The filename extension.
		public function get extension () : String;

		/// The date that the file on the local disk was last modified.
		public function get modificationDate () : Date;

		/// The name of the file on the local disk.
		public function get name () : String;

		/// The size of the file on the local disk in bytes.
		public function get size () : Number;

		/// The file type.
		public function get type () : String;

		/// Displays a file-browsing dialog box that lets the user select a file to upload.
		public function browse (typeFilter:Array = null) : Boolean;

		/// Cancels any ongoing upload or download.
		public function cancel () : void;

		/// Opens a dialog box that lets the user download a file from a remote server.
		public function download (request:URLRequest, defaultFileName:String = null) : void;

		/// Creates a new FileReference object.
		public function FileReference ();

		/// Starts the load of a local file.
		public function load () : void;

		/// Opens a dialog box that lets the user save a file to the local filesystem.
		public function save (data:*, defaultFileName:String = null) : void;

		/// Starts the upload of a file to a remote server.
		public function upload (request:URLRequest, uploadDataFieldName:String = "Filedata", testUpload:Boolean = false) : void;

		/// Starts the upload of a file to a remote server without encoding.
		public function uploadUnencoded (request:URLRequest) : void;
	}
}
