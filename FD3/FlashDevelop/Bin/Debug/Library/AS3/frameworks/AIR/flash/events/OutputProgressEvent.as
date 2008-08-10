/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class OutputProgressEvent extends Event {
		/**
		 * The number of bytes not yet written when the listener processes the event.
		 */
		public function get bytesPending():Number;
		public function set bytesPending(value:Number):void;
		/**
		 * The total number of bytes written so far, plus the number of pending bytes to be written.
		 */
		public function get bytesTotal():Number;
		public function set bytesTotal(value:Number):void;
		/**
		 * Creates an Event object that contains information about output progress events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. There is only one type of error event:
		 *                            OutputProgressEvent.OUTPUT_PROGRESS.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled.
		 * @param bytesPending      <Number (default = 0)> The number of bytes not yet written.
		 * @param bytesTotal        <Number (default = 0)> The total number of bytes written or with pending writes.
		 */
		public function OutputProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesPending:Number = 0, bytesTotal:Number = 0);
		/**
		 * Creates a copy of the OutputProgressEvent object and sets each property's value to match that of the original.
		 *
		 * @return                  <Event> A new OutputProgressEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the OutputProgressEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the OutputProgressEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of an outputProgress event object.
		 */
		public static const OUTPUT_PROGRESS:String = "outputProgress";
	}
}
