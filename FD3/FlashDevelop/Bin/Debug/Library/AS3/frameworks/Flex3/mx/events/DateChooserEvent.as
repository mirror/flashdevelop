/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class DateChooserEvent extends Event {
		/**
		 * Indicates the direction of scrolling. The values are defined by
		 *  the DateChooserEventDetail class.
		 *  The possible values are
		 *  DateChooserEventDetail.NEXT_MONTH,
		 *  DateChooserEventDetail.NEXT_YEAR,
		 *  DateChooserEventDetail.PREVIOUS_MONTH, or
		 *  DateChooserEventDetail.PREVIOUS_YEAR.
		 */
		public var detail:String;
		/**
		 * The event that triggered this change;
		 *  usually a scroll.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *  Normally called by the DateChooser object and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param detail            <String (default = null)> Indicates the unit and direction of scrolling.
		 *                            The possible values are
		 *                            DateChooserEventDetail.NEXT_MONTH,
		 *                            DateChooserEventDetail.NEXT_YEAR,
		 *                            DateChooserEventDetail.PREVIOUS_MONTH, or
		 *                            DateChooserEventDetail.PREVIOUS_YEAR.
		 * @param triggerEvent      <Event (default = null)> The event that triggered this change event;
		 *                            usually a scroll.
		 */
		public function DateChooserEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:String = null, triggerEvent:Event = null);
		/**
		 * The DateChooserEvent.SCROLL constant defines the value of the
		 *  type property of the event object for a scrollevent.
		 */
		public static const SCROLL:String = "scroll";
	}
}
