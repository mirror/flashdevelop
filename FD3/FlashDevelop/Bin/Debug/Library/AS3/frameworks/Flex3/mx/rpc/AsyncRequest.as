package mx.rpc
{
	import mx.core.mx_internal;
	import mx.messaging.Producer;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;

	/**
	 *  The AsyncRequest class provides an abstraction of messaging for RPC call invocation. *  An AsyncRequest allows multiple requests to be made on a remote destination *  and will call back to the responder specified within the request when *  the remote request is completed.
	 */
	public class AsyncRequest extends mx.messaging.Producer
	{
		/**
		 *  manages a list of all pending requests.  each request must implement	 *  IResponder
		 */
		private var _pendingRequests : Object;

		/**
		 *  Constructs a new asynchronous request.
		 */
		public function AsyncRequest ();
		/**
		 *  Delegates to the results to responder	 *  @param    ack Message acknowlegdement of message previously sent	 *  @param    msg Message that was recieved the acknowledgement	 *  @private
		 */
		public function acknowledge (ack:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 *  Delegates to the fault to responder	 *  @param    error message.	 *            The error codes and informaton are contained in the	 *            <code>headers</code> property	 *  @param    msg Message original message that caused the fault.	 *  @private
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
		/**
		 * Returns <code>true</code> if there are any pending requests for the passed in message.    *     * @param msg The message for which the existence of pending requests is checked.    *    * @return Returns <code>true</code> if there are any pending requests for the     * passed in message; otherwise, returns <code>false</code>.
		 */
		public function hasPendingRequestForMessage (msg:IMessage) : Boolean;
		/**
		 *  Dispatches the asynchronous request and stores the responder to call	 *  later.         *         * @param msg The message to be sent asynchronously.         *         * @param responder The responder to be called later.
		 */
		public function invoke (msg:IMessage, responder:IResponder) : void;
	}
}
