/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.EventDispatcher;
	public class HierarchicalData extends EventDispatcher implements IHierarchicalData {
		/**
		 * Indicates the field name to be used to detect children objects in
		 *  a data item.
		 *  By default, all subnodes are considered as children for
		 *  XML data, and the children property is used for the Object data type.
		 *  This is helpful in adapting to a data format that uses custom data fields
		 *  to represent children.
		 */
		public function get childrenField():String;
		public function set childrenField(value:String):void;
		/**
		 * The source collection.
		 *  The collection should implement the IList interface
		 *  to facilitate operation like the addition and removal of items.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * Constructor
		 *
		 * @param value             <Object (default = null)> The data used to populate the HierarchicalData instance.
		 */
		public function HierarchicalData(value:Object = null);
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
