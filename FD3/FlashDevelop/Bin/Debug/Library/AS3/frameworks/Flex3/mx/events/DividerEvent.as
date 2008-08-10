/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class DividerEvent extends Event {
		/**
		 * The number of pixels that the divider has been dragged.
		 *  Positive numbers represent a drag toward the right or bottom,
		 *  negative numbers toward the left or top.
		 */
		public var delta:Number;
		/**
		 * The zero-based index of the divider being pressed or dragged.
		 *  The leftmost or topmost divider has a dividerIndex
		 *  of 0.
		 */
		public var dividerIndex:int;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param dividerIndex      <int (default = -1)> Index of the divider that generated the event.
		 * @param delta             <Number (default = NaN)> The number of pixels by which the divider has been dragged.
		 */
		public function DividerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, dividerIndex:int = -1, delta:Number = NaN);
		/**
		 * The DividerEvent.DIVIDER_DRAG constant defines the value of the
		 *  type property of the event object for a dividerDrag event.
		 */
		public static const DIVIDER_DRAG:String = "dividerDrag";
		/**
		 * The DividerEvent.DIVIDER_PRESS constant defines the value of the
		 *  type property of the event object for a dividerPress event.
		 */
		public static const DIVIDER_PRESS:String = "dividerPress";
		/**
		 * The DividerEvent.DIVIDER_RELEASE constant defines the value of the
		 *  type property of the event object for a dividerRelease event.
		 */
		public static const DIVIDER_RELEASE:String = "dividerRelease";
	}
}
