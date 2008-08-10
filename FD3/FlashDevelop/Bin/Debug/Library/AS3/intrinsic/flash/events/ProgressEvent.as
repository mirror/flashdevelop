/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class ProgressEvent extends Event {
		/**
		 * The number of items or bytes loaded when the listener processes the event.
		 */
		public function get bytesLoaded():Number;
		public function set bytesLoaded(value:Number):void;
		/**
		 * The total number of items or bytes that will be loaded if the loading process succeeds.
		 *  If the progress event is dispatched/attached to a Socket object, the bytesTotal will always be 0
		 *  unless a value is specified in the bytesTotal parameter of the constructor.
		 *  The actual number of bytes sent back or forth is not set and is up to the application developer.
		 */
		public function get bytesTotal():Number;
		public function set bytesTotal(value:Number):void;
		/**
		 * Creates an Event object that contains information about progress events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are:ProgressEvent.PROGRESS
		 *                            and ProgressEvent.SOCKET_DATA.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled.
		 * @param bytesLoaded       <Number (default = 0)> The number of items or bytes loaded at the time the listener processes the event.
		 * @param bytesTotal        <Number (default = 0)> The total number of items or bytes that will be loaded if the loading process succeeds.
		 */
		public function ProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:Number = 0, bytesTotal:Number = 0);
		/**
		 * Creates a copy of the ProgressEvent object and sets each property's value to match that of the original.
		 *
		 * @return                  <Event> A new ProgressEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the ProgressEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the ProgressEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a progress event object.
		 */
		public static const PROGRESS:String = "progress";
		/**
		 * Defines the value of the type property of a socketData event object.
		 */
		public static const SOCKET_DATA:String = "socketData";
	}
}
