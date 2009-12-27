package mx.effects.effectClasses
{
	import mx.controls.SWFLoader;

include "../../core/Version.as"
	/**
	 *  The WipeRightInstance class implements the instance class
 *  for the WipeRight effect.
 *  Flex creates an instance of this class when it plays a WipeRight effect;
 *  you do not create one 
 *  yourself.
 *
 *  @see mx.effects.WipeRight
	 */
	public class WipeRightInstance extends MaskEffectInstance
	{
		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function WipeRightInstance (target:Object);

		/**
		 *  @private
		 */
		protected function initMaskEffect () : void;
	}
}
