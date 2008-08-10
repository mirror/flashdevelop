/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	import flash.errors.SQLError;
	public class SQLErrorEvent extends ErrorEvent {
		/**
		 * A SQLError object containing detailed information about the cause of the error.
		 */
		public function get error():SQLError;
		/**
		 * Creates a SQLErrorEvent object to pass as an argument to event listeners.
		 *
		 * @param type              <String> The type of the event, accessible in the type property.
		 *                            The SQLErrorEvent defines one event type, the error event,
		 *                            represented by the SQLErrorEvent.ERROR constant.
		 * @param bubbles           <Boolean (default = false)> Determines whether the event object participates in the bubbling
		 *                            stage of the event flow. The default value is false.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled.
		 *                            The default value is false.
		 * @param error             <SQLError (default = null)> The SQLError object that contains the details of the error.
		 */
		public function SQLErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, error:SQLError = null);
		/**
		 * Creates a copy of the SQLErrorEvent object and sets the value of each property
		 *  to match that of the original.
		 *
		 * @return                  <Event> A new SQLErrorEvent object with property values that match those of
		 *                            the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the SQLErrorEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the SQLErrorEvent object.
		 */
		public override function toString():String;
		/**
		 * The SQLErrorEvent.ERROR constant defines the value of the
		 *  type property of an error event dispatched when a call
		 *  to a method of a SQLConnection or SQLStatement instance completes
		 *  with an error.
		 *  The error event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  errorA SQLError object containing information about the type of error that occurred and the operation that caused the error.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection or SQLStatement object reporting the error.
		 */
		public static const ERROR:String = "error";
	}
}
