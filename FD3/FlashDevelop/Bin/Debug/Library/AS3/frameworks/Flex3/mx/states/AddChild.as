/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	import flash.display.DisplayObject;
	import mx.core.IDeferredInstance;
	import mx.core.UIComponent;
	public class AddChild implements IOverride {
		/**
		 * The creation policy for this child.
		 *  This property determines when the targetFactory will create
		 *  the instance of the child.
		 *  Flex uses this properthy only if you specify a targetFactory property.
		 */
		public function get creationPolicy():String;
		public function set creationPolicy(value:String):void;
		/**
		 * The position of the child in the display list, relative to the
		 *  object specified by the relativeTo property.
		 *  Valid values are "before", "after",
		 *  "firstChild", and "lastChild".
		 */
		public var position:String;
		/**
		 * The object relative to which the child is added. This property is used
		 *  in conjunction with the position property.
		 *  This property is optional; if
		 *  you omit it, Flex uses the immediate parent of the State
		 *  object, that is, the component that has the states
		 *  property, or <mx:states>tag that specifies the State
		 *  object.
		 */
		public var relativeTo:UIComponent;
		/**
		 * The child to be added.
		 *  If you set this property, the child instance is created at app startup.
		 *  Setting this property is equivalent to setting a targetFactory
		 *  property with a creationPolicy of "all".
		 */
		public function get target():DisplayObject;
		public function set target(value:DisplayObject):void;
		/**
		 * The factory that creates the child. You can specify either of the following items:
		 *  A factory class that implements the IDeferredInstance
		 *  interface and creates the child instance or instances.
		 *  A Flex component, (that is, any class that is a subclass
		 *  of the UIComponent class), such as the Button contol.
		 *  If you use a Flex component, the Flex compiler automatically
		 *  wraps the component in a factory class.
		 */
		public function get targetFactory():IDeferredInstance;
		public function set targetFactory(value:IDeferredInstance):void;
		/**
		 * Constructor.
		 *
		 * @param relativeTo        <UIComponent (default = null)> The component relative to which child is added.
		 * @param target            <DisplayObject (default = null)> The child object.
		 *                            All Flex components are subclasses of the DisplayObject class.
		 * @param position          <String (default = "lastChild")> the location in the display list of the target
		 *                            relative to the relativeTo component. Must be one of the following:
		 *                            "firstChild", "lastChild", "before" or "after".
		 */
		public function AddChild(relativeTo:UIComponent = null, target:DisplayObject = null, position:String = "lastChild");
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
		 * Creates the child instance from the factory.
		 *  You must use this method only if you specify a targetFactory
		 *  property and a creationPolicy value of "none".
		 *  Flex automatically calls this method if the creationPolicy
		 *  property value is "auto" or "all".
		 *  If you call this method multiple times, the child instance is
		 *  created only on the first call.
		 */
		public function createInstance():void;
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
