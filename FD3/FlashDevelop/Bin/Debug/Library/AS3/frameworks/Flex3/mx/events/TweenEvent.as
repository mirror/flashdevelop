/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class TweenEvent extends Event {
		/**
		 * For a tweenStart or tweenUpdate event, the value passed to the
		 *  onTweenUpdate() method; for a tweenEnd event,
		 *  the value passed to the onTweenEnd() method.
		 */
		public var value:Object;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the
		 *                            display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param value             <Object (default = null)> For a tweenStart or tweenUpdate event, the value passed to the
		 *                            onTweenUpdate() method; for a tweenEnd event,
		 *                            the value passed to the onTweenEnd() method.
		 */
		public function TweenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, value:Object = null);
		/**
		 * The TweenEvent.TWEEN_END constant defines the value of the
		 *  event object's type property for a tweenEnd event.
		 */
		public static const TWEEN_END:String = "tweenEnd";
		/**
		 * The TweenEvent.TWEEN_START constant defines the value of the
		 *  event object's type property for a tweenStart event.
		 */
		public static const TWEEN_START:String = "tweenStart";
		/**
		 * The TweenEvent.TWEEN_UPDATE constant defines the value of the
		 *  event object's type property for a tweenUpdate event.
		 */
		public static const TWEEN_UPDATE:String = "tweenUpdate";
	}
}
