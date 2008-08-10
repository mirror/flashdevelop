/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	import mx.events.TweenEvent;
	public class TweenEffect extends Effect {
		/**
		 * The easing function for the animation.
		 *  The easing function is used to interpolate between the initial value
		 *  and the final value.
		 *  A trivial easing function would simply do linear interpolation,
		 *  but more sophisticated easing functions create the illusion of
		 *  acceleration and deceleration, which makes the animation seem
		 *  more natural.
		 */
		public var easingFunction:Function = null;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function TweenEffect(target:Object = null);
		/**
		 * Called when the TweenEffect dispatches a TweenEvent.
		 *  If you override this method, ensure that you call the super method.
		 *
		 * @param event             <TweenEvent> An event object of type TweenEvent.
		 */
		protected function tweenEventHandler(event:TweenEvent):void;
	}
}
