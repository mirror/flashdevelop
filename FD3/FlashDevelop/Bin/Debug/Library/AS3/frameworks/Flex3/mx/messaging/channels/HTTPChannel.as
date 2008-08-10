/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.channels {
	import mx.messaging.messages.AsyncMessage;
	public class HTTPChannel extends PollingChannel {
		/**
		 * Indicates whether this channel will piggyback poll requests along
		 *  with regular outbound messages when an outstanding poll is not in
		 *  progress. This allows the server to piggyback data for the client
		 *  along with its response to client's message.
		 */
		public function get piggybackingEnabled():Boolean;
		public function set piggybackingEnabled(value:Boolean):void;
		/**
		 * Reports whether the channel is actively polling.
		 */
		public function get polling():Boolean;
		/**
		 * Indicates whether this channel is enabled to poll.
		 */
		public function get pollingEnabled():Boolean;
		public function set pollingEnabled(value:Boolean):void;
		/**
		 * Provides access to the polling interval for this Channel.
		 *  The value is in milliseconds.
		 *  This value determines how often this Channel requests messages from
		 *  the server, to approximate server push.
		 */
		public function get pollingInterval():Number;
		public function set pollingInterval(value:Number):void;
		/**
		 * Returns the protocol for this channel (http).
		 */
		public function get protocol():String;
		/**
		 * Creates an new HTTPChannel instance.
		 *
		 * @param id                <String (default = null)> The id of this Channel.
		 * @param uri               <String (default = null)> The uri for this Channel.
		 */
		public function HTTPChannel(id:String = null, uri:String = null);
		/**
		 * @param msg               <AsyncMessage> 
		 */
		protected function internalPingComplete(msg:AsyncMessage):void;
	}
}
