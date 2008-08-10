/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class URLUtil {
		/**
		 * Converts a potentially relative URL to a fully-qualified URL.
		 *  If the URL is not relative, it is returned as is.
		 *  If the URL starts with a slash, the host and port
		 *  from the root URL are prepended.
		 *  Otherwise, the host, port, and path are prepended.
		 *
		 * @param rootURL           <String> URL used to resolve the URL specified by the url parameter, if url is relative.
		 * @param url               <String> URL to convert.
		 * @return                  <String> Fully-qualified URL.
		 */
		public static function getFullURL(rootURL:String, url:String):String;
		/**
		 * Returns the port number from the specified URL.
		 *
		 * @param url               <String> The URL to analyze.
		 * @return                  <uint> The port number of the specified URL.
		 */
		public static function getPort(url:String):uint;
		/**
		 * Returns the protocol section of the specified URL.
		 *
		 * @param url               <String> String containing the URL to parse.
		 * @return                  <String> The protocol or an empty String if no protocol is specified.
		 */
		public static function getProtocol(url:String):String;
		/**
		 * Returns the server name from the specified URL.
		 *
		 * @param url               <String> The URL to analyze.
		 * @return                  <String> The server name of the specified URL.
		 */
		public static function getServerName(url:String):String;
		/**
		 * Returns the domain and port information from the specified URL.
		 *
		 * @param url               <String> The URL to analyze.
		 * @return                  <String> The server name and port of the specified URL.
		 */
		public static function getServerNameWithPort(url:String):String;
		/**
		 * If the LoaderConfig.url property is not available, the replaceTokens() method will not
		 *  replace the server name and port properties properly.
		 *
		 * @return                  <Boolean> true if the LoaderConfig.url property is not available. Otherwise, false.
		 */
		public static function hasUnresolvableTokens():Boolean;
		/**
		 * Determines if the URL uses the secure HTTPS protocol.
		 *
		 * @param url               <String> The URL to analyze.
		 * @return                  <Boolean> true if the URL starts with "https://".
		 */
		public static function isHttpsURL(url:String):Boolean;
		/**
		 * Determines if the URL uses the HTTP, HTTPS, or RTMP protocol.
		 *
		 * @param url               <String> The URL to analyze.
		 * @return                  <Boolean> true if the URL starts with "http://", "https://", or "rtmp://".
		 */
		public static function isHttpURL(url:String):Boolean;
		/**
		 * Enumerates an object's dynamic properties (by using a for..in loop)
		 *  and returns a String. You typically use this method to convert an ActionScript object to a String that you then append to the end of a URL.
		 *  By default, invalid URL characters are URL-encoded (converted to the %XX format).
		 *
		 * @param object            <Object> The object to convert to a String.
		 * @param separator         <String (default = "")> The character that separates each of the object's property:value pair in the String.
		 * @param encodeURL         <Boolean> Whether or not to URL-encode the String.
		 * @return                  <String> The object that was passed to the method.
		 */
		public static function objectToString(object:Object, separator:String = "", encodeURL:Boolean):String;
		/**
		 * Returns a new String with the port replaced with the specified port.
		 *  If there is no port in the specified URI, the port is inserted.
		 *  This method expects that a protocol has been specified within the URI.
		 *
		 * @param uri               <String> String containing the URI in which the port is replaced.
		 * @param newPort           <uint> uint containing the new port to subsitute.
		 * @return                  <String> The URI with the new port.
		 */
		public static function replacePort(uri:String, newPort:uint):String;
		/**
		 * Replaces the protocol of the
		 *  specified URI with the given protocol.
		 *
		 * @param uri               <String> String containing the URI in which the protocol
		 *                            needs to be replaced.
		 * @param newProtocol       <String> String containing the new protocol to use.
		 * @return                  <String> The URI with the protocol replaced,
		 *                            or an empty String if the URI does not contain a protocol.
		 */
		public static function replaceProtocol(uri:String, newProtocol:String):String;
		/**
		 * Returns a new String with the port and server tokens replaced with
		 *  the port and server from the currently running application.
		 *
		 * @param url               <String> String containing the SERVER_NAME_TOKEN and/or SERVER_NAME_PORT
		 *                            which should be replaced by the port and server from the application.
		 * @return                  <String> The URI with the port and server replaced.
		 */
		public static function replaceTokens(url:String):String;
		/**
		 * Returns an object from a String. The String contains name=value pairs, which become dynamic properties
		 *  of the returned object. These property pairs are separated by the specified separator.
		 *  This method converts Numbers and Booleans, Arrays (defined by "[]"),
		 *  and sub-objects (defined by "{}"). By default, URL patterns of the format %XX are converted
		 *  to the appropriate String character.
		 *
		 * @param string            <String> The String to convert to an object.
		 * @param separator         <String (default = "")> The character that separates name=value pairs in the String.
		 * @param decodeURL         <Boolean> Whether or not to decode URL-encoded characters in the String.
		 * @return                  <Object> The object containing properties and values extracted from the String passed to this method.
		 */
		public static function stringToObject(string:String, separator:String = "", decodeURL:Boolean):Object;
		/**
		 * Tests whether two URI Strings are equivalent, ignoring case and
		 *  differences in trailing slashes.
		 *
		 * @param uri1              <String> The first URI to compare.
		 * @param uri2              <String> The second URI to compare.
		 * @return                  <Boolean> true if the URIs are equal. Otherwise, false.
		 */
		public static function urisEqual(uri1:String, uri2:String):Boolean;
		/**
		 * The pattern in the String that is passed to the replaceTokens() method that
		 *  is replaced by the application's server name.
		 */
		public static const SERVER_NAME_TOKEN:String = "{server.name}";
		/**
		 * The pattern in the String that is passed to the replaceTokens() method that
		 *  is replaced by the application's port.
		 */
		public static const SERVER_PORT_TOKEN:String = "{server.port}";
	}
}
