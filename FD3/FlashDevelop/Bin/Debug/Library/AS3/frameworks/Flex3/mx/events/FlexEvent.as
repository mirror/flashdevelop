/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class FlexEvent extends Event {
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up
		 *                            the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 */
		public function FlexEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 * The FlexEvent.ADD constant defines the value of the
		 *  type property of the event object for an add event.
		 */
		public static const ADD:String = "add";
		/**
		 * The FlexEvent.APPLICATION_COMPLETE constant defines the value of the
		 *  type property of the event object for a applicationComplete event.
		 */
		public static const APPLICATION_COMPLETE:String = "applicationComplete";
		/**
		 * The FlexEvent.BUTTON_DOWN constant defines the value of the
		 *  type property of the event object for a buttonDown event.
		 */
		public static const BUTTON_DOWN:String = "buttonDown";
		/**
		 * The FlexEvent.CREATION_COMPLETE constant defines the value of the
		 *  type property of the event object for a creationComplete event.
		 */
		public static const CREATION_COMPLETE:String = "creationComplete";
		/**
		 * The FlexEvent.CURSOR_UPDATE constant defines the value of the
		 *  type property of the event object for a cursorUpdate event.
		 */
		public static const CURSOR_UPDATE:String = "cursorUpdate";
		/**
		 * The FlexEvent.DATA_CHANGE constant defines the value of the
		 *  type property of the event object for a dataChange event.
		 */
		public static const DATA_CHANGE:String = "dataChange";
		/**
		 * The FlexEvent.ENTER constant defines the value of the
		 *  type property of the event object for a enter event.
		 */
		public static const ENTER:String = "enter";
		/**
		 * The FlexEvent.ENTER_STATE constant defines the value of the
		 *  type property of the event object for a enterState event.
		 */
		public static const ENTER_STATE:String = "enterState";
		/**
		 * The FlexEvent.EXIT_STATE constant defines the value of the
		 *  type property of the event object for a exitState event.
		 */
		public static const EXIT_STATE:String = "exitState";
		/**
		 * The FlexEvent.HIDE constant defines the value of the
		 *  type property of the event object for a hide event.
		 */
		public static const HIDE:String = "hide";
		/**
		 * The FlexEvent.IDLE constant defines the value of the
		 *  type property of the event object for a idle event.
		 */
		public static const IDLE:String = "idle";
		/**
		 * Dispatched when a Flex application finishes initialization.
		 *  You use this event when creating a custom download progress bar.
		 */
		public static const INIT_COMPLETE:String = "initComplete";
		/**
		 * Dispatched when the Flex application completes an initialization phase,
		 *  as defined by calls to the measure(), commitProperties(),
		 *  or updateDisplayList() methods.
		 *  This event describes the progress of the application in the initialization phase.
		 *  You use this event when creating a custom download progress bar.
		 */
		public static const INIT_PROGRESS:String = "initProgress";
		/**
		 * The FlexEvent.INITIALIZE constant defines the value of the
		 *  type property of the event object for a initialize event.
		 */
		public static const INITIALIZE:String = "initialize";
		/**
		 * The FlexEvent.INVALID constant defines the value of the
		 *  type property of the event object for a invalid event.
		 */
		public static const INVALID:String = "invalid";
		/**
		 * The FlexEvent.LOADING constant defines the value of the
		 *  type property of the event object for a loading event.
		 */
		public static const LOADING:String = "loading";
		/**
		 * The FlexEvent.PREINITIALIZE constant defines the value of the
		 *  type property of the event object for a preinitialize event.
		 */
		public static const PREINITIALIZE:String = "preinitialize";
		/**
		 * The FlexEvent.REMOVE constant defines the value of the
		 *  type property of the event object for an remove event.
		 */
		public static const REMOVE:String = "remove";
		/**
		 * The FlexEvent.REPEAT constant defines the value of the
		 *  type property of the event object for a repeat event.
		 */
		public static const REPEAT:String = "repeat";
		/**
		 * The FlexEvent.REPEAT_END constant defines the value of the
		 *  type property of the event object for a repeatEnd event.
		 */
		public static const REPEAT_END:String = "repeatEnd";
		/**
		 * The FlexEvent.REPEAT_START constant defines the value of the
		 *  type property of the event object for a repeatStart event.
		 */
		public static const REPEAT_START:String = "repeatStart";
		/**
		 * The FlexEvent.SHOW constant defines the value of the
		 *  type property of the event object for a show event.
		 */
		public static const SHOW:String = "show";
		/**
		 * The FlexEvent.TRANSFORM_CHANGE constant defines the value of the
		 *  type property of the event object for a transformChange event.
		 */
		public static const TRANSFORM_CHANGE:String = "transformChange";
		/**
		 * The FlexEvent.UPDATE_COMPLETE constant defines the value of the
		 *  type property of the event object for a updateComplete event.
		 */
		public static const UPDATE_COMPLETE:String = "updateComplete";
		/**
		 * The FlexEvent.URL_CHANGED constant defines the value of the
		 *  type property of the event object for a urlChanged event.
		 */
		public static const URL_CHANGED:String = "urlChanged";
		/**
		 * The FlexEvent.VALID constant defines the value of the
		 *  type property of the event object for a valid event.
		 */
		public static const VALID:String = "valid";
		/**
		 * The FlexEvent.VALUE_COMMIT constant defines the value of the
		 *  type property of the event object for a valueCommit
		 *  event.
		 */
		public static const VALUE_COMMIT:String = "valueCommit";
	}
}
