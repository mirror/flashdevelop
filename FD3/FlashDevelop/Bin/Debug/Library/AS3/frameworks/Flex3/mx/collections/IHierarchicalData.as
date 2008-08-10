/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public interface IHierarchicalData extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * Returns true if the node can contain children.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @return                  <Boolean> true if the node can contain children.
		 */
		public function canHaveChildren(node:Object):Boolean;
		/**
		 * Returns an Object representing the node's children.
		 *
		 * @param node              <Object> The Object that defines the node.
		 *                            If null, return a collection of top-level nodes.
		 * @return                  <Object> An Object containing the children nodes.
		 */
		public function getChildren(node:Object):Object;
		/**
		 * Returns data from a node.
		 *
		 * @param node              <Object> The node Object from which to get the data.
		 * @return                  <Object> The requested data.
		 */
		public function getData(node:Object):Object;
		/**
		 * Returns the root data item.
		 *
		 * @return                  <Object> The Object containing the root data item.
		 */
		public function getRoot():Object;
		/**
		 * Returns true if the node has children.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @return                  <Boolean> true if the node has children.
		 */
		public function hasChildren(node:Object):Boolean;
	}
}
