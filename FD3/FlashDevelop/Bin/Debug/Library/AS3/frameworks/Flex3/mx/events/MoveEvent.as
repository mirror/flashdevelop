/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class MoveEvent extends Event {
		/**
		 * The previous x coordinate of the object, in pixels.
		 */
		public var oldX:Number;
		/**
		 * The previous y coordinate of the object, in pixels.
		 */
		public var oldY:Number;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param oldX              <Number (default = NaN)> The previous x coordinate of the object, in pixels.
		 * @param oldY              <Number (default = NaN)> The previous y coordinate of the object, in pixels.
		 */
		public function MoveEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldX:Number = NaN, oldY:Number = NaN);
		/**
		 * The MoveEvent.MOVE constant defines the value of the
		 *  type property of the event object for a move event.
		 */
		public static const MOVE:String = "move";
	}
}
