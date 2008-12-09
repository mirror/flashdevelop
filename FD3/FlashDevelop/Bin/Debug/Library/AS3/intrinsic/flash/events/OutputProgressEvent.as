package flash.events
{
	/// A FileStream object dispatches OutputProgressEvent objects as pending asynchronous file write operations are performed.
	public class OutputProgressEvent extends flash.events.Event
	{
		/// [AIR] Defines the value of the type property of an outputProgress event object.
		public static const OUTPUT_PROGRESS:String = "outputProgress";

		/// [AIR] The number of bytes not yet written when the listener processes the event.
		public var bytesPending:Number;

		/// [AIR] The total number of bytes written so far, plus the number of pending bytes to be written.
		public var bytesTotal:Number;

		/// [AIR] Constructor for OutputProgressEvent objects.
		public function OutputProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesPending:Number=0, bytesTotal:Number=0);

		/// [AIR] Creates a copy of the OutputProgressEvent object and sets each property's value to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the OutputProgressEvent object.
		public function toString():String;

	}

}

