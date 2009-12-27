package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.controls.listClasses.ListBase;
	import mx.effects.IEffectTargetHost;

include "../../core/Version.as"
	/**
	 *  The RemoveItemActionInstance class implements the instance class
 *  for the RemoveChildAction effect.
 *  Flex creates an instance of this class when it plays a RemoveItemAction
 *  effect; you do not create one yourself.
 *
 *  @see mx.effects.RemoveItemAction
	 */
	public class RemoveItemActionInstance extends ActionEffectInstance
	{
		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function RemoveItemActionInstance (target:Object);

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
