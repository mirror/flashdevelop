package mx.effects.effectClasses
{
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  The PauseInstance class implements the instance class for the Pause effect.
 *  Flex creates an instance of this class when it plays a Pause effect;
 *  you do not create one 
 *  yourself.
 *
 *  @see mx.effects.Pause
	 */
	public class PauseInstance extends TweenEffectInstance
	{
		/**
		 *  Constructor.
	 *
	 *  @param target This argument is ignored by the Pause effect.
	 *  It is included for consistency with other effects.
		 */
		public function PauseInstance (target:Object);

		/**
		 *  @private
		 */
		public function play () : void;
	}
}
