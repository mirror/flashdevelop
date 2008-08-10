/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.treeClasses {
	public interface ITreeDataDescriptor {
		/**
		 * Adds a child node to a node at the specified index.
		 *
		 * @param parent            <Object> The node object that will parent the child.
		 * @param newChild          <Object> The node object that will be parented by the node.
		 * @param index             <int> The 0-based index of where to put the child node.
		 * @param model             <Object (default = null)> The entire collection that this node is a part of
		 * @return                  <Boolean> true if successful.
		 */
		public function addChildAt(parent:Object, newChild:Object, index:int, model:Object = null):Boolean;
		/**
		 * Provides access to a node's children, returning a collection
		 *  view of children if they exist.
		 *  A node can return any object in the collection as its children;
		 *  children need not be nested.
		 *  It is best-practice to return the same collection view for a
		 *  given node.
		 *
		 * @param node              <Object> The node object currently being evaluated.
		 * @param model             <Object (default = null)> The entire collection that this node is a part of.
		 * @return                  <ICollectionView> An collection view containing the child nodes.
		 */
		public function getChildren(node:Object, model:Object = null):ICollectionView;
		/**
		 * Gets the data from a node.
		 *
		 * @param node              <Object> The node object from which to get the data.
		 * @param model             <Object (default = null)> The collection that contains the node.
		 * @return                  <Object> Object The requested data.
		 */
		public function getData(node:Object, model:Object = null):Object;
		/**
		 * Tests for the existence of children in a non-terminating node.
		 *
		 * @param node              <Object> 
		 * @param model             <Object (default = null)> 
		 */
		public function hasChildren(node:Object, model:Object = null):Boolean;
		/**
		 * Tests a node for termination.
		 *  Branches are non-terminating but are not required
		 *  to have any leaf nodes.
		 *
		 * @param node              <Object> The node object currently being evaluated.
		 * @param model             <Object (default = null)> The entire collection that this node is a part of.
		 * @return                  <Boolean> A Boolean indicating if this node is non-terminating.
		 */
		public function isBranch(node:Object, model:Object = null):Boolean;
		/**
		 * Removes a child node to a node at the specified index.
		 *
		 * @param parent            <Object> The node object that is the parent of the child.
		 * @param child             <Object> The node object that will be removed.
		 * @param index             <int> The 0-based index of the soon to be deleted node.
		 * @param model             <Object (default = null)> The entire collection that this node is a part of
		 * @return                  <Boolean> true if successful.
		 */
		public function removeChildAt(parent:Object, child:Object, index:int, model:Object = null):Boolean;
	}
}
