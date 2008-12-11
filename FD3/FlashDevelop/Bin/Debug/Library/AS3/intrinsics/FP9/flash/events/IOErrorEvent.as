package flash.events
{
	/// Flash&#xAE; Player dispatches an IOErrorEvent object when an error causes a send or load operation to fail.
	public class IOErrorEvent extends flash.events.ErrorEvent
	{
		/// Defines the value of the type property of an ioError event object.
		public static const IO_ERROR:String = "ioError";

		/// Constructor for IOErrorEvent objects.
		public function IOErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, text:String);

		/// Creates a copy of the IOErrorEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the IOErrorEvent object.
		public function toString():String;

	}

}

