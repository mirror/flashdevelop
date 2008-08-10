/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class NativeWindowDisplayStateEvent extends Event {
		/**
		 * The display state of the NativeWindow after the change.
		 */
		public function get afterDisplayState():String;
		/**
		 * The display state of the NativeWindow before the change.
		 */
		public function get beforeDisplayState():String;
		/**
		 * Creates an Event object with specific information relevant to window display state events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING
		 *                            NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE
		 * @param bubbles           <Boolean (default = true)> Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled.
		 * @param beforeDisplayState<String (default = "")> The displayState before the change.
		 * @param afterDisplayState <String (default = "")> The displayState after the change.
		 */
		public function NativeWindowDisplayStateEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, beforeDisplayState:String = "", afterDisplayState:String = "");
		/**
		 * Creates a copy of the NativeWindowDisplayStateEvent object and sets the
		 *  value of each property to match that of the original.
		 *
		 * @return                  <Event> A new NativeWindowDisplayStateEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the NativeWindowDisplayStateEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the NativeWindowDisplayStateEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a displayStateChange event object.
		 *  This event has the following properties:
		 *  PropertiesValues
		 *  afterDisplayStateThe old display state of the window.
		 *  beforeDisplayStateThe new display state of the window.
		 *  targetThe NativeWindow instance that has just changed state.
		 *  bubblesNo.
		 *  currentTargetIndicates the object that is actively processing the Event
		 *  object with an event listener.
		 *  cancelablefalse; There is no default behavior to cancel.
		 */
		public static const DISPLAY_STATE_CHANGE:String = "displayStateChange";
		/**
		 * Defines the value of the type property of a displayStateChanging event object.
		 *  This event has the following properties:
		 *  PropertiesValues
		 *  afterDisplayStateThe display state of the window before the pending change.
		 *  beforeDisplayStateThe display state of the window after the pending change.
		 *  targetThe NativeWindow instance that has just changed state.
		 *  bubblesNo.
		 *  currentTargetIndicates the object that is actively processing the Event
		 *  object with an event listener.
		 *  cancelabletrue; canceling the event will prevent the change.
		 */
		public static const DISPLAY_STATE_CHANGING:String = "displayStateChanging";
	}
}
