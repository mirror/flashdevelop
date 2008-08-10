/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	import mx.core.UIComponent;
	public interface IOverride {
		/**
		 * Applies the override. Flex retains the original value, so that it can
		 *  restore the value later in the remove() method.
		 *
		 * @param parent            <UIComponent> The parent of the state object containing this override.
		 *                            The override should use this as its target if an explicit target was
		 *                            not specified.
		 */
		public function apply(parent:UIComponent):void;
		/**
		 * Initializes the override.
		 *  Flex calls this method before the first call to the
		 *  apply() method, so you put one-time initialization
		 *  code for the override in this method.
		 */
		public function initialize():void;
		/**
		 * Removes the override. The value remembered in the apply()
		 *  method is restored.
		 *
		 * @param parent            <UIComponent> The parent of the state object containing this override.
		 *                            The override should use this as its target if an explicit target was
		 *                            not specified.
		 */
		public function remove(parent:UIComponent):void;
	}
}
