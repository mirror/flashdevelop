/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class AsyncErrorEvent extends ErrorEvent {
		/**
		 * The exception that was thrown.
		 */
		public var error:Error;
		/**
		 * Creates an AsyncErrorEvent object that contains information about asyncError events.
		 *  AsyncErrorEvent objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through
		 *                            the inherited type property. There is only one type of error event:
		 *                            ErrorEvent.ERROR.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object bubbles. Event listeners can access
		 *                            this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners
		 *                            can access this information through the inherited cancelable property.
		 * @param text              <String (default = "")> Text to be displayed as an error message. Event listeners can access this
		 *                            information through the text property.
		 * @param error             <Error (default = null)> The exception that occurred.
		 *                            If error is non-null, the event's errorId property is set from the error's
		 *                            errorId property.
		 */
		public function AsyncErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", error:Error = null);
		/**
		 * Creates a copy of the AsyncErrorEvent object and sets the value of each property to match
		 *  that of the original.
		 *
		 * @return                  <Event> A new AsyncErrorEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the AsyncErrorEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the AsyncErrorEvent object.
		 */
		public override function toString():String;
		/**
		 * The AsyncErrorEvent.ASYNC_ERROR constant defines the value of the
		 *  type property of an asyncError event object.
		 */
		public static const ASYNC_ERROR:String = "asyncError";
	}
}
