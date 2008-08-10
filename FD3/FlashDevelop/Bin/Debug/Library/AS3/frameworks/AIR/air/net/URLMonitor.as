/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package air.net {
	import flash.net.URLRequest;
	public class URLMonitor extends ServiceMonitor {
		/**
		 * The numeric status codes representing a successful result.
		 */
		public function get acceptableStatusCodes():Array;
		public function set acceptableStatusCodes(value:Array):void;
		/**
		 * The URLRequest object representing the probe request.
		 */
		public function get urlRequest():URLRequest;
		/**
		 * Creates a URLMonitor Object for a specified HTTP- or HTTPS-based service.
		 *
		 * @param urlRequest        <URLRequest> The URLRequest object representing a probe request for polling the server.
		 * @param acceptableStatusCodes<Array (default = null)> An array of numeric status codes listing the codes that represent a successful result.
		 *                            If you do not specify a value for the acceptableStatusCodes property, the following status
		 *                            codes will be recognized as successful responses:
		 *                            200 (OK)
		 *                            202 (Accepted)
		 *                            204 (No content
		 *                            205 (Reset content)
		 *                            206 (Partial content, in response to request with a Range header)
		 */
		public function URLMonitor(urlRequest:URLRequest, acceptableStatusCodes:Array = null);
		/**
		 * Attempts to load content from a URL in the background, to check for a
		 *  returned HTTP status code.
		 */
		protected override function checkStatus():void;
		/**
		 * Returns the string representation of the specified object.
		 *
		 * @return                  <String> A string representation of the object.
		 */
		public override function toString():String;
	}
}
