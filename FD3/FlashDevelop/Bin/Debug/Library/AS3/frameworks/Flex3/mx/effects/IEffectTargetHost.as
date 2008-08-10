/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public interface IEffectTargetHost {
		/**
		 * Adds an item renderer if a data change effect is running.
		 *  The item renderer should correspond to a recently added
		 *  data item in the data provider's collection that isn't
		 *  yet being displayed.
		 *
		 * @param target            <Object> The item renderer to add to the control's layout.
		 */
		public function addDataEffectItem(target:Object):void;
		/**
		 * Returns true or false
		 *  to indicates whether the effect should play on the target.
		 *  The EffectTargetFilter class calls this method when you set
		 *  the filter property on a data effect.
		 *  For example, you set filter property
		 *  to addItem or removeItem.
		 *
		 * @param target            <Object> An item renderer
		 * @param semanticProperty  <String> The semantic property of the renderer
		 *                            whose value will be returned.
		 * @return                  <Object> true or false
		 *                            to indicates whether the effect should play on the target.
		 */
		public function getRendererSemanticValue(target:Object, semanticProperty:String):Object;
		/**
		 * Removes an item renderer if a data change effect is running.
		 *  The item renderer must correspond to data that has already
		 *  been removed from the data provider collection.
		 *  This function will be called by a RemoveItemAction
		 *  effect as part of a data change effect to specify the point
		 *  at which a data item ceases to displayed by the control using
		 *  an item renderer.
		 *
		 * @param target            <Object> The item renderer to remove from the control's layout.
		 */
		public function removeDataEffectItem(target:Object):void;
		/**
		 * Called by an UnconstrainItemAction effect
		 *  as part of a data change effect if the item renderers corresponding
		 *  to certain data items need to move outside the normal positions
		 *  of item renderers in the control.
		 *  The control does not attempt to position the item render for the
		 *  duration of the effect.
		 *
		 * @param item              <Object> The item renderer that is a target of the effect.
		 */
		public function unconstrainRenderer(item:Object):void;
	}
}
