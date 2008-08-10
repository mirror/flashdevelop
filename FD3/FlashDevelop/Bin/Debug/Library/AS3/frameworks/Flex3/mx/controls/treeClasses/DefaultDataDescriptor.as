/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.treeClasses {
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	public class DefaultDataDescriptor implements ITreeDataDescriptor2, IMenuDataDescriptor {
		/**
		 * Constructor
		 */
		public function DefaultDataDescriptor();
		/**
		 * Add a child node to a node at the specified index.
		 *  This implementation does the following:
		 *  If the parent parameter is null or undefined,
		 *  inserts the child parameter at the
		 *  specified index in the collection specified by model
		 *  parameter.
		 *  If the parent parameter has a children
		 *  field or property, the method adds the child parameter
		 *  to it at the index parameter location.
		 *  In this case, the model parameter is not required.
		 *  If the parent parameter does not have a children
		 *  field or property, the method adds the children
		 *  property to the parent. The method then adds the
		 *  child parameter to the parent at the
		 *  index parameter location.
		 *  In this case, the model parameter is not required.
		 *  If the index value is greater than the collection
		 *  length or number of children in the parent, adds the object as
		 *  the last child.
		 *
		 * @param parent            <Object> The node object that will parent the child
		 * @param newChild          <Object> The node object that will be parented by the node
		 * @param index             <int> The 0-based index of where to put the child node relative to the parent
		 * @param model             <Object (default = null)> The entire collection that this node is a part of
		 * @return                  <Boolean> true if successful
		 */
		public function addChildAt(parent:Object, newChild:Object, index:int, model:Object = null):Boolean;
		/**
		 * Provides access to a node's children. Returns a collection
		 *  of children if they exist. If the node is an Object, the method
		 *  returns the contents of the object's children field as
		 *  an ArrayCollection.
		 *  If the node is XML, the method returns an XMLListCollection containing
		 *  the child elements.
		 *
		 * @param node              <Object> The node object currently being evaluated.
		 * @param model             <Object (default = null)> The collection that contains the node; ignored by this class.
		 * @return                  <ICollectionView> An object containing the children nodes.
		 */
		public function getChildren(node:Object, model:Object = null):ICollectionView;
		/**
		 * Returns a node's data.
		 *  Currently returns the entire node.
		 *
		 * @param node              <Object> The node object currently being evaluated.
		 * @param model             <Object (default = null)> The collection that contains the node; ignored by this class.
		 * @return                  <Object> The node.
		 */
		public function getData(node:Object, model:Object = null):Object;
		/**
		 * Returns the name of the radio button group to which
		 *  the node belongs, if any.
		 *  This method is used by menu-based controls.
		 *
		 * @param node              <Object> The node for which to get the group name.
		 * @return                  <String> The value of the node's groupName
		 *                            attribute or field, or an empty string if there is no such
		 *                            entry.
		 */
		public function getGroupName(node:Object):String;
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
		/**
		 * Returns the type identifier of a node.
		 *  This method is used by menu-based controls to determine if the
		 *  node represents a separator, radio button,
		 *  a check box, or normal item.
		 *
		 * @param node              <Object> The node object for which to get the type.
		 * @return                  <String> the value of the type attribute or field,
		 *                            or the empty string if there is no such field.
		 */
		public function getType(node:Object):String;
		/**
		 * Returns true if the node actually has children.
		 *
		 * @param node              <Object> The node object currently being evaluated.
		 * @param model             <Object (default = null)> The collection that contains the node; ignored by this class.
		 * @return                  <Boolean> boolean indicating if this node currently has children
		 */
		public function hasChildren(node:Object, model:Object = null):Boolean;
		/**
		 * Tests a node for termination.
		 *  Branches are non-terminating but are not required to have any leaf nodes.
		 *  If the node is XML, returns true if the node has children
		 *  or a true isBranch attribute.
		 *  If the node is an object, returns true if the node has a
		 *  (possibly empty) children field.
		 *
		 * @param node              <Object> The node object currently being evaluated.
		 * @param model             <Object (default = null)> The collection that contains the node; ignored by this class.
		 * @return                  <Boolean> boolean indicating if this node is non-terminating
		 */
		public function isBranch(node:Object, model:Object = null):Boolean;
		/**
		 * Returns whether the node is enabled.
		 *  This method is used by menu-based controls.
		 *
		 * @param node              <Object> The node for which to get the status.
		 * @return                  <Boolean> the value of the node's enabled
		 *                            attribute or field, or true if there is no such
		 *                            entry or the value is not false.
		 */
		public function isEnabled(node:Object):Boolean;
		/**
		 * Returns whether the node is toggled.
		 *  This method is used by menu-based controls.
		 *
		 * @param node              <Object> The node for which to get the status.
		 * @return                  <Boolean> The value of the node's toggled
		 *                            attribute or field, or false if there is no such
		 *                            entry.
		 */
		public function isToggled(node:Object):Boolean;
		/**
		 * Removes the child node from a node at the specified index.
		 *  If the parent parameter is null
		 *  or undefined, the method uses the model parameter to
		 *  access the child; otherwise, it uses the parent parameter
		 *  and ignores the model parameter.
		 *
		 * @param parent            <Object> The node object that currently parents the child node
		 * @param child             <Object> The node that is being removed
		 * @param index             <int> The 0-based index of  the child node to remove relative to the parent
		 * @param model             <Object (default = null)> The entire collection that this node is a part of
		 * @return                  <Boolean> true if successful
		 */
		public function removeChildAt(parent:Object, child:Object, index:int, model:Object = null):Boolean;
		/**
		 * Sets the value of the field or attribute in the data provider
		 *  that identifies whether the node is enabled.
		 *  This method sets the value of the node's enabled
		 *  attribute or field.
		 *  This method is used by menu-based controls.
		 *
		 * @param node              <Object> The node for which to set the status.
		 * @param value             <Boolean> Whether the node is enabled.
		 */
		public function setEnabled(node:Object, value:Boolean):void;
		/**
		 * Sets the value of the field or attribute in the data provider
		 *  that identifies whether the node is toggled.
		 *  This method sets the value of the node's toggled
		 *  attribute or field.
		 *  This method is used by menu-based controls.
		 *
		 * @param node              <Object> The node for which to set the status.
		 * @param value             <Boolean> Whether the node is toggled.
		 */
		public function setToggled(node:Object, value:Boolean):void;
	}
}
