package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.messages.IMessage;
	import mx.core.mx_internal;

	/**
	 *  The MessageEvent class is used to propagate messages within the messaging system.
	 */
	public class MessageEvent extends Event
	{
		/**
		 *  The MESSAGE event type; dispatched upon receipt of a message.     *  <p>The value of this constant is <code>"message"</code>.</p>     *     *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>message</code></td><td>The message associated with this event.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *  </table>     *  @eventType message
		 */
		public static const MESSAGE : String = "message";
		/**
		 *  The RESULT event type; dispatched when an RPC agent receives a result from     *  a remote service destination.     *  <p>The value of this constant is <code>"result"</code>.</p>     *     *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>message</code></td><td>The message associated with this event.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *  </table>     *  @eventType result
		 */
		public static const RESULT : String = "result";
		/**
		 *  The Message associated with this event.
		 */
		public var message : IMessage;

		/**
		 *  @private
		 */
		public function get messageId () : String;

		/**
		 *  Utility method to create a new MessageEvent that doesn't bubble and     *  is not cancelable.     *      *  @param type The type for the MessageEvent.     *       *  @param message The associated message.     *      *  @return New MessageEvent.
		 */
		public static function createEvent (type:String, msg:IMessage) : MessageEvent;
		/**
		 *  Constructs an instance of this event with the specified type and      *  message.     *      *  @param type The type for the MessageEvent.     *      *  @param bubbles Specifies whether the event can bubble up the display      *  list hierarchy.     *      *  @param cancelable Indicates whether the behavior associated with the      *  event can be prevented; used by the RPC subclasses.     *      *  @param message The associated message.
		 */
		public function MessageEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, message:IMessage = null);
		/**
		 *  Clones the MessageEvent.     *     *  @return Copy of this MessageEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the MessageEvent.     *     *  @return String representation of the MessageEvent.
		 */
		public function toString () : String;
	}
}
