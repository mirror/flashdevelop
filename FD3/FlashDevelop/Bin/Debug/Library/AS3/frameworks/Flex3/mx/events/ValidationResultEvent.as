/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class ValidationResultEvent extends Event {
		/**
		 * The name of the field that failed validation and triggered the event.
		 */
		public var field:String;
		/**
		 * A single string that contains every error message from all
		 *  of the ValidationResult objects in the results Array.
		 */
		public function get message():String;
		/**
		 * An array of ValidationResult objects, one per validated field.
		 */
		public var results:Array;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the
		 *                            display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param field             <String (default = null)> The name of the field that failed validation and triggered the event.
		 * @param results           <Array (default = null)> An array of ValidationResult objects, one per validated field.
		 */
		public function ValidationResultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, field:String = null, results:Array = null);
		/**
		 * The ValidationResultEvent.INVALID constant defines the value of the
		 *  type property of the event object for an invalid event.
		 *  The value of this constant is "invalid".
		 */
		public static const INVALID:String = "invalid";
		/**
		 * The ValidationResultEvent.VALID constant defines the value of the
		 *  type property of the event object for a validevent.
		 *  The value of this constant is "valid".
		 */
		public static const VALID:String = "valid";
	}
}
