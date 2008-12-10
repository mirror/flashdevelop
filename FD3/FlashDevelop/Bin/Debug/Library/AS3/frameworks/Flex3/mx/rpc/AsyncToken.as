package mx.rpc
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.messages.IMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	/**
	 *  Dispatched when a property of the channel set changes. *  *  @eventType mx.events.PropertyChangeEvent.PROPERTY_CHANGE
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  This class provides a place to set additional or token-level data for  *  asynchronous RPC operations.  It also allows an IResponder to be attached *  for an individual call. *  The AsyncToken can be referenced in <code>ResultEvent</code> and  *  <code>FaultEvent</code> from the <code>token</code> property.
	 */
	public dynamic class AsyncToken extends EventDispatcher
	{
		private var _message : IMessage;
		/**
		 *  @private
		 */
		private var _responders : Array;
		private var _result : Object;

		/**
		 *  Provides access to the associated message.
		 */
		public function get message () : IMessage;
		/**
		 * An array of IResponder handlers that will be called when     * the asynchronous request completes.     *      * Eaxh responder assigned to the token will have its  <code>result</code>     * or <code>fault</code> function called passing in the     * matching event <i>before</i> the operation or service dispatches the      * event itself.     *      * A developer can prevent the service from subsequently dispatching the      * event by calling <code>event.preventDefault()</code>.     *      * Note that this will not prevent the service or operation's      * <code>result</code> property from being assigned.
		 */
		public function get responders () : Array;
		/**
		 * The result that was returned by the associated RPC call.     * Once the result property on the token has been assigned     * it will be strictly equal to the result property on the associated     * ResultEvent.
		 */
		public function get result () : Object;

		/**
		 * Constructs an instance of the token with the specified message.     *     * @param message The message with which the token is associated.
		 */
		public function AsyncToken (message:IMessage);
		/**
		 *  @private
		 */
		function setMessage (message:IMessage) : void;
		/**
		 *  <code>addResponder</code> adds a responder to an Array of responders.      *  The object assigned to the responder parameter must implement     *  <code>mx.rpc.IResponder</code>.	 *	 *  @param responder A handler which will be called when the asynchronous request completes.	 * 	 *  @see	mx.rpc.IResponder
		 */
		public function addResponder (responder:IResponder) : void;
		/**
		 * Determines if this token has at least one <code>mx.rpc.IResponder</code> registered.     * @return true if at least one responder has been added to this token.
		 */
		public function hasResponder () : Boolean;
		/**
		 * @private
		 */
		function applyFault (event:FaultEvent) : void;
		/**
		 * @private
		 */
		function applyResult (event:ResultEvent) : void;
		/**
		 * @private
		 */
		function setResult (newResult:Object) : void;
	}
}
