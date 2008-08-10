/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	import flash.display.InteractiveObject;
	public class FocusEvent extends Event {
		/**
		 * Specifies direction of focus for a focusIn event.
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * The key code value of the key pressed to trigger a keyFocusChange event.
		 */
		public function get keyCode():uint;
		public function set keyCode(value:uint):void;
		/**
		 * A reference to the complementary InteractiveObject instance that is affected by the
		 *  change in focus. For example, when a focusOut event occurs, the
		 *  relatedObject represents the InteractiveObject instance that has gained focus.
		 */
		public function get relatedObject():InteractiveObject;
		public function set relatedObject(value:InteractiveObject):void;
		/**
		 * Indicates whether the Shift key modifier is activated, in which case the value is
		 *  true. Otherwise, the value is false. This property is
		 *  used only if the FocusEvent is of type keyFocusChange.
		 */
		public function get shiftKey():Boolean;
		public function set shiftKey(value:Boolean):void;
		/**
		 * Creates an Event object with specific information relevant to focus events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            FocusEvent.FOCUS_IN, FocusEvent.FOCUS_OUT, FocusEvent.KEY_FOCUS_CHANGE, and FocusEvent.MOUSE_FOCUS_CHANGE.
		 * @param bubbles           <Boolean (default = true)> Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled.
		 * @param relatedObject     <InteractiveObject (default = null)> Indicates the complementary InteractiveObject instance that is affected by the change in focus. For example, when a focusIn event occurs, relatedObject represents the InteractiveObject that has lost focus.
		 * @param shiftKey          <Boolean (default = false)> Indicates whether the Shift key modifier is activated.
		 * @param keyCode           <uint (default = 0)> Indicates the code of the key pressed to trigger a keyFocusChange event.
		 * @param direction         <String (default = "none")> Indicates from which direction the target interactive object is being activated. Set to
		 *                            FocusDirection.NONE (the default value) for all events other than focusIn.
		 */
		public function FocusEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, relatedObject:InteractiveObject = null, shiftKey:Boolean = false, keyCode:uint = 0, direction:String = "none");
		/**
		 * Creates a copy of the FocusEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new FocusEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the FocusEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the FocusEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a focusIn event object.
		 */
		public static const FOCUS_IN:String = "focusIn";
		/**
		 * Defines the value of the type property of a focusOut event object.
		 */
		public static const FOCUS_OUT:String = "focusOut";
		/**
		 * Defines the value of the type property of a keyFocusChange event object.
		 */
		public static const KEY_FOCUS_CHANGE:String = "keyFocusChange";
		/**
		 * Defines the value of the type property of a mouseFocusChange event object.
		 */
		public static const MOUSE_FOCUS_CHANGE:String = "mouseFocusChange";
	}
}
