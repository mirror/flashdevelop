package mx.effects.effectClasses
{
	import mx.effects.EffectTargetFilter;

include "../../core/Version.as"
	/**
	 *  AddRemoveEffectTargetFilter is a subclass of EffectTargetFilter that handles
 *  the logic for filtering targets that have been added or removed as
 *  children to a container.
 *  If you set the Effect.filter property to "add" or "remove",
 *  then one of these is used.
	 */
	public class AddRemoveEffectTargetFilter extends EffectTargetFilter
	{
		/**
		 *  Determines if this is an add or remove filter.
	 *  
	 *  @default true
		 */
		public var add : Boolean;

		/**
		 *  Constructor.
		 */
		public function AddRemoveEffectTargetFilter ();

		/**
		 *  @private
		 */
		protected function defaultFilterFunction (propChanges:Array, instanceTarget:Object) : Boolean;
	}
}
