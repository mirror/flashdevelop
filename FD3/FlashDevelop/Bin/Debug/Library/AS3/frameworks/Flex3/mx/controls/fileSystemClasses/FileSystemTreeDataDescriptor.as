package mx.controls.fileSystemClasses
{
	import flash.filesystem.File;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.core.mx_internal;

	/**
	 *  @private *  *  The FileSystemTreeDataDescriptor implements the *  <code>dataDescriptor</code> used by a FileSystemTree. *  This data descriptor enables it to display a hierarchical *  view of File instances representing directories and files *  despite the fact that a File instance doesn't have a property *  such as <code>children</code> that can be used to tie *  such instances together into a hierarchical data structure. *  *  <p>We could have chosen to create a subclass of File, *  or a wrapper class, which adds such a property; *  but every time a directory was enumerated *  we would have to turn the File instances *  we get into instances of this other class. *  Instead, each time a node in FileSystemTree is opened, *  we enumerate that subdirectory and *  store the resulting child collection in a map *  that maps parents to their immediate children. *  This descriptor class makes the resulting multiple *  linear ArrayCollections displaying by a tree control.
	 */
	public class FileSystemTreeDataDescriptor extends DefaultDataDescriptor
	{
		/**
		 *  @private	 * 	 *  Maps nativePath (String) -> childItems (ArrayCollection).
		 */
		local var parentToChildrenMap : Object;

		/**
		 *  Constructor.
		 */
		public function FileSystemTreeDataDescriptor ();
		/**
		 *  @private
		 */
		public function getChildren (node:Object, model:Object = null) : ICollectionView;
		/**
		 *  @private
		 */
		public function isBranch (node:Object, model:Object = null) : Boolean;
		/**
		 *  @private
		 */
		public function hasChildren (node:Object, model:Object = null) : Boolean;
		/**
		 *  @private
		 */
		public function reset () : void;
		/**
		 *  @private
		 */
		public function setChildren (node:Object, children:ArrayCollection) : void;
	}
}
