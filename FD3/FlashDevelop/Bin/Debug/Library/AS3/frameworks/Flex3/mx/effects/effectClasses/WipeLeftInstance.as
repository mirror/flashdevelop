package mx.effects.effectClasses
{
	import mx.controls.SWFLoader;

	/**
	 *  The WipeLeftInstance class implements the instance class *  for the WipeLeft effect. *  Flex creates an instance of this class when it plays a WipeLeft effect; *  you do not create one yourself. * *  @see mx.effects.WipeLeft
	 */
	public class WipeLeftInstance extends MaskEffectInstance
	{
		/**
		 *  Constructor. 	 * 	 *  @param target The Object to animate with this effect.
		 */
		public function WipeLeftInstance (target:Object);
		/**
		 *  @private
		 */
		protected function initMaskEffect () : void;
	}
}
