package flash.events
{
	import flash.events.Event;

	/// The application dispatches HTTPStatusEvent objects when a network request returns an HTTPstatus code.
	public class HTTPStatusEvent extends Event
	{
		/// [AIR] Unlike the httpStatus event, the httpResponseStatus event is delivered before any response data.
		public static const HTTP_RESPONSE_STATUS : String = "httpResponseStatus";
		/// The HTTPStatusEvent.HTTP_STATUS constant defines the value of the type property of a httpStatus event object.
		public static const HTTP_STATUS : String = "httpStatus";

		/// [AIR] The response headers that the response returned, as an array of URLRequestHeader objects.
		public function get responseHeaders () : Array;
		public function set responseHeaders (value:Array) : void;

		/// [AIR] The URL that the response was returned from.
		public function get responseURL () : String;
		public function set responseURL (value:String) : void;

		/// The HTTP status code returned by the server.
		public function get status () : int;

		/// Creates a copy of the HTTPStatusEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Returns a string that contains all the properties of the HTTPStatusEvent object.
		public function toString () : String;
	}
}
