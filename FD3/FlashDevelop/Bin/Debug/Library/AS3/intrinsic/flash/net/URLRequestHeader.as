/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public final  class URLRequestHeader {
		/**
		 * An HTTP request header name (such as Content-Type or SOAPAction).
		 */
		public var name:String;
		/**
		 * The value associated with the name property (such as text/plain).
		 */
		public var value:String;
		/**
		 * Creates a new URLRequestHeader object that encapsulates a single HTTP request header.
		 *  URLRequestHeader objects are used in the requestHeaders
		 *  property of the URLRequest class.
		 *
		 * @param name              <String (default = "")> An HTTP request header name (such as Content-Type
		 *                            or SOAPAction).
		 * @param value             <String (default = "")> The value associated with the name property
		 *                            (such as text/plain).
		 */
		public function URLRequestHeader(name:String = "", value:String = "");
	}
}
