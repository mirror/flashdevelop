/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.events {
	import flash.events.Event;
	import mx.messaging.messages.ErrorMessage;
	public class MessageFaultEvent extends Event {
		/**
		 * Provides access to the destination specific failure code.
		 *  For more specific details see faultString and
		 *  faultDetails properties.
		 */
		public function get faultCode():String;
		/**
		 * Provides destination specific details of the failure.
		 */
		public function get faultDetail():String;
		/**
		 * Provides access to the destination specific reason for the failure.
		 */
		public function get faultString():String;
		/**
		 * The ErrorMessage for this event.
		 */
		public var message:ErrorMessage;
		/**
		 * Provides access to the root cause of the failure, if one exists.
		 *  In the case of custom exceptions thrown by a destination, the root cause
		 *  represents the top level failure that is merely transported by the
		 *  ErrorMessage.
		 */
		public function get rootCause():Object;
		/**
		 * Constructs an instance of a fault message event for the specified message
		 *  and fault information.
		 *
		 * @param type              <String> The type for the MessageAckEvent.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display
		 *                            list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Indicates whether the behavior associated with the
		 *                            event can be prevented.
		 * @param message           <ErrorMessage (default = null)> The ErrorMessage associated with the fault.
		 */
		public function MessageFaultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, message:ErrorMessage = null);
		/**
		 * Clones the MessageFaultEvent.
		 *
		 * @return                  <Event> Copy of this MessageFaultEvent.
		 */
		public override function clone():Event;
		/**
		 * Utility method to create a new MessageFaultEvent that doesn't bubble and
		 *  is not cancelable.
		 *
		 * @param msg               <ErrorMessage> The ErrorMessage associated with the fault.
		 * @return                  <MessageFaultEvent> New MessageFaultEvent.
		 */
		public static function createEvent(msg:ErrorMessage):MessageFaultEvent;
		/**
		 * Returns a string representation of the MessageFaultEvent.
		 *
		 * @return                  <String> String representation of the MessageFaultEvent.
		 */
		public override function toString():String;
		/**
		 * The FAULT event type; dispatched for a message fault.
		 */
		public static const FAULT:String = "fault";
	}
}
