package flash.events
{
	import flash.events.Event;

	/// An IOErrorEvent object is dispatched when an error causes a send or load operation to fail.
	public class IOErrorEvent extends ErrorEvent
	{
		public static const DISK_ERROR : String = "diskError";
		/// Defines the value of the type property of an ioError event object.
		public static const IO_ERROR : String = "ioError";
		public static const NETWORK_ERROR : String = "networkError";
		public static const STANDARD_ERROR_IO_ERROR : String = "standardErrorIoError";
		public static const STANDARD_INPUT_IO_ERROR : String = "standardInputIoError";
		public static const STANDARD_OUTPUT_IO_ERROR : String = "standardOutputIoError";
		public static const VERIFY_ERROR : String = "verifyError";

		/// Creates a copy of the IOErrorEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Constructor for IOErrorEvent objects.
		public function IOErrorEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);

		/// Returns a string that contains all the properties of the IOErrorEvent object.
		public function toString () : String;
	}
}
