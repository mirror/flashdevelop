/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class HTTPRequestMessage extends AbstractMessage {
		/**
		 * Indicates the content type of this message.
		 *  This value must be understood by the destination this request is sent to.
		 */
		public var contentType:String;
		/**
		 * Contains specific HTTP headers that should be placed on the request made
		 *  to the destination.
		 */
		public var httpHeaders:Object;
		/**
		 * Indicates what method should be used for the request.
		 *  The only values allowed are:
		 *  HTTPRequestMessage.DELETE_METHOD
		 *  HTTPRequestMessage.GET_METHOD
		 *  HTTPRequestMessage.HEAD_METHOD
		 *  HTTPRequestMessage.POST_METHOD
		 *  HTTPRequestMessage.OPTIONS_METHOD
		 *  HTTPRequestMessage.PUT_METHOD
		 *  HTTPRequestMessage.TRACE_METHOD
		 */
		public function get method():String;
		public function set method(value:String):void;
		/**
		 * Only used when going through the proxy, should the proxy
		 *  send back the request and response headers it used.  Defaults to false.
		 *  Currently only set when using the NetworkMonitor.
		 */
		public var recordHeaders:Boolean;
		/**
		 * Contains the final destination for this request.
		 *  This is the URL that the content of this message, found in the
		 *  body property, will be sent to, using the method specified.
		 */
		public var url:String;
		/**
		 * Constructs an uninitialized HTTP request.
		 */
		public function HTTPRequestMessage();
		/**
		 * Indicates that the content of this message is a form.
		 */
		public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
		/**
		 * Indicates that the content of this message is XML meant for a SOAP
		 *  request.
		 */
		public static const CONTENT_TYPE_SOAP_XML:String = "text/xml; charset=utf-8";
		/**
		 * Indicates that the content of this message is XML.
		 */
		public static const CONTENT_TYPE_XML:String = "application/xml";
		/**
		 * Indicates that the method used for this request should be "delete".
		 */
		public static const DELETE_METHOD:String = "DELETE";
		/**
		 * Indicates that the method used for this request should be "get".
		 */
		public static const GET_METHOD:String = "GET";
		/**
		 * Indicates that the method used for this request should be "head".
		 */
		public static const HEAD_METHOD:String = "HEAD";
		/**
		 * Indicates that the method used for this request should be "options".
		 */
		public static const OPTIONS_METHOD:String = "OPTIONS";
		/**
		 * Indicates that the method used for this request should be "post".
		 */
		public static const POST_METHOD:String = "POST";
		/**
		 * Indicates that the method used for this request should be "put".
		 */
		public static const PUT_METHOD:String = "PUT";
		/**
		 * Indicates that the method used for this request should be "trace".
		 */
		public static const TRACE_METHOD:String = "TRACE";
	}
}
