/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	import flash.events.EventDispatcher;
	import mx.messaging.messages.IMessage;
	public dynamic  class AsyncToken extends EventDispatcher {
		/**
		 * Provides access to the associated message.
		 */
		public function get message():IMessage;
		/**
		 * An array of IResponder handlers that will be called when
		 *  the asynchronous request completes.
		 *  Eaxh responder assigned to the token will have its  result
		 *  or fault function called passing in the
		 *  matching event before the operation or service dispatches the
		 *  event itself.
		 *  A developer can prevent the service from subsequently dispatching the
		 *  event by calling event.preventDefault().
		 *  Note that this will not prevent the service or operation's
		 *  result property from being assigned.
		 */
		public function get responders():Array;
		/**
		 * The result that was returned by the associated RPC call.
		 *  Once the result property on the token has been assigned
		 *  it will be strictly equal to the result property on the associated
		 *  ResultEvent.
		 */
		public function get result():Object;
		/**
		 * Constructs an instance of the token with the specified message.
		 *
		 * @param message           <IMessage> 
		 */
		public function AsyncToken(message:IMessage);
		/**
		 * addResponder adds a responder to an Array of responders.
		 *  The object assigned to the responder parameter must implement
		 *  mx.rpc.IResponder.
		 *
		 * @param responder         <IResponder> A handler which will be called when the asynchronous request completes.
		 */
		public function addResponder(responder:IResponder):void;
		/**
		 * Determines if this token has at least one mx.rpc.IResponder registered.
		 *
		 * @return                  <Boolean> true if at least one responder has been added to this token.
		 */
		public function hasResponder():Boolean;
	}
}
