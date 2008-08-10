/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class StateChangeEvent extends Event {
		/**
		 * The name of the view state that the component is entering.
		 */
		public var newState:String;
		/**
		 * The name of the view state that the component is exiting.
		 */
		public var oldState:String;
		/**
		 * Constructor.
		 *  Normally called by a Flex control and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param oldState          <String (default = null)> The name of the view state the component is exiting.
		 * @param newState          <String (default = null)> The name of the view state the component is entering.
		 */
		public function StateChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldState:String = null, newState:String = null);
		/**
		 * The StateChangeEvent.CURRENT_STATE_CHANGE constant defines the
		 *  value of the type property of the event that is dispatched
		 *  when the view state has changed.
		 *  The value of this constant is "currentStateChange".
		 */
		public static const CURRENT_STATE_CHANGE:String = "currentStateChange";
		/**
		 * The StateChangeEvent.CURRENT_STATE_CHANGING constant defines the
		 *  value of the type property of the event that is dispatched
		 *  when the view state is about to change.
		 *  The value of this constant is "currentStateChanging".
		 */
		public static const CURRENT_STATE_CHANGING:String = "currentStateChanging";
	}
}
