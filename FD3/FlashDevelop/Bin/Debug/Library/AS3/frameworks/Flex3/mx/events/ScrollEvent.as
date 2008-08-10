/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class ScrollEvent extends Event {
		/**
		 * The change in the scroll position value that resulted from
		 *  the scroll. The value is expressed in pixels. A positive value indicates the
		 *  scroll was down or to the right. A negative value indicates the scroll
		 *  was up or to the left.
		 */
		public var delta:Number;
		/**
		 * Provides the details of the scroll activity.
		 *  Constants for the possible values are provided
		 *  in the ScrollEventDetail class.
		 */
		public var detail:String;
		/**
		 * The direction of motion.
		 *  The possible values are ScrollEventDirection.VERTICAL
		 *  or ScrollEventDirection.HORIZONTAL.
		 */
		public var direction:String;
		/**
		 * The new scroll position.
		 */
		public var position:Number;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Provides the specifics of the type of scroll activity.
		 *                            Constants for the possible values are provided
		 *                            in the ScrollEventDetail class.
		 * @param detail            <String (default = null)> The new scroll position.
		 * @param position          <Number (default = NaN)> The scroll direction,
		 *                            either ScrollEventDirection.HORIZONTAL or
		 *                            ScrollEventDirection.VERTICAL.
		 * @param direction         <String (default = null)> The change in scroll position, expressed in pixels.
		 * @param delta             <Number (default = NaN)> 
		 */
		public function ScrollEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:String = null, position:Number = NaN, direction:String = null, delta:Number = NaN);
		/**
		 * The ScrollEvent.SCROLL constant defines the value of the
		 *  type property of the event object for a scroll event.
		 */
		public static const SCROLL:String = "scroll";
	}
}
