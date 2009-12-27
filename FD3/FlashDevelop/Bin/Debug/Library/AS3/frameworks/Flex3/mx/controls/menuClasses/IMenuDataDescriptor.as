package mx.controls.menuClasses
{
	import mx.collections.ICollectionView;

	/**
	 *  The IMenuDataDescriptor interface defines the interface that a 
 *  dataDescriptor for a Menu or MenuBar control must implement. 
 *  The interface provides methods for parsing and modifyng a collection
 *  of data that is displayed by a Menu or MenuBar control.
 *
 *  @see mx.collections.ICollectionView
	 */
	public interface IMenuDataDescriptor
	{
		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#getChildren()
		 */
		public function getChildren (node:Object, model:Object = null) : ICollectionView;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#hasChildren()
		 */
		public function hasChildren (node:Object, model:Object = null) : Boolean;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#getData()
		 */
		public function getData (node:Object, model:Object = null) : Object;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#isBranch()
		 */
		public function isBranch (node:Object, model:Object = null) : Boolean;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#getType()
		 */
		public function getType (node:Object) : String;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#addChildAt()
		 */
		public function addChildAt (parent:Object, newChild:Object, index:int, model:Object = null) : Boolean;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#removeChildAt()
		 */
		public function removeChildAt (parent:Object, child:Object, index:int, model:Object = null) : Boolean;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#isEnabled()
		 */
		public function isEnabled (node:Object) : Boolean;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#setEnabled()
		 */
		public function setEnabled (node:Object, value:Boolean) : void;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#isToggled()
		 */
		public function isToggled (node:Object) : Boolean;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#setToggled()
		 */
		public function setToggled (node:Object, value:Boolean) : void;

		/**
		 *  @copy mx.controls.treeClasses.DefaultDataDescriptor#getGroupName()
		 */
		public function getGroupName (node:Object) : String;
	}
}
