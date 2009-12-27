package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.controls.listClasses.ListBase;
	import mx.effects.effectClasses.UnconstrainItemActionInstance;

	[Exclude(name="duration", kind="property")] 

include "../core/Version.as"
	/**
	 *  The UnconstrainItemAction class defines an action effect that
 *  is used in a data-effect definition
 *  to temporarily stop item renderers from being positioned by the
 *  layout algorithm of the parent control. This effect can be used
 *  to allow item renderers in a TileList control to move freely
 *  rather than being constrained to lay in the normal grid defined by the control.
 *  The default data effect class for the TileList control, DefaultTileListEffect, 
 *  uses this effect.
 *
 *  <p>You typically add this effect when your custom data effect moves item renderers.</p>
 *   
 *  @mxml
 *
 *  <p>The <code>&lt;mx:UnconstrainItemAction&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds no new tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:UnconstrainItemAction
 *  /&gt;
 *  </pre>
 *
 *  @see mx.effects.effectClasses.UnconstrainItemActionInstance
 *  @see mx.effects.DefaultTileListEffect
	 */
	public class UnconstrainItemAction extends Effect
	{
		/**
		 *  Constructor.
     *
     *  @param target The Object to animate with this effect.
		 */
		public function UnconstrainItemAction (target:Object = null);

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}
