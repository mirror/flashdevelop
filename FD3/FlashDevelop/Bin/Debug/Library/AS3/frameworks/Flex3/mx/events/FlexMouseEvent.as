/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.MouseEvent;
	import flash.display.InteractiveObject;
	public class FlexMouseEvent extends MouseEvent {
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up
		 *                            the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param localX            <Number (default = 0)> The horizontal position at which the event occurred.
		 * @param localY            <Number (default = 0)> The vertical position at which the event occurred.
		 * @param relatedObject     <InteractiveObject (default = null)> The display list object that is related to the event.
		 * @param ctrlKey           <Boolean (default = false)> Whether the Control key is down.
		 * @param altKey            <Boolean (default = false)> Whether the Alt key is down.
		 * @param shiftKey          <Boolean (default = false)> Whether the Shift key is down.
		 * @param buttonDown        <Boolean (default = false)> Whether the Control key is down.
		 * @param delta             <int (default = 0)> How many lines should be scrolled for each notch the
		 *                            user scrolls the mouse wheel.
		 */
		public function FlexMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, localX:Number = 0, localY:Number = 0, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0);
		/**
		 * The FlexMouseEvent.MOUSE_DOWN_OUTSIDE constant defines the value of the
		 *  type property of the event object for a mouseDownOutside
		 *  event.
		 */
		public static const MOUSE_DOWN_OUTSIDE:String = "mouseDownOutside";
		/**
		 * The FlexMouseEvent.MOUSE_WHEEL_OUTSIDE constant defines the value of the
		 *  type property of the event object for a mouseWheelOutside
		 *  event.
		 */
		public static const MOUSE_WHEEL_OUTSIDE:String = "mouseWheelOutside";
	}
}
