/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	public interface ILayoutManagerClient extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout validation (provided that any were required)
		 *  This flag should only be modified by the LayoutManager.
		 */
		public function get initialized():Boolean;
		public function set initialized(value:Boolean):void;
		/**
		 * The top-level SystemManager has a nestLevel of 1.
		 *  Its immediate children (the top-level Application and any pop-up
		 *  windows) have a nestLevel of 2.
		 *  Their children have a nestLevel of 3, and so on.
		 *  The nestLevel is used to sort ILayoutManagerClients
		 *  during the measurement and layout phases.
		 *  During the commit phase, the LayoutManager commits properties on clients
		 *  in order of decreasing nestLevel, so that an object's
		 *  children have already had their properties committed before Flex
		 *  commits properties on the object itself.
		 *  During the measurement phase, the LayoutManager measures clients
		 *  in order of decreasing nestLevel, so that an object's
		 *  children have already been measured before Flex measures
		 *  the object itself.
		 *  During the layout phase, the LayoutManager lays out clients
		 *  in order of increasing nestLevel, so that an object
		 *  has a chance to set the sizes of its children before the child
		 *  objects are asked to position and size their children.
		 */
		public function get nestLevel():int;
		public function set nestLevel(value:int):void;
		/**
		 * Set to true after immediate or deferred child creation,
		 *  depending on which one happens. For a Container object, it is set
		 *  to true at the end of
		 *  the createComponentsFromDescriptors() method,
		 *  meaning after the Container object creates its children from its child descriptors.
		 */
		public function get processedDescriptors():Boolean;
		public function set processedDescriptors(value:Boolean):void;
		/**
		 * A flag that determines if an object is waiting to have its
		 *  updateComplete event dispatched.
		 *  This flag should only be modified by the LayoutManager.
		 */
		public function get updateCompletePendingFlag():Boolean;
		public function set updateCompletePendingFlag(value:Boolean):void;
		/**
		 * Validates the position and size of children and draws other
		 *  visuals.
		 *  If the LayoutManager.invalidateDisplayList() method is called with
		 *  this ILayoutManagerClient, then the validateDisplayList() method
		 *  is called when it's time to update the display list.
		 */
		public function validateDisplayList():void;
		/**
		 * Validates the properties of a component.
		 *  If the LayoutManager.invalidateProperties() method is called with
		 *  this ILayoutManagerClient, then the validateProperties() method
		 *  is called when it's time to commit property values.
		 */
		public function validateProperties():void;
		/**
		 * Validates the measured size of the component
		 *  If the LayoutManager.invalidateSize() method is called with
		 *  this ILayoutManagerClient, then the validateSize() method
		 *  is called when it's time to do measurements.
		 *
		 * @param recursive         <Boolean (default = false)> If true, call this method
		 *                            on the objects children.
		 */
		public function validateSize(recursive:Boolean = false):void;
	}
}
