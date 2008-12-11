package flash.events
{
	/// The application dispatches HTTPStatusEvent objects when a network request returns an HTTPstatus code.
	public class HTTPStatusEvent extends flash.events.Event
	{
		/// The HTTPStatusEvent.HTTP_STATUS constant defines the value of the type property of a httpStatus event object.
		public static const HTTP_STATUS:String = "httpStatus";

		/// [AIR] Unlike the httpStatus event, the httpResponseStatus event is delivered before any response data.
		public static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus";

		/// The HTTP status code returned by the server.
		public var status:int;

		/// [AIR] The URL that the response was returned from.
		public var responseURL:String;

		/// [AIR] The response headers that the response returned, as an array of URLRequestHeader objects.
		public var responseHeaders:Array;

		/// Constructor for HTTPStatusEvent objects.
		public function HTTPStatusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, status:int=0);

		/// Creates a copy of the HTTPStatusEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the HTTPStatusEvent object.
		public function toString():String;

	}

}

