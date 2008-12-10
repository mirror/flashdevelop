package mx.controls.treeClasses
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.XMLListAdapter;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.core.EventPriority;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.utils.IXMLNotifiable;
	import mx.utils.XMLNotifier;

	/**
	 *  @private *  This class provides a hierarchical view of a standard collection. *  It is used by Tree to parse user data.
	 */
	public class HierarchicalCollectionView extends EventDispatcher implements ICollectionView
	{
		/**
		 *  @private
		 */
		private var dataDescriptor : ITreeDataDescriptor;
		/**
		 *  @private
		 */
		private var treeData : ICollectionView;
		/**
		 *  @private
		 */
		private var cursor : HierarchicalViewCursor;
		/**
		 *  @private	 *  The total number of nodes we know about.
		 */
		private var currentLength : int;
		/**
		 *  @private
		 */
		public var openNodes : Object;
		/**
		 *  @private	 *  Mapping of UID to parents.  Must be maintained as things get removed/added	 *  This map is created as objects are visited
		 */
		public var parentMap : Object;
		/**
		 *  @private	 *  Top level XML node if there is one
		 */
		private var parentNode : XML;
		/**
		 *  @private	 *  Mapping of nodes to children.  Used by getChildren.
		 */
		private var childrenMap : Dictionary;
		/**
		 *  @private
		 */
		private var itemToUID : Function;

		/**
		 *  Not Supported in Tree.
		 */
		public function get filterFunction () : Function;
		/**
		 *  Not Supported in Tree.
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  The length of the currently parsed collection.  This     *  length only includes nodes that we know about.
		 */
		public function get length () : int;
		/**
		 *  @private     *  Not Supported in Tree.
		 */
		public function get sort () : Sort;
		/**
		 *  @private     *  Not Supported in Tree.
		 */
		public function set sort (value:Sort) : void;

		/**
		 *  Constructor.
		 */
		public function HierarchicalCollectionView (model:ICollectionView, treeDataDescriptor:ITreeDataDescriptor, itemToUID:Function, argOpenNodes:Object = null);
		/**
		 *  Returns the parent of a node.  Top level node's parent is null	 *  If we don't know the parent we return undefined.
		 */
		public function getParentItem (node:Object) : *;
		/**
		 *  @private	 *  Calculate the total length of the collection, but only count nodes	 *  that we can reach.
		 */
		public function calculateLength (node:Object = null, parent:Object = null) : int;
		/**
		 *  @private	 *  This method is merely for ICollectionView interface compliance.
		 */
		public function describeData () : Object;
		/**
		 *  Returns a new instance of a view iterator over the items in this view	 *     *  @see mx.utils.IViewCursor
		 */
		public function createCursor () : IViewCursor;
		/**
		 *  Checks the collection for item using standard equality test.
		 */
		public function contains (item:Object) : Boolean;
		/**
		 *  @private
		 */
		public function disableAutoUpdate () : void;
		/**
		 *  @private
		 */
		public function enableAutoUpdate () : void;
		/**
		 *  @private
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 *  @private
		 */
		public function refresh () : Boolean;
		/**
		 * @private	 * delegate getchildren in order to add event listeners for nested collections
		 */
		private function getChildren (node:Object) : ICollectionView;
		/**
		 * @private	 * Force a recalulation of length
		 */
		private function updateLength (node:Object = null, parent:Object = null) : void;
		/**
		 * @private	 *  Fill the node array with the node and all of its visible children	 *  update the parentMap as you go.
		 */
		private function getVisibleNodes (node:Object, parent:Object, nodeArray:Array) : void;
		/**
		 *  @private	 *  Factor in the open children before this location in the model
		 */
		private function getVisibleLocation (oldLocation:int) : int;
		/**
		 * @private	 * factor in the open children before this location in a sub collection
		 */
		private function getVisibleLocationInSubCollection (parent:Object, oldLocation:int) : int;
		/**
		 *  @private
		 */
		public function collectionChangeHandler (event:CollectionEvent) : void;
		/**
		 *  @private
		 */
		public function nestedCollectionChangeHandler (event:CollectionEvent) : void;
		/**
		 * Called whenever an XML object contained in our list is updated     * in some way.  The initial implementation stab is very lenient,     * any changeType will cause an update no matter how much further down     * in a hierarchy.
		 */
		public function xmlNotification (currentTarget:Object, type:String, target:Object, value:Object, detail:Object) : void;
		/**
		 *  This is called by addItemAt and when the source is initially     *  assigned.
		 */
		private function startTrackUpdates (item:Object) : void;
		/**
		 *  This is called by removeItemAt, removeAll, and before a new     *  source is assigned.
		 */
		private function stopTrackUpdates (item:Object) : void;
		/**
		 *  @private
		 */
		public function expandEventHandler (event:CollectionEvent) : void;
	}
}
