package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.controls.listClasses.ListBase;
	import mx.effects.IEffectTargetHost;

	/**
	 *  The AddItemActionInstance class implements the instance class *  for the AddItemAction effect. *  Flex creates an instance of this class when it plays a AddItemAction *  effect; you do not create one yourself. * *  @see mx.effects.AddItemAction
	 */
	public class AddItemActionInstance extends ActionEffectInstance
	{
		/**
		 *  Constructor.     *     *  @param target The Object to animate with this effect.
		 */
		public function AddItemActionInstance (target:Object);
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
