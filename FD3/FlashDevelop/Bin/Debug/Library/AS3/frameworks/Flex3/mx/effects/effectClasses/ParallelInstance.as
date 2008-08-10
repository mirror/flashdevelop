/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.IEffectInstance;
	public class ParallelInstance extends CompositeEffectInstance {
		/**
		 * Constructor.
		 *
		 * @param target            <Object> This argument is ignored for Parallel effects.
		 *                            It is included only for consistency with other types of effects.
		 */
		public function ParallelInstance(target:Object);
		/**
		 * Interrupts any effects that are currently playing, skips over
		 *  any effects that haven't started playing, and jumps immediately
		 *  to the end of the composite effect.
		 */
		public override function end():void;
		/**
		 * Each time a child effect of SequenceInstance or ParallelInstance
		 *  finishes, Flex calls the onEffectEnd() method.
		 *  For SequenceInstance, it plays the next effect.
		 *  In ParallelInstance, it keeps track of all the
		 *  effects until all of them have finished playing.
		 *  If you create a subclass of CompositeEffect, you must implement this method.
		 *
		 * @param childEffect       <IEffectInstance> 
		 */
		protected override function onEffectEnd(childEffect:IEffectInstance):void;
	}
}
