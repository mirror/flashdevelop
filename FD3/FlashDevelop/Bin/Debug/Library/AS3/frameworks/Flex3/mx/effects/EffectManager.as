/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	import flash.events.EventDispatcher;
	import mx.core.IUIComponent;
	public class EffectManager extends EventDispatcher {
		/**
		 * Immediately ends any effects currently playing on a target.
		 *
		 * @param target            <IUIComponent> The target component on which to end all effects.
		 */
		public static function endEffectsForTarget(target:IUIComponent):void;
		/**
		 * Allows the EffectManager class to resume processing events
		 *  after a call to the suspendEventHandling() method.
		 *  Used internally in conjunction with the
		 *  suspendEventHandling() method
		 *  so that an effect that is updating the screen
		 *  does not cause another effect to be triggered.
		 */
		public static function resumeEventHandling():void;
		/**
		 * After this method is called, the EffectManager class ignores
		 *  all events, and no effects are triggered, until a call to
		 *  resumeEventHandling().
		 *  Used internally so that an effect that is updating the screen
		 *  does not cause another effect to be triggered.
		 */
		public static function suspendEventHandling():void;
	}
}
