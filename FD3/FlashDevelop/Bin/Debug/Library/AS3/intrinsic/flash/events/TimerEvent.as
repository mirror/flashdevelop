/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class TimerEvent extends Event {
		/**
		 * Creates an Event object with specific information relevant to timer events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object bubbles. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 */
		public function TimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 * Creates a copy of the TimerEvent object and sets each property's value to match that of the original.
		 *
		 * @return                  <Event> A new TimerEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the TimerEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the TimerEvent object.
		 */
		public override function toString():String;
		/**
		 * Instructs Flash Player or the AIR runtime to render
		 *  after processing of this event completes, if the display list has been modified.
		 */
		public function updateAfterEvent():void;
		/**
		 * Defines the value of the type property of a timer event object.
		 */
		public static const TIMER:String = "timer";
		/**
		 * Defines the value of the type property of a timerComplete event object.
		 */
		public static const TIMER_COMPLETE:String = "timerComplete";
	}
}
