/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	import flash.geom.Rectangle;
	public class NativeWindowBoundsEvent extends Event {
		/**
		 * The bounds of the window after the change.
		 */
		public function get afterBounds():Rectangle;
		/**
		 * The bounds of the window before the change.
		 */
		public function get beforeBounds():Rectangle;
		/**
		 * Creates an Event object with specific information relevant to window bounds events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            NativeWindowBoundsEvent.MOVING
		 *                            NativeWindowBoundsEvent.MOVE
		 *                            NativeWindowBoundsEvent.RESIZING
		 *                            NativeWindowBoundsEvent.RESIZE
		 * @param bubbles           <Boolean (default = false)> Indicates whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Indicates whether the Event object can be canceled.
		 * @param beforeBounds      <Rectangle (default = null)> Indicates the bounds before the most recent change or the pending change.
		 * @param afterBounds       <Rectangle (default = null)> Indicates the bounds after the most recent change or the pending change.
		 */
		public function NativeWindowBoundsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeBounds:Rectangle = null, afterBounds:Rectangle = null);
		/**
		 * Creates a copy of the NativeWindowBoundsEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new NativeWindowBoundsEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the NativeWindowBoundsEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the NativeWindowBoundsEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a move event object.
		 *  This event has the following properties:
		 *  PropertiesValues
		 *  afterBoundsThe new bounds of the window.
		 *  beforeBoundsThe old bounds of the window.
		 *  targetThe NativeWindow object that has just changed state.
		 *  bubblesNo.
		 *  currentTargetIndicates the object that is actively processing the Event
		 *  object with an event listener.
		 *  cancelablefalse; There is no default behavior to cancel.
		 */
		public static const MOVE:String = "move";
		/**
		 * Defines the value of the type property of a moving event object.
		 *  This event has the following properties:
		 *  PropertiesValues
		 *  afterBoundsThe bounds of the window after the pending change.
		 *  beforeBoundsThe bounds of the window before the pending change.
		 *  bubblesNo.
		 *  cancelabletrue; cancelling the event will prevent the window move.
		 *  currentTargetIndicates the object that is actively processing the Event
		 *  object with an event listener.
		 *  targetThe NativeWindow object that has just changed state.
		 */
		public static const MOVING:String = "moving";
		/**
		 * Defines the value of the type property of a resize event object.
		 *  This event has the following properties:
		 *  PropertiesValues
		 *  afterBoundsThe new bounds of the window.
		 *  beforeBoundsThe old bounds of the window.
		 *  targetThe NativeWindow object that has just changed state.
		 *  bubblesNo.
		 *  currentTargetIndicates the object that is actively processing the Event
		 *  object with an event listener.
		 *  cancelablefalse; There is no default behavior to cancel.
		 */
		public static const RESIZE:String = "resize";
		/**
		 * Defines the value of the type property of a resizing event object.
		 *  This event has the following properties:
		 *  PropertiesValues
		 *  afterBoundsThe bounds of the window after the pending change.
		 *  beforeBoundsThe bounds of the window before the pending change.
		 *  targetThe NativeWindow object that has just changed state.
		 *  bubblesNo.
		 *  currentTargetIndicates the object that is actively processing the Event
		 *  object with an event listener.
		 *  cancelabletrue; cancelling the event will prevent the window move.
		 */
		public static const RESIZING:String = "resizing";
	}
}
