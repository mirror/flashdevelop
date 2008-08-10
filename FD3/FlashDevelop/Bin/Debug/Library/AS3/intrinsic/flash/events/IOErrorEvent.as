/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class IOErrorEvent extends ErrorEvent {
		/**
		 * Creates an Event object that contains specific information about ioError events.
		 *  Event objects are passed as parameters to Event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of input/output error event: IOErrorEvent.IO_ERROR.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param text              <String (default = "")> Text to be displayed as an error message. Event listeners can access this information through the text property.
		 * @param id                <int (default = 0)> A reference number to associate with the specific error.
		 */
		public function IOErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);
		/**
		 * Creates a copy of the IOErrorEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new IOErrorEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the IOErrorEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the IOErrorEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of an ioError event object.
		 */
		public static const IO_ERROR:String = "ioError";
	}
}
