package mx.effects.effectClasses
{
	import mx.controls.SWFLoader;

include "../../core/Version.as"
	/**
	 *  The WipeDownInstance class implements the instance class
 *  for the WipeDown effect.
 *  Flex creates an instance of this class when it plays a WipeDown effect;
 *  you do not create one yourself.
 *
 *  @see mx.effects.WipeDown
	 */
	public class WipeDownInstance extends MaskEffectInstance
	{
		/**
		 *  Constructor. 
	 * 
	 *  @param target The Object to animate with this effect.
		 */
		public function WipeDownInstance (target:Object);

		/**
		 *  @private
		 */
		protected function initMaskEffect () : void;
	}
}
