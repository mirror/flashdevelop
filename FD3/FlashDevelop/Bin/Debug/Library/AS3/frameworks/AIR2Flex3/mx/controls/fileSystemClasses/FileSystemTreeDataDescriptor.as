package mx.controls.fileSystemClasses
{
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;

	public class FileSystemTreeDataDescriptor extends DefaultDataDescriptor
	{
		public var parentToChildrenMap : Object;
		public static const VERSION : String;

		public function FileSystemTreeDataDescriptor ();

		public function getChildren (node:Object, model:Object = null) : ICollectionView;

		public function hasChildren (node:Object, model:Object = null) : Boolean;

		public function isBranch (node:Object, model:Object = null) : Boolean;

		public function reset () : void;

		public function setChildren (node:Object, children:ArrayCollection) : void;
	}
}
