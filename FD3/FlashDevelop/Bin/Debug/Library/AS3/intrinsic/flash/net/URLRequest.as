/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public final  class URLRequest {
		/**
		 * The MIME content type of the content in the the data property.
		 */
		public function get contentType():String;
		public function set contentType(value:String):void;
		/**
		 * An object containing data to be transmitted with the URL request.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * A string that uniquely identifies the signed Adobe platform component to be stored
		 *  to (or retrieved from) the Flash Player cache. A digest
		 *  corresponds to a single cached file; if you change the file in any way, its digest
		 *  will change in an unpredictable way. By using a digest, you can verify the cached file across
		 *  multiple domains. Two files with the same digest are the same file, and two files with different
		 *  digests are not the same file. A file cannot (practically) be created to "spoof" a digest and
		 *  pretend to be another digest.This property applies to
		 *  SWF content only; it does not apply to JavaScript code running in AIR.
		 */
		public function get digest():String;
		public function set digest(value:String):void;
		/**
		 * Controls the HTTP form submission method.
		 */
		public function get method():String;
		public function set method(value:String):void;
		/**
		 * The array of HTTP request headers to be appended to the
		 *  HTTP request. The array is composed of URLRequestHeader objects.
		 */
		public function get requestHeaders():Array;
		public function set requestHeaders(value:Array):void;
		/**
		 * The URL to be requested.
		 */
		public function get url():String;
		public function set url(value:String):void;
		/**
		 * Creates a URLRequest object.
		 *  If System.useCodePage is true, the request is encoded using the
		 *  system code page, rather than Unicode.
		 *  If System.useCodePage is false, the request is encoded using Unicode, rather than the
		 *  system code page.
		 *
		 * @param url               <String (default = null)> The URL to be requested. You can set the URL later by using the url property.
		 */
		public function URLRequest(url:String = null);
	}
}
