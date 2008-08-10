/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.EffectInstance;
	import mx.effects.IEffectInstance;
	public class CompositeEffectInstance extends EffectInstance {
		/**
		 * Constructor.
		 *
		 * @param target            <Object> This argument is ignored for Composite effects.
		 *                            It is included only for consistency with other types of effects.
		 */
		public function CompositeEffectInstance(target:Object);
		/**
		 * Adds a new set of child effects to this Composite effect.
		 *  A Sequence effect plays each child effect set one at a time,
		 *  in the order that it is added.
		 *  A Parallel effect plays all child effect sets simultaneously;
		 *  the order in which they are added doesn't matter.
		 *
		 * @param childSet          <Array> Array of child effects to be added
		 *                            to the CompositeEffect.
		 */
		public function addChildSet(childSet:Array):void;
		/**
		 * Called each time one of the child effects has finished playing.
		 *  Subclasses must implement this function.
		 *
		 * @param childEffect       <IEffectInstance> child effect.
		 */
		protected function onEffectEnd(childEffect:IEffectInstance):void;
		/**
		 * Used internally to keep track of the value of
		 *  the playheadTime property.
		 *
		 * @param value             <Object> 
		 */
		public function onTweenEnd(value:Object):void;
		/**
		 * Used internally to keep track of the value of
		 *  the playheadTime property.
		 *
		 * @param value             <Object> 
		 */
		public function onTweenUpdate(value:Object):void;
	}
}
