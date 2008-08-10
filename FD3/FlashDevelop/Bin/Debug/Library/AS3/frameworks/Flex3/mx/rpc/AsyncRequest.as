/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	import mx.messaging.Producer;
	import mx.messaging.messages.IMessage;
	public class AsyncRequest extends Producer {
		/**
		 * Constructs a new asynchronous request.
		 */
		public function AsyncRequest();
		/**
		 * Returns true if there are any pending requests for the passed in message.
		 *
		 * @param msg               <IMessage> The message for which the existence of pending requests is checked.
		 */
		public override function hasPendingRequestForMessage(msg:IMessage):Boolean;
		/**
		 * Dispatches the asynchronous request and stores the responder to call
		 *  later.
		 *
		 * @param msg               <IMessage> 
		 * @param responder         <IResponder> 
		 */
		public function invoke(msg:IMessage, responder:IResponder):void;
	}
}
