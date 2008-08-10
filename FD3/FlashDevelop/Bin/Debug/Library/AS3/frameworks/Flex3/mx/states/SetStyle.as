/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	import mx.styles.IStyleClient;
	import mx.core.UIComponent;
	public class SetStyle implements IOverride {
		/**
		 * The name of the style to change.
		 *  You must set this property, either in
		 *  the SetStyle constructor or by setting
		 *  the property value directly.
		 */
		public var name:String;
		/**
		 * The object whose style is being changed.
		 *  If the property value is null, Flex uses the
		 *  immediate parent of the State object.
		 */
		public var target:IStyleClient;
		/**
		 * The new value for the style.
		 */
		public var value:Object;
		/**
		 * Constructor.
		 *
		 * @param target            <IStyleClient (default = null)> The object whose style is being set.
		 *                            By default, Flex uses the immediate parent of the State object.
		 * @param name              <String (default = null)> The style to set.
		 * @param value             <Object (default = null)> The value of the style in the view state.
		 */
		public function SetStyle(target:IStyleClient = null, name:String = null, value:Object = null);
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
