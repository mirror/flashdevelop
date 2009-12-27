package mx.controls.treeClasses
{
	import flash.utils.Dictionary;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.XMLListCollection;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.utils.UIDUtil;

include "../../core/Version.as"
	/**
	 *  The DefaultDataDescriptor class provides a default implementation for
 *  accessing and manipulating data for use in controls such as Tree and Menu.
 *
 *  This implementation handles e4x XML and object nodes in similar but different
 *  ways. See each method description for details on how the method
 *  accesses values in nodes of various types.
 *
 *  This class is the default value of the Tree, Menu, MenuBar, and
 *  PopUpMenuButton control <code>dataDescriptor</code> properties.
 *
 *  @see mx.controls.treeClasses.ITreeDataDescriptor
 *  @see mx.controls.menuClasses.IMenuDataDescriptor
 *  @see mx.controls.Menu
 *  @see mx.controls.MenuBar
 *  @see mx.controls.PopUpMenuButton
 *  @see mx.controls.Tree
	 */
	public class DefaultDataDescriptor implements ITreeDataDescriptor2
	{
		/**
		 *  @private
		 */
		private var ChildCollectionCache : Dictionary;

		/**
		 *  Constructor.
		 */
		public function DefaultDataDescriptor ();

		/**
		 *  Provides access to a node's children. Returns a collection
     *  of children if they exist. If the node is an Object, the method
     *  returns the contents of the object's <code>children</code> field as
     *  an ArrayCollection.
     *  If the node is XML, the method returns an XMLListCollection containing
     *  the child elements.
     *
     *  @param node The node object currently being evaluated.
     *  @param model The collection that contains the node; ignored by this class.
     *  @return An object containing the children nodes.
		 */
		public function getChildren (node:Object, model:Object = null) : ICollectionView;

		/**
		 *  Determines if the node actually has children. 
     * 
     *  @param node The node object currently being evaluated.
     *  @param model The collection that contains the node; ignored by this class.
     *  
     *  @return <code>true</code> if this node currently has children.
		 */
		public function hasChildren (node:Object, model:Object = null) : Boolean;

		/**
		 *  Tests a node for termination.
     *  Branches are non-terminating but are not required to have any leaf nodes.
     *  If the node is XML, returns <code>true</code> if the node has children
     *  or a <code>true isBranch</code> attribute.
     *  If the node is an object, returns <code>true</code> if the node has a
     *  (possibly empty) <code>children</code> field.
     *
     *  @param node The node object currently being evaluated.
     *  @param model The collection that contains the node; ignored by this class.
     *  
     *  @return <code>true</code> if this node is non-terminating.
		 */
		public function isBranch (node:Object, model:Object = null) : Boolean;

		/**
		 *  Returns a node's data.
     *  Currently returns the entire node.
     *
     *  @param node The node object currently being evaluated.
     *  @param model The collection that contains the node; ignored by this class.
     *  @return The node.
		 */
		public function getData (node:Object, model:Object = null) : Object;

		/**
		 *  Add a child node to a node at the specified index. 
     *  This implementation does the following:
     * 
     *  <ul>
     *      <li>If the <code>parent</code> parameter is null or undefined,
     *          inserts the <code>child</code> parameter at the 
     *          specified index in the collection specified by <code>model</code>
     *          parameter.
     *      </li>
     *      <li>If the <code>parent</code> parameter has a <code>children</code>
     *          field or property, the method adds the <code>child</code> parameter
     *          to it at the <code>index</code> parameter location.
     *          In this case, the <code>model</code> parameter is not required.
     *     </li>
     *     <li>If the <code>parent</code> parameter does not have a <code>children</code>
     *          field or property, the method adds the <code>children</code> 
     *          property to the <code>parent</code>. The method then adds the 
     *          <code>child</code> parameter to the parent at the 
     *          <code>index</code> parameter location. 
     *          In this case, the <code>model</code> parameter is not required.
     *     </li>
     *     <li>If the <code>index</code> value is greater than the collection 
     *         length or number of children in the parent, adds the object as
     *         the last child.
     *     </li>
     * </ul>
     *
     *  @param parent The node object that will parent the child.
     *  @param newChild The node object that will be parented by the node.
     *  @param index The 0-based index of where to put the child node relative to the parent.
     *  @param model The entire collection that this node is a part of.
     *  
     *  @return <code>true</code> if successful.
		 */
		public function addChildAt (parent:Object, newChild:Object, index:int, model:Object = null) : Boolean;

		/**
		 *  Removes the child node from a node at the specified index.
     *  If the <code>parent</code> parameter is null 
     *  or undefined, the method uses the <code>model</code> parameter to 
     *  access the child; otherwise, it uses the <code>parent</code> parameter
     *  and ignores the <code>model</code> parameter.
    *
     *  @param parent The node object that currently parents the child node.
     *  @param child The node that is being removed.
     *  @param index The 0-based index of  the child node to remove relative to the parent.
     *  @param model The entire collection that this node is a part of.
     *  
     *  @return <code>true</code> if successful.
		 */
		public function removeChildAt (parent:Object, child:Object, index:int, model:Object = null) : Boolean;

		/**
		 *  Returns the type identifier of a node.
     *  This method is used by menu-based controls to determine if the
     *  node represents a separator, radio button,
     *  a check box, or normal item.
     *
     *  @param node The node object for which to get the type.
     *  
     *  @return  The value of the <code>type</code> attribute or field,
     *  or the empty string if there is no such field.
		 */
		public function getType (node:Object) : String;

		/**
		 *  Returns whether the node is enabled.
     *  This method is used by menu-based controls.
     *
     *  @param node The node for which to get the status.
     *  
     *  @return The value of the node's <code>enabled</code>
     *  attribute or field, or <code>true</code> if there is no such
     *  entry or the value is not <code>false</code>.
		 */
		public function isEnabled (node:Object) : Boolean;

		/**
		 *  Sets the value of the field or attribute in the data provider
     *  that identifies whether the node is enabled.
     *  This method sets the value of the node's <code>enabled</code>
     *  attribute or field.
     *  This method is used by menu-based controls.
     *
     *  @param node The node for which to set the status.
     *  @param value Whether the node is enabled.
		 */
		public function setEnabled (node:Object, value:Boolean) : void;

		/**
		 *  Returns whether the node is toggled.
     *  This method is used by menu-based controls.
     *
     *  @param node The node for which to get the status.
     *  
     *  @return The value of the node's <code>toggled</code>
     *  attribute or field, or <code>false</code> if there is no such
     *  entry.
		 */
		public function isToggled (node:Object) : Boolean;

		/**
		 *  Sets the value of the field or attribute in the data provider
     *  that identifies whether the node is toggled.
     *  This method sets the value of the node's <code>toggled</code>
     *  attribute or field.
     *  This method is used by menu-based controls.
     *
     *  @param node The node for which to set the status.
     *  @param value Whether the node is toggled.
		 */
		public function setToggled (node:Object, value:Boolean) : void;

		/**
		 *  Returns the name of the radio button group to which
     *  the node belongs, if any.
     *  This method is used by menu-based controls.
     *
     *  @param node The node for which to get the group name.
     *  @return The value of the node's <code>groupName</code>
     *  attribute or field, or an empty string if there is no such
     *  entry.
		 */
		public function getGroupName (node:Object) : String;

		/**
		 *  @inheritDoc
		 */
		public function getHierarchicalCollectionAdaptor (hierarchicalData:ICollectionView, uidFunction:Function, openItems:Object, model:Object = null) : ICollectionView;

		/**
		 *  @inheritDoc
		 */
		public function getNodeDepth (node:Object, iterator:IViewCursor, model:Object = null) : int;

		/**
		 *  @inheritDoc
		 */
		public function getParent (node:Object, collection:ICollectionView, model:Object = null) : Object;
	}
}
