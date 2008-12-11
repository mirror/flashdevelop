package flash.net
{
	/// The URLRequestDefaults class includes static properties that you can set to define default values for the properties of the URLRequest class.
	public class URLRequestDefaults
	{
		/// [AIR] The default setting for the followRedirects property of URLRequest objects.
		public var followRedirects:Boolean;

		/// [AIR] The default setting for the manageCookies property of URLRequest objects.
		public var manageCookies:Boolean;

		/// [AIR] The default setting for the authenticate property of URLRequest objects.
		public var authenticate:Boolean;

		/// [AIR] The default setting for the useCache property of URLRequest objects.
		public var useCache:Boolean;

		/// [AIR] The default setting for the cacheResponse property of URLRequest objects.
		public var cacheResponse:Boolean;

		/// [AIR] The default setting for the userAgent property of URLRequest objects.
		public var userAgent:String;

		/// [AIR] Sets default user and password credentials for a selected host.
		public static function setLoginCredentialsForHost(hostname:String, user:String, password:String):void;

	}

}

