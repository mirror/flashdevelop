package mx.rpc.events
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AbstractMessage;
	import mx.rpc.AsyncToken;

	/**
	 * The event that indicates an RPC operation has successfully returned a result.
	 */
	public class ResultEvent extends AbstractEvent
	{
		/**
		 * The RESULT event type.    *    * <p>The properties of the event object have the following values:</p>    * <table class="innertable">    *     <tr><th>Property</th><th>Value</th></tr>    *     <tr><td><code>bubbles</code></td><td>false</td></tr>    *     <tr><td><code>cancelable</code></td><td>true, preventDefault()     *       from the associated token's responder.result method will prevent    *       the service or operation from dispatching this event</td></tr>    *     <tr><td><code>currentTarget</code></td><td>The Object that defines the     *       event listener that handles the event. For example, if you use     *       <code>myButton.addEventListener()</code> to register an event listener,     *       myButton is the value of the <code>currentTarget</code>. </td></tr>    *     <tr><td><code>message</code></td><td> The Message associated with this event.</td></tr>    *     <tr><td><code>target</code></td><td>The Object that dispatched the event;     *       it is not always the Object listening for the event.     *       Use the <code>currentTarget</code> property to always access the     *       Object listening for the event.</td></tr>    *     <tr><td><code>result</code></td><td>Result that the RPC call returns.</td></tr>    *     <tr><td><code>token</code></td><td>The token that represents the indiviudal call    *     to the method. Used in the asynchronous completion token pattern.</td></tr>    *  </table>    *         *  @eventType result
		 */
		public static const RESULT : String = "result";
		private var _result : Object;
		private var _headers : Object;
		private var _statusCode : int;

		/**
		 * In certain circumstances, headers may also be returned with a result to     * provide further context.
		 */
		public function get headers () : Object;
		/**
		 * @private
		 */
		public function set headers (value:Object) : void;
		/**
		 * Result that the RPC call returns.
		 */
		public function get result () : Object;
		/**
		 * If the source message was sent via HTTP, this property provides access     * to the HTTP response status code (if available), otherwise the value is     * 0.
		 */
		public function get statusCode () : int;

		/**
		 * Creates a new ResultEvent.     * @param type The event type; indicates the action that triggered the event.     * @param bubbles Specifies whether the event can bubble up the display list hierarchy.     * @param cancelable Specifies whether the behavior associated with the event can be prevented.     * @param result Object that holds the actual result of the call.     * @param token Token that represents the call to the method. Used in the asynchronous completion token pattern.     * @param message Source Message of the result.
		 */
		public function ResultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, result:Object = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * @private
		 */
		public static function createEvent (result:Object = null, token:AsyncToken = null, message:IMessage = null) : ResultEvent;
		/**
		 * Because this event can be re-dispatched we have to implement clone to     * return the appropriate type, otherwise we will get just the standard     * event type.     * @private
		 */
		public function clone () : Event;
		/**
		 * Returns a string representation of the ResultEvent.     *     * @return String representation of the ResultEvent.
		 */
		public function toString () : String;
		/**
		 * Have the token apply the result.
		 */
		function callTokenResponders () : void;
	}
}
