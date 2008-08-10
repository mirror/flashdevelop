/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.EffectInstance;
	public class ActionEffectInstance extends EffectInstance {
		/**
		 * Indicates whether the effect has been played (true),
		 *  or not (false).
		 */
		protected var playedAction:Boolean = false;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function ActionEffectInstance(target:Object);
		/**
		 * Used internally to retrieve the values saved by
		 *  the saveStartValue() method.
		 */
		protected function getStartValue():*;
		/**
		 * Subclasses implement this method to save the starting state
		 *  before the effect plays.
		 */
		protected function saveStartValue():*;
	}
}
