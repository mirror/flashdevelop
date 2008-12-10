package mx.effects.effectClasses
{
	import mx.controls.SWFLoader;

	/**
	 *  The WipeUpInstance class implements the instance class *  for the WipeUp effect. *  Flex creates an instance of this class when it plays a WipeUp effect; *  you do not create one yourself. * *  @see mx.effects.WipeUp
	 */
	public class WipeUpInstance extends MaskEffectInstance
	{
		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function WipeUpInstance (target:Object);
		/**
		 *  @private
		 */
		protected function initMaskEffect () : void;
	}
}
