/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class URLLoader extends EventDispatcher {
		/**
		 * Indicates the number of bytes that have been loaded thus far
		 *  during the load operation.
		 */
		public var bytesLoaded:uint = 0;
		/**
		 * Indicates the total number of bytes in the downloaded data.
		 *  This property contains 0 while the load operation is in progress
		 *  and is populated when the operation is complete.
		 *  Also, a missing Content-Length header will result in bytesTotal being indeterminate.
		 */
		public var bytesTotal:uint = 0;
		/**
		 * The data received from the load operation. This property
		 *  is populated only when the load operation is complete.
		 */
		public var data:*;
		/**
		 * Controls whether the downloaded data is received as
		 *  text (URLLoaderDataFormat.TEXT), raw binary data
		 *  (URLLoaderDataFormat.BINARY), or URL-encoded variables
		 *  (URLLoaderDataFormat.VARIABLES).
		 */
		public var dataFormat:String = "text";
		/**
		 * Creates a URLLoader object.
		 *
		 * @param request           <URLRequest (default = null)> A URLRequest object specifying
		 *                            the URL to download.  If this parameter is omitted,
		 *                            no load operation begins.  If
		 *                            specified, the load operation begins
		 *                            immediately (see the load entry for more information).
		 */
		public function URLLoader(request:URLRequest = null);
		/**
		 * Closes the load operation in progress.  Any load
		 *  operation in progress is immediately terminated.
		 *  If no URL is currently being streamed, an invalid stream error is thrown.
		 */
		public function close():void;
		/**
		 * Sends and loads data from the specified URL. The data can be received as
		 *  text, raw binary data, or URL-encoded variables, depending on the
		 *  value you set for the dataFormat property. Note that
		 *  the default value of the dataFormat property is text.
		 *  If you want to send data to the specified URL, you can set the data
		 *  property in the URLRequest object.
		 *
		 * @param request           <URLRequest> A URLRequest object specifying the URL to download.
		 */
		public function load(request:URLRequest):void;
	}
}
