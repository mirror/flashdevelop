/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.IEventDispatcher;
	public interface IHierarchicalCollectionView extends ICollectionView, IEventDispatcher {
		/**
		 * A flag that, if true, indicates that the current data provider has a root node;
		 *  for example, a single top-level node in a hierarchical structure.
		 *  XML and Object are examples of data types that have a root node,
		 *  while Lists and Arrays do not.
		 */
		public function get hasRoot():Boolean;
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
		 * Adds a child node to a node of the data.
		 *
		 * @param parent            <Object> The Object that defines the parent node.
		 * @param newChild          <Object> The Object that defines the new node.
		 * @return                  <Boolean> true if the node is added successfully.
		 */
		public function addChild(parent:Object, newChild:Object):Boolean;
		/**
		 * Adds a child node to a node of the data at a specific index in the data.
		 *
		 * @param parent            <Object> The Object that defines the parent node.
		 * @param newChild          <Object> The Object that defines the new node.
		 * @param index             <int> The zero-based index of where to insert the child node.
		 * @return                  <Boolean> true if the node is added successfully.
		 */
		public function addChildAt(parent:Object, newChild:Object, index:int):Boolean;
		/**
		 * Closes a node to hide its children.
		 *
		 * @param node              <Object> The Object that defines the node.
		 */
		public function closeNode(node:Object):void;
		/**
		 * Returns a collection of children, if they exist.
		 *
		 * @param node              <Object> The Object that defines the node.
		 *                            If null, return a collection of top level nodes.
		 * @return                  <ICollectionView> ICollectionView instance containing the child nodes.
		 */
		public function getChildren(node:Object):ICollectionView;
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
		 * @return                  <*> The parent node containing the node as child,
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
		 * @param parent            <Object> The node object that currently parents the child node.
		 *                            Set parent to null for top-level nodes.
		 * @param index             <int> The zero-based index of the child node to remove relative to the parent.
		 * @return                  <Boolean> true if successful, and false if not.
		 */
		public function removeChildAt(parent:Object, index:int):Boolean;
	}
}
