/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class ScreenMouseEvent extends MouseEvent {
		/**
		 * The X position  of the click in screen coordinates.
		 */
		public function get screenX():Number;
		/**
		 * The Y position of the click in screen coordinates.
		 */
		public function get screenY():Number;
		/**
		 * Creates a ScreenMouseEvent object that contains the mouse location in
		 *  screen coordinates.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information
		 *                            through the inherited type property.
		 * @param bubbles           <Boolean (default = false)> The X position of the click in screen coordinates.
		 * @param cancelable        <Boolean (default = false)> The Y position of the click in screen coordinates.
		 * @param screenX           <Number (default = NaN)> Set to false since screen mouse events never bubble.
		 * @param screenY           <Number (default = NaN)> Set to false since there is no default behavior to cancel.
		 * @param ctrlKey           <Boolean (default = false)> On Windows, indicates whether the Ctrl key was down when this event occurred.
		 *                            On Mac, indicates whether the Ctrl key or the Command key was down.
		 * @param altKey            <Boolean (default = false)> Set to true to indicate that the alt key was down when this event occured.
		 * @param shiftKey          <Boolean (default = false)> Set to true to indicate that the shift key was down when this event occured.
		 * @param buttonDown        <Boolean (default = false)> Set to true to indicate that a mouse button was down when this event occured.
		 * @param commandKey        <Boolean (default = false)> Indicates whether the Command key was down (Mac only).
		 * @param controlKey        <Boolean (default = false)> Indicates whether the Ctrl key was down.
		 */
		public function ScreenMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, screenX:Number = NaN, screenY:Number = NaN, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false);
		/**
		 * Creates a copy of the ScreenMouseEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new ScreenMouseEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the ScreenMouseEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the ScreenMouseEvent object.
		 */
		public override function toString():String;
	}
}
