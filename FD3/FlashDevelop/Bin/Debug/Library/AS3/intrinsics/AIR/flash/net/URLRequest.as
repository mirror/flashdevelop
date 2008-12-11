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

		/// [AIR] Specifies whether redirects are to be followed (true) or not (false).
		public var followRedirects:Boolean;

		/// [AIR] Specifies the user-agent string to be used in the HTTP request.
		public var userAgent:String;

		/// [AIR] Specifies whether the HTTP protocol stack should manage cookies for this request.
		public var manageCookies:Boolean;

		/// [AIR] Specifies whether the local cache should be consulted before this URLRequest fetches data.
		public var useCache:Boolean;

		/// [AIR] Specifies whether successful response data should be cached for this request.
		public var cacheResponse:Boolean;

		/// [AIR] Specifies whether authentication requests should be handled (true or not (false) for this request.
		public var authenticate:Boolean;

		/// Creates a URLRequest object.
		public function URLRequest(url:String=null);

	}

}

