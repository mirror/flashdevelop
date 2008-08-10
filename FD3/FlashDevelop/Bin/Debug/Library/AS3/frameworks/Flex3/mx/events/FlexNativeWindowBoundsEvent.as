/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.events {
	public class FlexNativeWindowBoundsEvent extends NativeWindowBoundsEvent {
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up
		 *                            the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param beforeBounds      <Rectangle (default = null)> The bounds of the window before the resize.
		 * @param afterBounds       <Rectangle (default = null)> The bounds of the window before the resize.
		 */
		public function FlexNativeWindowBoundsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeBounds:Rectangle = null, afterBounds:Rectangle = null);
		/**
		 * The FlexNativeWindowBoundsEvent.WINDOW_MOVE constant defines the value of the
		 *  type property of the event object for a
		 *  windowMove event.
		 */
		public static const WINDOW_MOVE:String = "windowMove";
		/**
		 * The FlexNativeWindowBoundsEvent.WINDOW_RESIZE constant defines the value of the
		 *  type property of the event object for a
		 *  windowResize event.
		 */
		public static const WINDOW_RESIZE:String = "windowResize";
	}
}
