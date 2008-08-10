/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class StatusEvent extends Event {
		/**
		 * A description of the object's status.
		 */
		public function get code():String;
		public function set code(value:String):void;
		/**
		 * The category of the message, such as "status", "warning" or "error".
		 */
		public function get level():String;
		public function set level(value:String):void;
		/**
		 * Creates an Event object that contains information about status events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of status event: StatusEvent.STATUS.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param code              <String (default = "")> A description of the object's status. Event listeners can access this information through the code property.
		 * @param level             <String (default = "")> The category of the message, such as "status", "warning" or "error". Event listeners can access this information through the level property.
		 */
		public function StatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, code:String = "", level:String = "");
		/**
		 * Creates a copy of the StatusEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new StatusEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the StatusEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the StatusEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a status event object.
		 */
		public static const STATUS:String = "status";
	}
}
