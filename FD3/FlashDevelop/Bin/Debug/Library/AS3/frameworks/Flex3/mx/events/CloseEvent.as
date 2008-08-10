/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class CloseEvent extends Event {
		/**
		 * Identifies the button in the popped up control that was clicked. This
		 *  property is for controls with multiple buttons.
		 *  The Alert control sets this property to one of the following constants:
		 *  Alert.YES
		 *  Alert.NO
		 *  Alert.OK
		 *  Alert.CANCEL
		 */
		public var detail:int;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param detail            <int (default = -1)> Value of the detail property; identifies the button in the popped up
		 *                            control that was clicked.
		 */
		public function CloseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:int = -1);
		/**
		 * The CloseEvent.CLOSE constant defines the value of the
		 *  type property of the event object for a close event.
		 */
		public static const CLOSE:String = "close";
	}
}
