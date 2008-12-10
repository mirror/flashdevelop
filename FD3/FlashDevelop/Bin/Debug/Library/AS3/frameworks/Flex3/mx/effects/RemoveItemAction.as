package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.effects.effectClasses.RemoveItemActionInstance;
	import mx.controls.listClasses.ListBase;

	/**
	 *  The RemoveItemAction class defines an action effect that determines  *  when the item renderer disappears from the control for the item renderer  *  of an item being removed from a list-based control, such as List or TileList,  *  or for an item that is replaced by a new item added to the control.  *  You can use this class as part of defining custom data effect for the  *  list-based classes. *    *  @mxml * *  <p>The <code>&lt;mx:RemoveItemAction&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds no new tag attributes:</p> * *  <pre> *  &lt;mx:RemoveItemAction *  /&gt; *  </pre> * *  @see mx.effects.effectClasses.RemoveItemActionInstance * *  @includeExample examples/AddItemActionEffectExample.mxml
	 */
	public class RemoveItemAction extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;

		/**
		 *  Constructor.     *     *  @param target The Object to animate with this effect.
		 */
		public function RemoveItemAction (target:Object = null);
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
