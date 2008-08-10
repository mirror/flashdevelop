/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	public class AutomationEvent extends Event {
		/**
		 * Constructor.
		 *
		 * @param type              <String (default = "beginRecord")> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = true)> Whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Whether the behavior associated with the event can be prevented.
		 */
		public function AutomationEvent(type:String = "beginRecord", bubbles:Boolean = true, cancelable:Boolean = true);
		/**
		 * The AutomationEvent.BEGIN_RECORD constant defines the value of the
		 *  type property of the event object for a beginRecord event.
		 */
		public static const BEGIN_RECORD:String = "beginRecord";
		/**
		 * The AutomationEvent.BEGIN_RECORD constant defines the value of the
		 *  type property of the event object for a endRecord event.
		 */
		public static const END_RECORD:String = "endRecord";
	}
}
