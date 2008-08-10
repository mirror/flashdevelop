/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.EventDispatcher;
	public class HierarchicalCollectionView extends EventDispatcher implements IHierarchicalCollectionView {
		/**
		 * A flag that, if true, indicates that the current data provider has a root node;
		 *  for example, a single top-level node in a hierarchical structure.
		 *  XML and Object are examples of data types that have a root node,
		 *  while Lists and Arrays do not.
		 */
		public function get hasRoot():Boolean;
		/**
		 * The length of the currently parsed collection.
		 */
		public function get length():int;
		/**
		 * An Array of Objects containing the data provider element
		 *  for all the open branch nodes of the data.
		 */
		public function get openNodes():Object;
		public function set openNodes(value:Object):void;
		/**
		 * A Boolean flag that specifies whether to display the data provider's root node.
		 *  If the source data has a root node, and this property is set to
		 *  false, the collection will not include the root item.
		 *  Only the descendants of the root item will be included in the collection.
		 */
		public function get showRoot():Boolean;
		public function set showRoot(value:Boolean):void;
		/**
		 * The source data of the IHierarchicalCollectionView.
		 */
		public function get source():IHierarchicalData;
		public function set source(value:IHierarchicalData):void;
		/**
		 * Constructor.
		 *
		 * @param hierarchicalData  <IHierarchicalData (default = null)> The data structure containing the hierarchical data.
		 * @param argOpenNodes      <Object (default = null)> The Object that defines a node to appear as open.
		 */
		public function HierarchicalCollectionView(hierarchicalData:IHierarchicalData = null, argOpenNodes:Object = null);
		/**
		 * Adds a child node to a node of the data.
		 *
		 * @param parent            <Object> The Object that defines the parent node.
		 * @param newChild          <Object> The Object that defines the new node.
		 * @return                  <Boolean> true if the node is added successfully.
		 */
		public function addChild(parent:Object, newChild:Object):Boolean;
		/**
		 * Add a child node to a node at the specified index.
		 *  This implementation does the following:
		 *  If the parent is null or undefined,
		 *  inserts the child at the
		 *  specified index in the collection specified
		 *  by source.
		 *  If the parent has a children
		 *  field or property, the method adds the child
		 *  to it at the index location.
		 *  In this case, the source is not required.
		 *  If the parent does not have a children
		 *  field or property, the method adds the children
		 *  to the parent. The method then adds the
		 *  child to the parent at the
		 *  index location.
		 *  In this case, the source is not required.
		 *  If the index value is greater than the collection
		 *  length or number of children in the parent, adds the object as
		 *  the last child.
		 *
		 * @param parent            <Object> The Object that defines the parent node.
		 * @param newChild          <Object> The Object that defines the child node.
		 * @param index             <int> The 0-based index of where to insert the child node.
		 * @return                  <Boolean> true if the child is added successfully.
		 */
		public function addChildAt(parent:Object, newChild:Object, index:int):Boolean;
		/**
		 * Closes a node to hide its children.
		 *
		 * @param node              <Object> The Object that defines the node.
		 */
		public function closeNode(node:Object):void;
		/**
		 * Checks the collection for the data item using standard equality test.
		 *
		 * @param item              <Object> The Object that defines the node to look for.
		 * @return                  <Boolean> true if the data item is in the collection,
		 *                            and false if not.
		 */
		public function contains(item:Object):Boolean;
		/**
		 * Returns a new instance of a view iterator over the items in this view.
		 *
		 * @return                  <IViewCursor> IViewCursor instance.
		 */
		public function createCursor():IViewCursor;
		/**
		 * Returns the depth of the node in the collection.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @return                  <int> The depth of the node.
		 */
		public function getNodeDepth(node:Object):int;
		/**
		 * Returns the parent of a node.
		 *  The parent of a top-level node is null.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @return                  <*> The parent node containing the node,
		 *                            null for a top-level node,
		 *                            and undefined if the parent cannot be determined.
		 */
		public function getParentItem(node:Object):*;
		/**
		 * Opens a node to display its children.
		 *
		 * @param node              <Object> The Object that defines the node.
		 */
		public function openNode(node:Object):void;
		/**
		 * Removes the child node from the parent node.
		 *
		 * @param parent            <Object> The Object that defines the parent node,
		 *                            and null for top-level nodes.
		 * @param child             <Object> The Object that defines the child node to be removed.
		 * @return                  <Boolean> true if the node is removed successfully.
		 */
		public function removeChild(parent:Object, child:Object):Boolean;
		/**
		 * Removes the child node from a node at the specified index.
		 *
		 * @param parent            <Object> The Object that defines the parent node.
		 * @param index             <int> The 0-based index of  the child node to remove relative to the parent.
		 * @return                  <Boolean> true if the child is removed successfully.
		 */
		public function removeChildAt(parent:Object, index:int):Boolean;
		/**
		 * Called whenever an XML object contained in our list is updated
		 *  in some way.  The initial implementation stab is very lenient,
		 *  any changeType will cause an update no matter how much further down
		 *  in a hierarchy.
		 *
		 * @param currentTarget     <Object> 
		 * @param type              <String> 
		 * @param target            <Object> 
		 * @param value             <Object> 
		 * @param detail            <Object> 
		 */
		public function xmlNotification(currentTarget:Object, type:String, target:Object, value:Object, detail:Object):void;
	}
}
