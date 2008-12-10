package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  The MessageAckEvent class is used to propagate acknowledge messages within the messaging system.
	 */
	public class MessageAckEvent extends MessageEvent
	{
		/**
		 *  The ACKNOWLEDGE event type; dispatched upon receipt of an acknowledgement.     *  <p>The value of this constant is <code>"acknowledge"</code>.</p>     *     *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>acknowledgeMessage</code></td><td> Utility property to get     *       the message property from MessageEvent as an AcknowledgeMessage.</td></tr>      *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>.</td></tr>     *     <tr><td><code>correlate</code></td><td> The original Message correlated with     *       this acknowledgement.</td></tr>     *     <tr><td><code>message</code></td><td>The Message associated with this event.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *  </table>     *  @eventType acknowledge         *
		 */
		public static const ACKNOWLEDGE : String = "acknowledge";
		/**
		 *  The original Message correlated with this acknowledgement.
		 */
		public var correlation : IMessage;

		/**
		 *  Utility property to get the message property from the MessageEvent as an AcknowledgeMessage.
		 */
		public function get acknowledgeMessage () : AcknowledgeMessage;
		/**
		 *  @private
		 */
		public function get correlationId () : String;

		/**
		 *  Utility method to create a new MessageAckEvent that doesn't bubble and     *  is not cancelable.     *      *  @param ack The AcknowledgeMessage this event should dispatch.     *       *  @param correlation The Message correlated with this acknowledgement.     *      *  @return New MessageAckEvent.
		 */
		public static function createEvent (ack:AcknowledgeMessage = null, correlation:IMessage = null) : MessageAckEvent;
		/**
		 *  Constructs an instance of this event with the specified acknowledge     *  message and original correlated message.     *     *  @param type The type for the MessageAckEvent.     *      *  @param bubbles Specifies whether the event can bubble up the display      *  list hierarchy.     *      *  @param cancelable Indicates whether the behavior associated with the      *  event can be prevented.     *      *  @param ack The AcknowledgeMessage this event should dispatch.     *       *  @param correlation The message correlated with this acknowledgement.
		 */
		public function MessageAckEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, ack:AcknowledgeMessage = null, correlation:IMessage = null);
		/**
		 *  Clones the MessageAckEvent.     *     *  @return Copy of this MessageAckEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the MessageAckEvent.     *     *  @return String representation of the MessageAckEvent.
		 */
		public function toString () : String;
	}
}
