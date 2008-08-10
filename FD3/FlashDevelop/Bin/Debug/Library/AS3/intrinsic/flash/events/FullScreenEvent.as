/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class FullScreenEvent extends ActivityEvent {
		/**
		 * Indicates whether the Stage object is in full-screen mode (true) or not (false).
		 */
		public function get fullScreen():Boolean;
		/**
		 * Creates an event object that contains information about fullScreen events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the
		 *                            inherited type property. There is only one type of fullScreen event:
		 *                            FullScreenEvent.FULL_SCREEN.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling phase of the
		 *                            event flow. Event listeners can access this information through the inherited
		 *                            bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can
		 *                            access this information through the inherited cancelable property.
		 * @param fullScreen        <Boolean (default = false)> Indicates whether the device is activating (true) or
		 *                            deactivating (false). Event listeners can access this information through the
		 *                            activating property.
		 */
		public function FullScreenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, fullScreen:Boolean = false);
		/**
		 * Creates a copy of a FullScreenEvent object and sets the value of each property to match that of
		 *  the original.
		 *
		 * @return                  <Event> A new FullScreenEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the FullScreenEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the FullScreenEvent object.
		 */
		public override function toString():String;
		/**
		 * The FullScreenEvent.FULL_SCREEN constant defines the value of the type property of a fullScreen event object.
		 */
		public static const FULL_SCREEN:String = "fullScreen";
	}
}
