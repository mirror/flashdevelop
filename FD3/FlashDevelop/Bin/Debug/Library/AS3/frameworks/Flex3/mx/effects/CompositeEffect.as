/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class CompositeEffect extends Effect {
		/**
		 * An Array containing the child effects of this CompositeEffect.
		 */
		public var children:Array;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> This argument is ignored for composite effects.
		 *                            It is included only for consistency with other types of effects.
		 */
		public function CompositeEffect(target:Object = null);
		/**
		 * Adds a new child effect to this composite effect.
		 *  A Sequence effect plays each child effect one at a time,
		 *  in the order that they were added.
		 *  A Parallel effect plays all child effects simultaneously;
		 *  the order in which they are added does not matter.
		 *
		 * @param childEffect       <IEffect> Child effect to be added
		 *                            to the composite effect.
		 */
		public function addChild(childEffect:IEffect):void;
	}
}
