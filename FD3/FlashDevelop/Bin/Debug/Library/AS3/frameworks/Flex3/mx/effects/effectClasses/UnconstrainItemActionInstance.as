package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.controls.listClasses.ListBase;

include "../../core/Version.as"
	/**
	 *  The UnconstrainItemActionInstance class implements the instance class
 *  for the UnconstrainItemAction effect.
 *  Flex creates an instance of this class when it plays a UnconstrainItemAction
 *  effect; you do not create one yourself.
 *
 *  @see mx.effects.UnconstrainItemAction
	 */
	public class UnconstrainItemActionInstance extends ActionEffectInstance
	{
		public var effectHost : ListBase;

		/**
		 *  Constructor.
     *
     *  @param target The Object to animate with this effect.
		 */
		public function UnconstrainItemActionInstance (target:Object);

		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;

		/**
		 *  @private
		 */
		public function play () : void;
	}
}
