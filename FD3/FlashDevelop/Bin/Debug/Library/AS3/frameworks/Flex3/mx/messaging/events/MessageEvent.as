/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.events {
	import flash.events.Event;
	import mx.messaging.messages.IMessage;
	public class MessageEvent extends Event {
		/**
		 * The Message associated with this event.
		 */
		public var message:IMessage;
		/**
		 * Constructs an instance of this event with the specified type and
		 *  message.
		 *
		 * @param type              <String> The type for the MessageEvent.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display
		 *                            list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Indicates whether the behavior associated with the
		 *                            event can be prevented; used by the RPC subclasses.
		 * @param message           <IMessage (default = null)> The associated message.
		 */
		public function MessageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, message:IMessage = null);
		/**
		 * Clones the MessageEvent.
		 *
		 * @return                  <Event> Copy of this MessageEvent.
		 */
		public override function clone():Event;
		/**
		 * Utility method to create a new MessageEvent that doesn't bubble and
		 *  is not cancelable.
		 *
		 * @param type              <String> The type for the MessageEvent.
		 * @param msg               <IMessage> The associated message.
		 * @return                  <MessageEvent> New MessageEvent.
		 */
		public static function createEvent(type:String, msg:IMessage):MessageEvent;
		/**
		 * Returns a string representation of the MessageEvent.
		 *
		 * @return                  <String> String representation of the MessageEvent.
		 */
		public override function toString():String;
		/**
		 * The MESSAGE event type; dispatched upon receipt of a message.
		 */
		public static const MESSAGE:String = "message";
		/**
		 * The RESULT event type; dispatched when an RPC agent receives a result from
		 *  a remote service destination.
		 */
		public static const RESULT:String = "result";
	}
}
