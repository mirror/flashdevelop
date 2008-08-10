/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.IEffectInstance;
	public class SequenceInstance extends CompositeEffectInstance {
		/**
		 * Constructor.
		 *
		 * @param target            <Object> This argument is ignored for Sequence effects.
		 *                            It is included only for consistency with other types of effects.
		 */
		public function SequenceInstance(target:Object);
		/**
		 * Interrupts any effects that are currently playing, skips over
		 *  any effects that haven't started playing, and jumps immediately
		 *  to the end of the composite effect.
		 */
		public override function end():void;
		/**
		 * Each time a child effect of SequenceInstance finishes,
		 *  Flex calls the onEffectEnd() method.
		 *  For SequenceInstance, it plays the next effect.
		 *  This method implements the method of the superclass.
		 *
		 * @param childEffect       <IEffectInstance> The child effect.
		 */
		protected override function onEffectEnd(childEffect:IEffectInstance):void;
	}
}
