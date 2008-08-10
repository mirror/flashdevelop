/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class ResizeEvent extends Event {
		/**
		 * The previous height of the object, in pixels.
		 */
		public var oldHeight:Number;
		/**
		 * The previous width of the object, in pixels.
		 */
		public var oldWidth:Number;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param oldWidth          <Number (default = NaN)> The previous width of the object, in pixels.
		 * @param oldHeight         <Number (default = NaN)> The previous height of the object, in pixels.
		 */
		public function ResizeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldWidth:Number = NaN, oldHeight:Number = NaN);
		/**
		 * The ResizeEvent.RESIZE constant defines the value of the
		 *  type property of the event object for a resize event.
		 */
		public static const RESIZE:String = "resize";
	}
}
