/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class CalendarLayoutChangeEvent extends Event {
		/**
		 * The selected date of the control.
		 */
		public var newDate:Date;
		/**
		 * The event that triggered the change of the date;
		 *  usually a change event.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param newDate           <Date (default = null)> The date selected in the control.
		 * @param triggerEvent      <Event (default = null)> The event that triggered this change event;
		 *                            usually a change event.
		 */
		public function CalendarLayoutChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, newDate:Date = null, triggerEvent:Event = null);
		/**
		 * The CalendarLayoutChangeEvent.CHANGE constant
		 *  defines the value of the type property of the event
		 *  object for a change event.
		 */
		public static const CHANGE:String = "change";
	}
}
