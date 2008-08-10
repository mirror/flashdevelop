/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class SecurityErrorEvent extends ErrorEvent {
		/**
		 * Creates an Event object that contains information about security error events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of error event: SecurityErrorEvent.SECURITY_ERROR.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param text              <String (default = "")> Text to be displayed as an error message. Event listeners can access this information through the text property.
		 * @param id                <int (default = 0)> A reference number to associate with the specific error.
		 */
		public function SecurityErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);
		/**
		 * Creates a copy of the SecurityErrorEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new securityErrorEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the SecurityErrorEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the SecurityErrorEvent object.
		 */
		public override function toString():String;
		/**
		 * The SecurityErrorEvent.SECURITY_ERROR constant defines the value of the type property of a securityError event object.
		 */
		public static const SECURITY_ERROR:String = "securityError";
	}
}
