/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.channels {
	public class StreamingHTTPChannel extends HTTPChannel {
		/**
		 * Creates an new StreamingHTTPChannel instance.
		 *
		 * @param id                <String (default = null)> The id of this Channel.
		 * @param uri               <String (default = null)> The uri for this Channel.
		 */
		public function StreamingHTTPChannel(id:String = null, uri:String = null);
		/**
		 * Polling is not supported by this channel.
		 */
		public override function poll():void;
	}
}
