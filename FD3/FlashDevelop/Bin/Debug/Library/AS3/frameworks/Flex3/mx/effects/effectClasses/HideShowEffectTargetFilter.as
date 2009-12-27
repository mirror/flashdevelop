package mx.effects.effectClasses
{
	import mx.effects.EffectTargetFilter;

include "../../core/Version.as"
	/**
	 *  HideShowEffectTargetFilter is a subclass of EffectTargetFilter
 *  that handles the logic for filtering targets that have been shown or hidden
 *  by modifying their <code>visible</code> property.
 *  If you set the Effect.filter property to <code>hide</code>
 *  or <code>show</code>, one of these is used.
	 */
	public class HideShowEffectTargetFilter extends EffectTargetFilter
	{
		/**
		 *  Determines if this is a show or hide filter.
	 * 
	 *  @default true
		 */
		public var show : Boolean;

		/**
		 *  Constructor.
		 */
		public function HideShowEffectTargetFilter ();

		/**
		 *  @private
		 */
		protected function defaultFilterFunction (propChanges:Array, instanceTarget:Object) : Boolean;
	}
}
