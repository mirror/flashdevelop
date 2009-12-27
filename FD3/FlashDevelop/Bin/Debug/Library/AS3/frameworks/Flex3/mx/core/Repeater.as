package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.ItemResponder;
	import mx.collections.ListCollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.automation.IAutomationObject;

	/**
	 *  Dispatched each time an item is processed and the 
 *  <code>currentIndex</code> and <code>currentItem</code> 
 *  properties are updated.
 *
 *  @eventType mx.events.FlexEvent.REPEAT
	 */
	[Event(name="repeat", type="mx.events.FlexEvent")] 

	/**
	 *  Dispatched after all the subcomponents of a repeater are created.
 *  This event is triggered even if the <code>dataProvider</code>
 *  property is empty or <code>null</code>.
 *
 *  @eventType mx.events.FlexEvent.REPEAT_END
	 */
	[Event(name="repeatEnd", type="mx.events.FlexEvent")] 

	/**
	 *  Dispatched when Flex begins processing the <code>dataProvider</code>
 *  property and begins creating the specified subcomponents.
 *  This event is triggered even if the <code>dataProvider</code>
 *  property is empty or <code>null</code>.
 *
 *  @eventType mx.events.FlexEvent.REPEAT_START
	 */
	[Event(name="repeatStart", type="mx.events.FlexEvent")] 

include "../core/Version.as"
	/**
	 *  The Repeater class is the runtime object that corresponds
 *  to the <code>&lt;mx:Repeater&gt;</code> tag.
 *  It creates multiple instances of its subcomponents
 *  based on its dataProvider.
 *  The repeated components can be any standard or custom
 *  controls or containers.
 *
 *  <p>You can use the <code>&lt;mx:Repeater&gt;</code> tag
 *  anywhere a control or container tag is allowed, with the exception
 *  of the <code>&lt;mx:Application&gt;</code> container tag.
 *  To repeat a user interface component, you place its tag
 *  in the <code>&lt;mx:Repeater&gt;</code> tag.
 *  You can use more than one <code>&lt;mx:Repeater&gt;</code> tag
 *  in an MXML document.
 *  You can also nest <code>&lt;mx:Repeater&gt;</code> tags.</p>
 *
 *  <p>You cannot use the <code>&lt;mx:Repeater&gt;</code> tag
 *  for objects that do not extend the UIComponent class.</p>
 *
 *  @mxml
 *
 *  <p>The &lt;Repeater&gt; class has the following properties:</p>
 *
 *  <pre>
 *  &lt;mx:Repeater
 *    <strong>Properties</strong>
 *    id="<i>No default</i>"
 *    childDescriptors="<i>No default</i>"
 *    count="<i>No default</i>"
 *    dataProvider="<i>No default</i>"
 *    recycleChildren="false|true"
 *    startingIndex="0"
 *
 *    <strong>Events</strong>
 *    repeat="<i>No default</i>"
 *    repeatEnd="<i>No default</i>"
 *    repeatStart="<i>No default</i>"
 *  &gt;
 *  </pre>
 *
 *  @includeExample examples/RepeaterExample.mxml
 *
 *  @see mx.core.Container
 *  @see mx.core.UIComponent
 *  @see mx.core.UIComponentDescriptor
 *  @see flash.events.EventDispatcher
	 */
	public class Repeater extends UIComponent implements IRepeater
	{
		/**
		 *  @private
		 */
		private var iterator : IViewCursor;
		/**
		 *  @private
     *  Flag indicating whether this Repeater has been fully created.
     *  Used to avoid createComponentFromDescriptor() calling execute().
		 */
		private var created : Boolean;
		/**
		 *  @private
     *  The index of this Repeater's UIComponentDescriptor in the
     *  container's child descriptors.
		 */
		private var descriptorIndex : int;
		/**
		 *  @private
     *  The Array of components created during the previous execution.
     *  This array is used during recycle().
     * 
     *  mx_internal for automation delegate access
		 */
		var createdComponents : Array;
		/**
		 *  An Array of UIComponentDescriptor objects for this Repeater's children.
		 */
		public var childDescriptors : Array;
		/**
		 *  @private
     *  Storage for the 'container' read-only property.
     *  Initialized by the constructor.
		 */
		private var _container : Container;
		/**
		 *  @private
     *  Storage for the 'count' property.
		 */
		private var _count : int;
		/**
		 *  @private
     *  Storage for the 'currentIndex' property.
		 */
		private var _currentIndex : int;
		/**
		 *  @private
     *  Storage for the 'dataProvider' property.
		 */
		private var collection : ICollectionView;
		/**
		 *  @private
     *  Storage for the recycleChildren property.
		 */
		private var _recycleChildren : Boolean;
		/**
		 *  @private
     *  Storage for the 'startingIndex' property.
		 */
		private var _startingIndex : int;

		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;

		/**
		 *  The container that contains this Repeater.
		 */
		public function get container () : IContainer;

		/**
		 * @inheritDoc
		 */
		public function get count () : int;
		/**
		 *  @private
		 */
		public function set count (value:int) : void;

		/**
		 * @inheritDoc
		 */
		public function get currentIndex () : int;

		/**
		 * @inheritDoc
		 */
		public function get currentItem () : Object;

		/**
		 * @inheritDoc
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  @private
		 */
		private function get numCreatedChildren () : int;

		/**
		 * @inheritDoc
		 */
		public function get recycleChildren () : Boolean;
		/**
		 *  @private
		 */
		public function set recycleChildren (value:Boolean) : void;

		/**
		 * @inheritDoc
		 */
		public function get startingIndex () : int;
		/**
		 *  @private
		 */
		public function set startingIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function Repeater ();

		/**
		 *  @private
		 */
		public function toString () : String;

		/**
		 * @inheritDoc
		 */
		public function initializeRepeater (container:IContainer, recurse:Boolean) : void;

		/**
		 * @inheritDoc
		 */
		public function executeChildBindings () : void;

		/**
		 *  @private
     *  Used by data binding code generation.
		 */
		function getItemAt (index:int) : Object;

		/**
		 *  @private
		 */
		private function responderResultHandler (data:Object, info:Object) : void;

		/**
		 *  @private
		 */
		private function responderFaultHandler (data:Object, info:Object) : void;

		/**
		 *  @private
     *  Determines whether the specified UIComponent or Repeater
     *  is inside this Repeater, by searching its 'repeaters' array.
     *
     *  The methods removeAllChildren() and removeAllChildRepeaters()
     *  use this to determine which child UIComponents and child Repeaters
     *  of this Repeater's container should be removed, since some of
     *  the container's children may be outside this Repeater.
		 */
		private function hasDescendant (o:Object) : Boolean;

		/**
		 *  @private
     *  Removes all the child UIComponents in this Repeater's container
     *  which belong to this Repeater. Returns the lowest index of the
     *  removed children, or null if none were removed.
     *
     *  The method execute() uses this to clean up previously created
     *  child UIComponents when this Repeater's dataProvider, startingIndex,
     *  or count changes.
		 */
		private function removeAllChildren (container:IContainer) : void;

		/**
		 *  @private
     *  Removes all the child Repeaters in this Repeater's container
     *  which belong to this Repeater.
     *
     *  The method execute() uses this to clean up previously created
     *  child Repeaters when this Repeater's dataProvider, startingIndex,
     *  or count changes.
		 */
		private function removeAllChildRepeaters (container:Container) : void;

		/**
		 *  @private
		 */
		private function removeChildRepeater (container:Container, repeater:Repeater) : void;

		/**
		 *  @private
		 */
		private function createComponentFromDescriptor (instanceIndex:int, descriptorIndex:int, recurse:Boolean) : IFlexDisplayObject;

		/**
		 *  @private
     *  Create repeated instances of the UIComponents and Repeaters
     *  that are owned by this Repeater, based on its dataProvider.
     *
     *  This method is the heart of the Repeater class. It is called
     *  when this repeater is created by createComponentFromDescriptor(),
     *  and when this Repeater gets re-executed when its dataProvider,
     *  startingIndex, or count changes.
		 */
		private function createComponentsFromDescriptors (recurse:Boolean) : void;

		/**
		 *  @private
     *  This method is used by execute() to determine where the newly-created
     *  UIComponents should be inserted in the container.
		 */
		private function getIndexForFirstChild () : int;

		/**
		 *  @private
		 */
		private function getIndexForRepeater (target:Repeater, locationInfo:LocationInfo) : void;

		/**
		 *  @private
     *  This method is used by execute() to move the newly-created UIComponents,
     *  which get created at the end of the container, to their proper indexes
     *  in the container.
		 */
		private function reindexDescendants (from:int, to:int) : void;

		/**
		 *  @private
		 */
		private function resetRepeaterIndices (o:IRepeaterClient, index:int) : void;

		/**
		 *  @private
		 */
		private function recycle () : void;

		/**
		 *  @private
		 */
		private function recreate () : void;

		/**
		 *  @private
     *  Execute this Repeater a second time, after its dataProvider,
     *  startingIndex, or count changes.
		 */
		private function execute () : void;

		/**
		 *  @private
     *  Handles "Change" event sent by calls to Collection APIs
     *  on this Repeater's dataProvider.
		 */
		private function collectionChangedHandler (collectionEvent:CollectionEvent) : void;

		/**
		 *  @private
		 */
		private function addItems (firstIndex:int, lastIndex:int) : void;

		/**
		 *  @private
		 */
		private function removeItems (firstIndex:int, lastIndex:int) : void;

		/**
		 *  @private
		 */
		private function removeRepeater (repeater:Repeater) : void;

		/**
		 *  @private
		 */
		private function updateItems (firstIndex:int, lastIndex:int) : void;

		/**
		 *  @private
		 */
		private function sort () : void;

		/**
		 *  @private
		 */
		private function getRepeaterIndex (o:IRepeaterClient) : int;

		/**
		 *  @private
		 */
		private function adjustIndices (o:IRepeaterClient, adjustment:int) : void;

		/**
		 *  @private
     *  This function is like Math.min(),
     *  but if x is negative, it is ignored.
     *  If y is negative, it is ignored.
     *  If both are negative, zero is returned.
		 */
		private function positiveMin (x:int, y:int) : int;
	}
	/**
	 *  @private
	 */
	private class LocationInfo
	{
		/**
		 *  @private
		 */
		public var found : Boolean;
		/**
		 *  @private
		 */
		public var index : int;

		/**
		 *  @private
		 */
		public function LocationInfo ();
	}
}
