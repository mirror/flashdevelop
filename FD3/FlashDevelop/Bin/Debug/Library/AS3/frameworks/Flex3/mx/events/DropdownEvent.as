/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class DropdownEvent extends Event {
		/**
		 * If the control is opened or closed in response to a user action,
		 *  this property contains a value indicating the type of input action.
		 *  The value is either InteractionInputType.MOUSE
		 *  or InteractionInputType.KEYBOARD.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param triggerEvent      <Event (default = null)> A value indicating the
		 *                            type of input action that triggered the event
		 */
		public function DropdownEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, triggerEvent:Event = null);
		/**
		 * The DropdownEvent.CLOSE constant defines the value of the
		 *  type property of the event object for a close event.
		 */
		public static const CLOSE:String = "close";
		/**
		 * The DropdownEvent.OPEN constant defines the value of the
		 *  type property of the event object for a open event.
		 */
		public static const OPEN:String = "open";
	}
}
