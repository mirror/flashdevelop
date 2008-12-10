package mx.utils
{
	import mx.messaging.config.LoaderConfig;

	/**
	 *  The URLUtil class is a static class with methods for working with *  full and relative URLs within Flex. *   *  @see mx.managers.BrowserManager
	 */
	public class URLUtil
	{
		/**
		 *  The pattern in the String that is passed to the <code>replaceTokens()</code> method that      *  is replaced by the application's server name.
		 */
		public static const SERVER_NAME_TOKEN : String = "{server.name}";
		/**
		 *  The pattern in the String that is passed to the <code>replaceTokens()</code> method that      *  is replaced by the application's port.
		 */
		public static const SERVER_PORT_TOKEN : String = "{server.port}";
		private static const SERVER_NAME_REGEX : RegExp = new RegExp("{server.name}", "g");
		private static const SERVER_PORT_REGEX : RegExp = new RegExp("{server.port}", "g");

		/**
		 *  @private
		 */
		public function URLUtil ();
		/**
		 *  Returns the domain and port information from the specified URL.     *       *  @param url The URL to analyze.     *  @return The server name and port of the specified URL.
		 */
		public static function getServerNameWithPort (url:String) : String;
		/**
		 *  Returns the server name from the specified URL.     *       *  @param url The URL to analyze.     *  @return The server name of the specified URL.
		 */
		public static function getServerName (url:String) : String;
		/**
		 *  Returns the port number from the specified URL.     *       *  @param url The URL to analyze.     *  @return The port number of the specified URL.
		 */
		public static function getPort (url:String) : uint;
		/**
		 *  Converts a potentially relative URL to a fully-qualified URL.     *  If the URL is not relative, it is returned as is.     *  If the URL starts with a slash, the host and port     *  from the root URL are prepended.     *  Otherwise, the host, port, and path are prepended.     *     *  @param rootURL URL used to resolve the URL specified by the <code>url</code> parameter, if <code>url</code> is relative.     *  @param url URL to convert.     *     *  @return Fully-qualified URL.
		 */
		public static function getFullURL (rootURL:String, url:String) : String;
		/**
		 *  Determines if the URL uses the HTTP, HTTPS, or RTMP protocol.      *     *  @param url The URL to analyze.     *      *  @return <code>true</code> if the URL starts with "http://", "https://", or "rtmp://".
		 */
		public static function isHttpURL (url:String) : Boolean;
		/**
		 *  Determines if the URL uses the secure HTTPS protocol.      *     *  @param url The URL to analyze.     *      *  @return <code>true</code> if the URL starts with "https://".
		 */
		public static function isHttpsURL (url:String) : Boolean;
		/**
		 *  Returns the protocol section of the specified URL.     *  The following examples show what is returned based on different URLs:     *       *  <pre>     *  getProtocol("https://localhost:2700/") returns "https"     *  getProtocol("rtmp://www.myCompany.com/myMainDirectory/groupChatApp/HelpDesk") returns "rtmp"     *  getProtocol("rtmpt:/sharedWhiteboardApp/June2002") returns "rtmpt"     *  getProtocol("rtmp::1234/chatApp/room_name") returns "rtmp"     *  </pre>     *     *  @param url String containing the URL to parse.     *     *  @return The protocol or an empty String if no protocol is specified.
		 */
		public static function getProtocol (url:String) : String;
		/**
		 *  Replaces the protocol of the     *  specified URI with the given protocol.     *     *  @param uri String containing the URI in which the protocol     *  needs to be replaced.     *     *  @param newProtocol String containing the new protocol to use.     *     *  @return The URI with the protocol replaced,     *  or an empty String if the URI does not contain a protocol.
		 */
		public static function replaceProtocol (uri:String, newProtocol:String) : String;
		/**
		 *  Returns a new String with the port replaced with the specified port.     *  If there is no port in the specified URI, the port is inserted.     *  This method expects that a protocol has been specified within the URI.     *     *  @param uri String containing the URI in which the port is replaced.     *  @param newPort uint containing the new port to subsitute.     *     *  @return The URI with the new port.
		 */
		public static function replacePort (uri:String, newPort:uint) : String;
		/**
		 *  Returns a new String with the port and server tokens replaced with     *  the port and server from the currently running application.     *     *  @param url String containing the <code>SERVER_NAME_TOKEN</code> and/or <code>SERVER_NAME_PORT</code>     *  which should be replaced by the port and server from the application.     *     *  @return The URI with the port and server replaced.
		 */
		public static function replaceTokens (url:String) : String;
		/**
		 * Tests whether two URI Strings are equivalent, ignoring case and     * differences in trailing slashes.     *      *  @param uri1 The first URI to compare.     *  @param uri2 The second URI to compare.     *       *  @return <code>true</code> if the URIs are equal. Otherwise, <code>false</code>.
		 */
		public static function urisEqual (uri1:String, uri2:String) : Boolean;
		/**
		 * If the <code>LoaderConfig.url</code> property is not available, the <code>replaceTokens()</code> method will not      * replace the server name and port properties properly.     *      * @return <code>true</code> if the <code>LoaderConfig.url</code> property is not available. Otherwise, <code>false</code>.
		 */
		public static function hasUnresolvableTokens () : Boolean;
		/**
		 *  Enumerates an object's dynamic properties (by using a <code>for..in</code> loop)     *  and returns a String. You typically use this method to convert an ActionScript object to a String that you then append to the end of a URL.     *  By default, invalid URL characters are URL-encoded (converted to the <code>%XX</code> format).     *     *  <p>For example:     *  <pre>     *  var o:Object = { name: "Alex", age: 21 };     *  var s:String = URLUtil.objectToString(o,";",true);     *  trace(s);     *  </pre>     *  Prints "name=Alex;age=21" to the trace log.     *  </p>     *       *  @param object The object to convert to a String.     *  @param separator The character that separates each of the object's <code>property:value</code> pair in the String.     *  @param encodeURL Whether or not to URL-encode the String.     *       *  @return The object that was passed to the method.
		 */
		public static function objectToString (object:Object, separator:String = ';', encodeURL:Boolean = true) : String;
		private static function internalObjectToString (object:Object, separator:String, prefix:String, encodeURL:Boolean) : String;
		private static function internalArrayToString (array:Array, separator:String, prefix:String, encodeURL:Boolean) : String;
		/**
		 *  Returns an object from a String. The String contains <code>name=value</code> pairs, which become dynamic properties     *  of the returned object. These property pairs are separated by the specified <code>separator</code>.     *  This method converts Numbers and Booleans, Arrays (defined by "[]"),      *  and sub-objects (defined by "{}"). By default, URL patterns of the format <code>%XX</code> are converted     *  to the appropriate String character.     *     *  <p>For example:     *  <pre>     *  var s:String = "name=Alex;age=21";     *  var o:Object = URLUtil.stringToObject(s, ";", true);     *  </pre>     *       *  Returns the object: <code>{ name: "Alex", age: 21 }</code>.     *  </p>     *       *  @param string The String to convert to an object.     *  @param separator The character that separates <code>name=value</code> pairs in the String.     *  @param decodeURL Whether or not to decode URL-encoded characters in the String.     *      *  @return The object containing properties and values extracted from the String passed to this method.
		 */
		public static function stringToObject (string:String, separator:String = ";", decodeURL:Boolean = true) : Object;
	}
}
