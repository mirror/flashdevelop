/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.treeClasses {
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	public interface ITreeDataDescriptor2 extends ITreeDataDescriptor {
		/**
		 * Returns an ICollectionView instance that makes the hierarchical data appear
		 *  as if it was a linear ICollectionView instance.
		 *
		 * @param hierarchicalData  <ICollectionView> The hierarchical data.
		 * @param uidFunction       <Function> A function that takes an Object and returns the UID, as a String.
		 *                            This parameter is usually the Tree.itemToUID() method.
		 * @param openItems         <Object> The items that have been opened or set opened.
		 * @param model             <Object (default = null)> The collection to which this node belongs.
		 * @return                  <ICollectionView> An ICollectionView instance.
		 */
		public function getHierarchicalCollectionAdaptor(hierarchicalData:ICollectionView, uidFunction:Function, openItems:Object, model:Object = null):ICollectionView;
		/**
		 * Returns the depth of the node, meaning the number of ancestors it has.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @param iterator          <IViewCursor> An IViewCursor instance that could be used to do the calculation.
		 * @param model             <Object (default = null)> The collection to which this node belongs.
		 * @return                  <int> The depth of the node, where 0 corresponds to the top level,
		 *                            and -1 if the depth cannot be calculated.
		 */
		public function getNodeDepth(node:Object, iterator:IViewCursor, model:Object = null):int;
		/**
		 * Returns the parent of the node
		 *  The parent of a top-level node is null.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @param collection        <ICollectionView> An ICollectionView instance that could be used to do the calculation.
		 * @param model             <Object (default = null)> The collection to which this node belongs.
		 * @return                  <Object> The parent node containing the node as child,
		 *                            null for a top-level node,
		 *                            and undefined if the parent cannot be determined.
		 */
		public function getParent(node:Object, collection:ICollectionView, model:Object = null):Object;
	}
}
