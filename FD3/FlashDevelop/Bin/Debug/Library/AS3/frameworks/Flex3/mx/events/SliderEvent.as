/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class SliderEvent extends Event {
		/**
		 * Specifies whether the slider track or a slider thumb was pressed.
		 *  This property can have one of two values:
		 *  SliderEventClickTarget.THUMB
		 *  or SliderEventClickTarget.TRACK.
		 */
		public var clickTarget:String;
		/**
		 * If the event was triggered by a key press, the keycode for the key.
		 */
		public var keyCode:int;
		/**
		 * The zero-based index of the thumb whose position has changed.
		 *  If there is only a single thumb, the value is 0.
		 *  If there are two thumbs, the value is 0 or 1.
		 */
		public var thumbIndex:int;
		/**
		 * Indicates the type of input action.
		 *  The value is either InteractionInputType.MOUSE
		 *  or InteractionInputType.KEYBOARD.
		 */
		public var triggerEvent:Event;
		/**
		 * The new value of the slider.
		 */
		public var value:Number;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param thumbIndex        <int (default = -1)> The zero-based index of the thumb
		 *                            whose position has changed.
		 * @param value             <Number (default = NaN)> The type of input action.
		 *                            The value is either InteractionInputType.MOUSE
		 *                            or InteractionInputType.KEYBOARD.
		 * @param triggerEvent      <Event (default = null)> Whether the slider track or a slider thumb was pressed.
		 * @param clickTarget       <String (default = null)> If the event was triggered by a key press,
		 *                            the keycode for the key.
		 * @param keyCode           <int (default = -1)> 
		 */
		public function SliderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, thumbIndex:int = -1, value:Number = NaN, triggerEvent:Event = null, clickTarget:String = null, keyCode:int = -1);
		/**
		 * The SliderEvent.CHANGE constant defines the value of the
		 *  type property of the event object for a change event.
		 */
		public static const CHANGE:String = "change";
		/**
		 * The SliderEvent.THUMB_DRAG constant defines the value of the
		 *  type property of the event object for a thumbDrag event.
		 */
		public static const THUMB_DRAG:String = "thumbDrag";
		/**
		 * The SliderEvent.THUMB_PRESS constant defines the value of the
		 *  type property of the event object for a thumbPress event.
		 */
		public static const THUMB_PRESS:String = "thumbPress";
		/**
		 * The SliderEvent.THUMB_RELEASE constant defines the value of the
		 *  type property of the event object for a thumbRelease event.
		 */
		public static const THUMB_RELEASE:String = "thumbRelease";
	}
}
