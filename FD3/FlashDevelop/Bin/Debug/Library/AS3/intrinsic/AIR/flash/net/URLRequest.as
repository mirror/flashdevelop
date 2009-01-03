package flash.net
{
	/// The URLRequest class captures all of the information in a single HTTP request.
	public class URLRequest extends Object
	{
		/// [AIR] Specifies whether authentication requests should be handled (true or not (false) for this request.
		public function get authenticate () : Boolean;
		public function set authenticate (value:Boolean) : void;

		/// [AIR] Specifies whether successful response data should be cached for this request.
		public function get cacheResponse () : Boolean;
		public function set cacheResponse (value:Boolean) : void;

		/// The MIME content type of the content in the the data property.
		public function get contentType () : String;
		public function set contentType (value:String) : void;

		/// An object containing data to be transmitted with the URL request.
		public function get data () : Object;
		public function set data (value:Object) : void;

		/// A string that uniquely identifies the signed Adobe platform component to be stored to (or retrieved from) the Flash Player cache.
		public function get digest () : String;
		public function set digest (value:String) : void;

		/// [AIR] Specifies whether redirects are to be followed (true) or not (false).
		public function get followRedirects () : Boolean;
		public function set followRedirects (value:Boolean) : void;

		/// [AIR] Specifies whether the HTTP protocol stack should manage cookies for this request.
		public function get manageCookies () : Boolean;
		public function set manageCookies (value:Boolean) : void;

		/// Controls the HTTP form submission method.
		public function get method () : String;
		public function set method (value:String) : void;

		/// The array of HTTP request headers to be appended to the HTTP request.
		public function get requestHeaders () : Array;
		public function set requestHeaders (value:Array) : void;

		/// The URL to be requested.
		public function get url () : String;
		public function set url (value:String) : void;

		/// [AIR] Specifies whether the local cache should be consulted before this URLRequest fetches data.
		public function get useCache () : Boolean;
		public function set useCache (value:Boolean) : void;

		/// [AIR] Specifies the user-agent string to be used in the HTTP request.
		public function get userAgent () : String;
		public function set userAgent (value:String) : void;
	}
}
