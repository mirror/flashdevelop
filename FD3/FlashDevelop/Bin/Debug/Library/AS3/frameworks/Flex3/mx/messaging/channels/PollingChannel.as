/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.channels {
	import mx.messaging.Channel;
	import mx.messaging.MessageAgent;
	import mx.messaging.messages.IMessage;
	public class PollingChannel extends Channel {
		/**
		 * Creates a new PollingChannel instance with the specified id. Once a PollingChannel is
		 *  connected and begins polling, it will issue a poll request once every three seconds
		 *  by default.
		 *  Note: The PollingChannel type should not be constructed directly. Instead
		 *  create instances of protocol specific subclasses such as HTTPChannel or
		 *  AMFChannel that extend it.
		 *
		 * @param id                <String (default = null)> The id of this Channel.
		 * @param uri               <String (default = null)> The uri for this Channel.
		 */
		public function PollingChannel(id:String = null, uri:String = null);
		/**
		 * Disables polling based on the number of times enablePolling()
		 *  and disablePolling() have been invoked. If the net result is to disable
		 *  polling the channel stops polling.
		 */
		public function disablePolling():void;
		/**
		 * Enables polling based on the number of times enablePolling()
		 *  and disablePolling() have been invoked. If the net result is to enable
		 *  polling the channel will poll the server on behalf of connected MessageAgents.
		 */
		public function enablePolling():void;
		/**
		 * Initiates a poll operation if there are consumers subscribed to this channel,
		 *  and polling is enabled for this channel.
		 *  Note that this method will not start a new poll if one is currently in progress.
		 */
		public function poll():void;
		/**
		 * Sends the specified message to its target destination.
		 *  Subclasses must override the internalSend() method to
		 *  perform the actual send.
		 *  PollingChannel will wrap outbound messages in poll requests if a poll
		 *  is not currently outstanding.
		 *
		 * @param agent             <MessageAgent> The MessageAgent that is sending the message.
		 * @param message           <IMessage> The Message to send.
		 */
		public override function send(agent:MessageAgent, message:IMessage):void;
	}
}
