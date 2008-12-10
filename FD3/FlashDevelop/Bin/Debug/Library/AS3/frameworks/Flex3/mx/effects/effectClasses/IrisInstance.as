package mx.effects.effectClasses
{
	import mx.controls.SWFLoader;

	/**
	 *  The IrisInstance class implements the instance class for the Iris effect. *  Flex creates an instance of this class when it plays an Iris effect; *  you do not create one yourself. * *  @see mx.effects.Iris
	 */
	public class IrisInstance extends MaskEffectInstance
	{
		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function IrisInstance (target:Object);
		/**
		 *  @private
		 */
		protected function initMaskEffect () : void;
	}
}
