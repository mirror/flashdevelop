/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	import mx.core.UIComponent;
	public class SetProperty implements IOverride {
		/**
		 * The name of the property to change.
		 *  You must set this property, either in
		 *  the SetProperty constructor or by setting
		 *  the property value directly.
		 */
		public var name:String;
		/**
		 * The object containing the property to be changed.
		 *  If the property value is null, Flex uses the
		 *  immediate parent of the State object.
		 */
		public var target:Object;
		/**
		 * The new value for the property.
		 */
		public var value:*;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The object whose property is being set.
		 *                            By default, Flex uses the immediate parent of the State object.
		 * @param name              <String (default = null)> The property to set.
		 * @param value             <* (default = NaN)> The value of the property in the view state.
		 */
		public function SetProperty(target:Object = null, name:String = null, value:*);
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
