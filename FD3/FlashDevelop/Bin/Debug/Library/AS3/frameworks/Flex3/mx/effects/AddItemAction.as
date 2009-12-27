package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.effects.effectClasses.AddItemActionInstance;
	import mx.controls.listClasses.ListBase;

	[Exclude(name="duration", kind="property")] 

include "../core/Version.as"
	/**
	 *  The AddItemAction class defines an action effect that determines 
 *  when the item renderer appears in the control for an item being added 
 *  to a list-based control, such as List or TileList, 
 *  or for an item that replaces an existing item in the control.
 *  You can use this class as part of defining custom data effect for the 
 *  list-based classes.
 *   
 *  @mxml
 *
 *  <p>The <code>&lt;mx:AddItemAction&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds no new tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:AddItemAction
 *  /&gt;
 *  </pre>
 *
 *  @see mx.effects.effectClasses.AddItemActionInstance
 *
 *  @includeExample examples/AddItemActionEffectExample.mxml
	 */
	public class AddItemAction extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;

		/**
		 *  Constructor.
     *
     *  @param target The Object to animate with this effect.
		 */
		public function AddItemAction (target:Object = null);

		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}
