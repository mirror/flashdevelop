/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class AIREvent extends Event {
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up
		 *                            the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 */
		public function AIREvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 * The AIREvent.APPLICATION_ACTIVATE constant defines the value of the
		 *  type property of the event object for an
		 *  applicationActivate event.
		 */
		public static const APPLICATION_ACTIVATE:String = "applicationActivate";
		/**
		 * The AIREvent.APPLICATION_DEACTIVATE constant defines the value of the
		 *  type property of the event object for an
		 *  applicationDeactivate event.
		 */
		public static const APPLICATION_DEACTIVATE:String = "applicationDeactivate";
		/**
		 * The AIREvent.WINDOW_ACTIVATE constant defines the value of the
		 *  type property of the event object for a
		 *  windowActivate event.
		 */
		public static const WINDOW_ACTIVATE:String = "windowActivate";
		/**
		 * The AIREvent.WINDOW_COMPLETE constant defines the value of the
		 *  type property of the event object for an
		 *  windowComplete event.
		 */
		public static const WINDOW_COMPLETE:String = "windowComplete";
		/**
		 * The AIREvent.WINDOW_DEACTIVATE constant defines the value of the
		 *  type property of the event object for a
		 *  windowDeactivate event.
		 */
		public static const WINDOW_DEACTIVATE:String = "windowDeactivate";
	}
}
