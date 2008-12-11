package flash.net
{
	/// The URLRequest class captures all of the information in a single HTTP request.
	public class URLRequest
	{
		/// The URL to be requested.
		public var url:String;

		/// An object containing data to be transmitted with the URL request.
		public var data:Object;

		/// Controls the HTTP form submission method.
		public var method:String;

		/// The MIME content type of the content in the the data property.
		public var contentType:String;

		/// The array of HTTP request headers to be appended to the HTTP request.
		public var requestHeaders:Array;

		/// A string that uniquely identifies the signed Adobe platform component to be stored to (or retrieved from) the Flash Player cache.
		public var digest:String;

		/// Creates a URLRequest object.
		public function URLRequest(url:String=null);

	}

}

