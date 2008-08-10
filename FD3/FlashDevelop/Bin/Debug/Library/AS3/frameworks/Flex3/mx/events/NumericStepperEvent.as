/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class NumericStepperEvent extends Event {
		/**
		 * If the value is changed in response to a user action,
		 *  this property contains a value indicating the type of input action.
		 *  The value is either InteractionInputType.MOUSE
		 *  or InteractionInputType.KEYBOARD.
		 */
		public var triggerEvent:Event;
		/**
		 * The value of the NumericStepper control when the event was dispatched.
		 */
		public var value:Number;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param value             <Number (default = NaN)> The value of the NumericStepper control when the event was dispatched.
		 * @param triggerEvent      <Event (default = null)> 
		 */
		public function NumericStepperEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, value:Number = NaN, triggerEvent:Event = null);
		/**
		 * The NumericStepperEvent.CHANGE constant defines the value of the
		 *  type property of the event object for a change event.
		 */
		public static const CHANGE:String = "change";
	}
}
