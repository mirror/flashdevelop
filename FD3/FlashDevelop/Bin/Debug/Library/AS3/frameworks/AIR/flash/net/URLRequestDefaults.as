/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.net {
	public class URLRequestDefaults {
		/**
		 * The default setting for the authenticate property of URLRequest objects.
		 *  Setting the authenticate property in a URLRequest object overrides this default setting.
		 */
		public static function get authenticate():Boolean;
		public function set authenticate(value:Boolean):void;
		/**
		 * The default setting for the cacheResponse property of URLRequest objects.
		 *  Setting the cacheResponse property in a URLRequest object overrides this default setting.
		 *  When set to true, the default behavior for the AIR application is to use the operating system's
		 *  HTTP cache. This setting does not apply to URLRequest objects used in file upload or RTMP requests.
		 */
		public static function get cacheResponse():Boolean;
		public function set cacheResponse(value:Boolean):void;
		/**
		 * The default setting for the followRedirects property of URLRequest objects.
		 *  Setting the followRedirects property in a URLRequest object overrides this default setting.
		 *  This setting does not apply to URLRequest objects used in file upload or RTMP requests.
		 */
		public static function get followRedirects():Boolean;
		public function set followRedirects(value:Boolean):void;
		/**
		 * The default setting for the manageCookies property of URLRequest objects.
		 *  Setting the manageCookies property in a URLRequest object overrides this default setting.
		 */
		public static function get manageCookies():Boolean;
		public function set manageCookies(value:Boolean):void;
		/**
		 * The default setting for the useCache property of URLRequest objects.
		 *  Setting the useCache property in a URLRequest object overrides this default setting.
		 *  This setting does not apply to URLRequest objects used in file upload or RTMP requests.
		 */
		public static function get useCache():Boolean;
		public function set useCache(value:Boolean):void;
		/**
		 * The default setting for the userAgent property of URLRequest objects.
		 *  Setting the userAgent property in a URLRequest object overrides this
		 *  default setting.
		 */
		public static function get userAgent():String;
		public function set userAgent(value:String):void;
		/**
		 * Sets default user and password credentials for a selected host. These settings
		 *  apply for URLRequest objects in all application domains of the application,
		 *  not only those in the application domain of the object calling this method
		 *  (whereas the static properties of the URLRequest class apply to the caller's
		 *  application domain only). This allows content in the entire application
		 *  (regardless of the content's application domain) to be logged in when another
		 *  part of the application logs in.
		 *
		 * @param hostname          <String> The host name to which the user name and password are applied. This
		 *                            can be a domain, such as "www.example.com" or a domain and a port number,
		 *                            such as "www.example.com:80". Note that "example.com",
		 *                            "www.example.com", and "sales.example.com" are each considered
		 *                            unique hosts.
		 * @param user              <String> The default user name to use in request authentication for the specified host.
		 * @param password          <String> The default password to use in request authentication for the specified host.
		 */
		public static function setLoginCredentialsForHost(hostname:String, user:String, password:String):*;
	}
}
