package mx.controls.treeClasses
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.utils.UIDUtil;

include "../../core/Version.as"
	/**
	 *  @private
 *  This class provides a heirarchical view (a tree-like) view of a standard collection. 
 *  The collection that this Cursor walks across need not be heirarchical but may be flat. 
 *  This class delegates to the ITreeDataDescriptor for information regarding the tree 
 *  structure of the data it walks across. 
 *  
 *  @see HierarchicalCollectionView
	 */
	public class HierarchicalViewCursor extends EventDispatcher implements IViewCursor
	{
		/**
		 *  @private
		 */
		private var dataDescriptor : ITreeDataDescriptor;
		/**
		 *  @private
	 *  Its effective offset into the "array".
		 */
		private var currentIndex : int;
		/**
		 *  @private
	 *  The current index into the childNodes array
		 */
		private var currentChildIndex : int;
		/**
		 *  @private
     *  The depth of the current node.
		 */
		private var _currentDepth : int;
		/**
		 *  @private
	 *  The current set of childNodes we are walking.
		 */
		private var childNodes : Object;
		/**
		 *  @private
	 *  The current set of parentNodes that we have walked from
		 */
		private var parentNodes : Array;
		/**
		 *  @private
	 *  A stack of the currentChildIndex in all parents of the currentNode.
		 */
		private var childIndexStack : Array;
		/**
		 *  @private
     *  The collection that stores the user data
		 */
		private var model : ICollectionView;
		/**
		 *  @private
     *  The collection wrapper of the model
		 */
		private var collection : HierarchicalCollectionView;
		/**
		 *  @private
		 */
		private var openNodes : Object;
		/**
		 *  @private
	 *  Flag indicating model has more data
		 */
		private var more : Boolean;
		/**
		 *  @private
	 *  Cursor from the model
		 */
		private var modelCursor : IViewCursor;
		/**
		 *  @private
		 */
		private var itemToUID : Function;

		/**
		 * @private
		 */
		public function get index () : int;

		/**
		 *  @private
		 */
		public function get bookmark () : CursorBookmark;

		/**
		 *  @private
		 */
		public function get current () : Object;

		/**
		 *  @private
		 */
		public function get currentDepth () : int;

		public function get beforeFirst () : Boolean;

		public function get afterLast () : Boolean;

		public function get view () : ICollectionView;

		/**
		 *  Constructor.
		 */
		public function HierarchicalViewCursor (collection:HierarchicalCollectionView, model:ICollectionView, dataDescriptor:ITreeDataDescriptor, itemToUID:Function, openNodes:Object);

		/**
		 *  @private
     *  Determines if a node is visible on the screen
		 */
		private function isItemVisible (node:Object) : Boolean;

		/**
		 *  @private
     *  Creates a stack of parent nodes by walking upwards
		 */
		private function getParentStack (node:Object) : Array;

		/**
		 *  @private
	 *  When something happens to the tree, find out if it happened
	 *  to children that occur before the current child in the tree walk.
		 */
		private function isNodeBefore (node:Object, currentNode:Object) : Boolean;

		/**
		 *  @private
		 */
		public function findAny (values:Object) : Boolean;

		/**
		 *  @private
		 */
		public function findFirst (values:Object) : Boolean;

		/**
		 *  @private
		 */
		public function findLast (values:Object) : Boolean;

		/**
		 *  @private
     *  Move one node forward from current.  
     *  This may include moving up or down one or more levels.
		 */
		public function moveNext () : Boolean;

		/**
		 *  @private
	 *  Performs a backward tree walk.
		 */
		public function movePrevious () : Boolean;

		/**
		 *  @private
		 */
		public function seek (bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void;

		/**
		 *  @private
		 */
		private function moveToFirst () : void;

		/**
		 *  @private
		 */
		public function moveToLast () : void;

		/**
		 *  @private
		 */
		public function insert (item:Object) : void;

		/**
		 *  @private
		 */
		public function remove () : Object;

		/**
		 *  @private
		 */
		public function collectionChangeHandler (event:CollectionEvent) : void;
	}
}
