/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.events {
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.IMessage;
	public class MessageAckEvent extends MessageEvent {
		/**
		 * Utility property to get the message property from the MessageEvent as an AcknowledgeMessage.
		 */
		public function get acknowledgeMessage():AcknowledgeMessage;
		/**
		 * The original Message correlated with this acknowledgement.
		 */
		public var correlation:IMessage;
		/**
		 * Constructs an instance of this event with the specified acknowledge
		 *  message and original correlated message.
		 *
		 * @param type              <String> The type for the MessageAckEvent.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display
		 *                            list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Indicates whether the behavior associated with the
		 *                            event can be prevented.
		 * @param ack               <AcknowledgeMessage (default = null)> The AcknowledgeMessage this event should dispatch.
		 * @param correlation       <IMessage (default = null)> The message correlated with this acknowledgement.
		 */
		public function MessageAckEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, ack:AcknowledgeMessage = null, correlation:IMessage = null);
		/**
		 * Clones the MessageAckEvent.
		 *
		 * @return                  <Event> Copy of this MessageAckEvent.
		 */
		public override function clone():Event;
		/**
		 * Utility method to create a new MessageAckEvent that doesn't bubble and
		 *  is not cancelable.
		 *
		 * @param ack               <AcknowledgeMessage (default = null)> The AcknowledgeMessage this event should dispatch.
		 * @param correlation       <IMessage (default = null)> The Message correlated with this acknowledgement.
		 * @return                  <MessageAckEvent> New MessageAckEvent.
		 */
		public static function createEvent(ack:AcknowledgeMessage = null, correlation:IMessage = null):MessageAckEvent;
		/**
		 * Returns a string representation of the MessageAckEvent.
		 *
		 * @return                  <String> String representation of the MessageAckEvent.
		 */
		public override function toString():String;
		/**
		 * The ACKNOWLEDGE event type; dispatched upon receipt of an acknowledgement.
		 */
		public static const ACKNOWLEDGE:String = "acknowledge";
	}
}
