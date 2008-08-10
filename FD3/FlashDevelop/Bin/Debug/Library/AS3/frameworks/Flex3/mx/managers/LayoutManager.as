/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import flash.events.EventDispatcher;
	public class LayoutManager extends EventDispatcher implements ILayoutManager {
		/**
		 * A flag that indicates whether the LayoutManager allows screen updates
		 *  between phases.
		 *  If true, measurement and layout are done in phases, one phase
		 *  per screen update.
		 *  All components have their validateProperties()
		 *  and commitProperties() methods
		 *  called until all their properties are validated.
		 *  The screen will then be updated.
		 */
		public function get usePhasedInstantiation():Boolean;
		public function set usePhasedInstantiation(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function LayoutManager();
		/**
		 * Returns the sole instance of this singleton class,
		 *  creating it if it does not already exist.
		 */
		public static function getInstance():LayoutManager;
		/**
		 * Called when a component changes in some way that its layout and/or visuals
		 *  need to be changed.
		 *  In that case, it is necessary to run the component's layout algorithm,
		 *  even if the component's size hasn't changed.  For example, when a new child component
		 *  is added, or a style property changes or the component has been given
		 *  a new size by its parent.
		 *
		 * @param obj               <ILayoutManagerClient> The object that changed.
		 */
		public function invalidateDisplayList(obj:ILayoutManagerClient):void;
		/**
		 * Adds an object to the list of components that want their
		 *  validateProperties() method called.
		 *  A component should call this method when a property changes.
		 *  Typically, a property setter method
		 *  stores a the new value in a temporary variable and calls
		 *  the invalidateProperties() method
		 *  so that its validateProperties()
		 *  and commitProperties() methods are called
		 *  later, when the new value will actually be applied to the component and/or
		 *  its children.  The advantage of this strategy is that often, more than one
		 *  property is changed at a time and the properties may interact with each
		 *  other, or repeat some code as they are applied, or need to be applied in
		 *  a specific order.  This strategy allows the most efficient method of
		 *  applying new property values.
		 *
		 * @param obj               <ILayoutManagerClient> The object whose property changed.
		 */
		public function invalidateProperties(obj:ILayoutManagerClient):void;
		/**
		 * Adds an object to the list of components that want their
		 *  validateSize() method called.
		 *  Called when an object's size changes.
		 *
		 * @param obj               <ILayoutManagerClient> The object whose size changed.
		 */
		public function invalidateSize(obj:ILayoutManagerClient):void;
		/**
		 * Returns true if there are components that need validating;
		 *  false if all components have been validated.
		 */
		public function isInvalid():Boolean;
		/**
		 * When properties are changed, components generally do not apply those changes immediately.
		 *  Instead the components usually call one of the LayoutManager's invalidate methods and
		 *  apply the properties at a later time.  The actual property you set can be read back
		 *  immediately, but if the property affects other properties in the component or its
		 *  children or parents, those other properties may not be immediately updated.
		 *
		 * @param target            <ILayoutManagerClient> The component passed in is used to test which components
		 *                            should be validated.  All components contained by this component will have their
		 *                            validateProperties(), commitProperties(),
		 *                            validateSize(), measure(),
		 *                            validateDisplayList(),
		 *                            and updateDisplayList() methods called.
		 * @param skipDisplayList   <Boolean (default = false)> If true,
		 *                            does not call the validateDisplayList()
		 *                            and updateDisplayList() methods.
		 */
		public function validateClient(target:ILayoutManagerClient, skipDisplayList:Boolean = false):void;
		/**
		 * When properties are changed, components generally do not apply those changes immediately.
		 *  Instead the components usually call one of the LayoutManager's invalidate methods and
		 *  apply the properties at a later time.  The actual property you set can be read back
		 *  immediately, but if the property affects other properties in the component or its
		 *  children or parents, those other properties may not be immediately updated.  To
		 *  guarantee that the values are updated, you can call the validateNow() method.
		 *  It updates all properties in all components before returning.
		 *  Call this method only when necessary as it is a computationally intensive call.
		 */
		public function validateNow():void;
	}
}
