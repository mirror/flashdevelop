/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class ActivityEvent extends Event {
		/**
		 * Indicates whether the device is activating (true) or deactivating
		 *  (false).
		 */
		public function get activating():Boolean;
		public function set activating(value:Boolean):void;
		/**
		 * Creates an event object that contains information about activity events.
		 *  Event objects are passed as parameters to Event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the
		 *                            inherited type property. There is only one type of activity event:
		 *                            ActivityEvent.ACTIVITY.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling phase of the
		 *                            event flow. Event listeners can access this information through the inherited
		 *                            bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can
		 *                            access this information through the inherited cancelable property.
		 * @param activating        <Boolean (default = false)> Indicates whether the device is activating (true) or
		 *                            deactivating (false). Event listeners can access this information through the
		 *                            activating property.
		 */
		public function ActivityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, activating:Boolean = false);
		/**
		 * Creates a copy of an ActivityEvent object and sets the value of each property to match that of
		 *  the original.
		 *
		 * @return                  <Event> A new ActivityEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the ActivityEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the ActivityEvent object.
		 */
		public override function toString():String;
		/**
		 * The ActivityEvent.ACTIVITY constant defines the value of the type property of an activity event object.
		 */
		public static const ACTIVITY:String = "activity";
	}
}
