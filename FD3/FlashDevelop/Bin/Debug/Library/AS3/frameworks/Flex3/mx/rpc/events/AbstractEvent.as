package mx.rpc.events
{
	import mx.core.mx_internal;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.IMessage;
	import mx.rpc.AsyncToken;

	/**
	 * The base class for events that RPC services dispatch.
	 */
	public class AbstractEvent extends MessageEvent
	{
		private var _token : AsyncToken;

		/**
		 * The token that represents the call to the method. Used in the asynchronous completion token pattern.
		 */
		public function get token () : AsyncToken;

		/**
		 * @private
		 */
		public function AbstractEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, token:AsyncToken = null, message:IMessage = null);
		/**
		 * Does nothing by default.
		 */
		function callTokenResponders () : void;
	}
}
