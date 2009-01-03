package flash.net
{
	/// The URLRequestDefaults class includes static properties that you can set to define default values for the properties of the URLRequest class.
	public class URLRequestDefaults extends Object
	{
		/// [AIR] The default setting for the authenticate property of URLRequest objects.
		public static function get authenticate () : Boolean;
		public static function set authenticate (value:Boolean) : void;

		/// [AIR] The default setting for the cacheResponse property of URLRequest objects.
		public static function get cacheResponse () : Boolean;
		public static function set cacheResponse (value:Boolean) : void;

		/// [AIR] The default setting for the followRedirects property of URLRequest objects.
		public static function get followRedirects () : Boolean;
		public static function set followRedirects (value:Boolean) : void;

		/// [AIR] The default setting for the manageCookies property of URLRequest objects.
		public static function get manageCookies () : Boolean;
		public static function set manageCookies (value:Boolean) : void;

		/// [AIR] The default setting for the useCache property of URLRequest objects.
		public static function get useCache () : Boolean;
		public static function set useCache (value:Boolean) : void;

		/// [AIR] The default setting for the userAgent property of URLRequest objects.
		public static function get userAgent () : String;
		public static function set userAgent (value:String) : void;

		/// [AIR] Sets default user and password credentials for a selected host.
		public static function setLoginCredentialsForHost (hostname:String, user:String, password:String) : *;
	}
}
