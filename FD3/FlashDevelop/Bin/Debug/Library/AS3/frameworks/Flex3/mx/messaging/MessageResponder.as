/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import flash.net.Responder;
	import mx.messaging.messages.IMessage;
	public class MessageResponder extends Responder {
		/**
		 * Provides access to the MessageAgent that sent the message.
		 */
		public function get agent():MessageAgent;
		/**
		 * Provides access to the Channel used to send the message.
		 */
		public function get channel():Channel;
		/**
		 * Provides access to the sent Message.
		 */
		public function get message():IMessage;
		public function set message(value:IMessage):void;
		/**
		 * Constructs a MessageResponder to handle the response for the specified
		 *  Message for the specified MessageAgent.
		 *
		 * @param agent             <MessageAgent> agent The MessageAgent sending the Message.
		 * @param message           <IMessage> message The Message being sent.
		 * @param channel           <Channel (default = null)> The Channel used to send.
		 */
		public function MessageResponder(agent:MessageAgent, message:IMessage, channel:Channel = null);
		/**
		 * Constructs an ErrorMessage that can be passed to the associated
		 *  MessageAgent's callbacks upon a request timeout.
		 */
		protected function createRequestTimeoutErrorMessage():ErrorMessage;
		/**
		 * Subclasses must override this method to handle a request timeout and
		 *  invoke the proper callbacks on the associated MessageAgent.
		 */
		protected function requestTimedOut():void;
		/**
		 * Called by the channel that created this MessageResponder when a
		 *  response returns from the destination.
		 *  This method performs core result processing and then invokes the
		 *  resultHandler() method that subclasses may override to
		 *  perform any necessary custom processing.
		 *
		 * @param message           <IMessage> The result Message returned by the destination.
		 */
		public final function result(message:IMessage):void;
		/**
		 * Subclasses must override this method to perform custom processing of
		 *  the result and invoke the proper callbacks on the associated
		 *  MessageAgent.
		 *
		 * @param message           <IMessage> The result Message returned by the destination.
		 */
		protected function resultHandler(message:IMessage):void;
		/**
		 * Called by the channel that created this MessageResponder when a fault
		 *  response returns from the destination.
		 *  This method performs core result processing and then invokes the
		 *  statusHandler() method that subclasses may override to
		 *  perform any necessary custom processing.
		 *
		 * @param message           <IMessage> The fault Message returned by the destination.
		 */
		public final function status(message:IMessage):void;
		/**
		 * Subclasses must override this method to perform custom processing of
		 *  the status and invoke the proper callbacks on the associated
		 *  MessageAgent.
		 *
		 * @param message           <IMessage> The fault Message returned by the destination.
		 */
		protected function statusHandler(message:IMessage):void;
	}
}
