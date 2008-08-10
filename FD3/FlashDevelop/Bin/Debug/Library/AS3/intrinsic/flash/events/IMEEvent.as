/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class IMEEvent extends TextEvent {
		/**
		 * Creates an Event object with specific information relevant to IME events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one IME event: IMEEvent.IME_COMPOSITION.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param text              <String (default = "")> The reading string from the IME. This is the initial string as typed by the user, before selection of any candidates. The final composition string is delivered to the object with keyboard focus in a TextEvent.TEXT_INPUT event. Event listeners can access this information through the text property.
		 */
		public function IMEEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		/**
		 * Creates a copy of the IMEEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new IMEEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the IMEEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the IMEEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of an imeComposition event object.
		 */
		public static const IME_COMPOSITION:String = "imeComposition";
	}
}
