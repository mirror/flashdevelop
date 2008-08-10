/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.channels {
	public class SecureStreamingHTTPChannel extends StreamingHTTPChannel {
		/**
		 * Returns the protocol for this channel (https).
		 */
		public function get protocol():String;
		/**
		 * Creates an new SecureStreamingHTTPChannel instance.
		 *
		 * @param id                <String (default = null)> The id of this Channel.
		 * @param uri               <String (default = null)> The uri for this Channel.
		 */
		public function SecureStreamingHTTPChannel(id:String = null, uri:String = null);
	}
}
