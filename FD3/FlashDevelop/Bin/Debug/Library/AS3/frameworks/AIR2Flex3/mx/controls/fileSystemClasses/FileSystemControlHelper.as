package mx.controls.fileSystemClasses
{
	import flash.filesystem.File;
	import flash.events.KeyboardEvent;
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;
	import mx.utils.DirectoryEnumeration;
	import mx.resources.IResourceManager;
	import mx.events.FlexEvent;
	import mx.controls.dataGridClasses.DataGridColumn;

	public class FileSystemControlHelper extends Object
	{
		public static var COMPUTER : File;
		public var directoryEnumeration : DirectoryEnumeration;
		public var hierarchical : Boolean;
		public var history : Array;
		public var historyIndex : int;
		public var owner : Object;
		public var resourceManager : IResourceManager;
		public static const VERSION : String;

		public function get backHistory () : Array;

		public function get canNavigateBack () : Boolean;

		public function get canNavigateDown () : Boolean;

		public function get canNavigateForward () : Boolean;

		public function get canNavigateUp () : Boolean;

		public function get directory () : File;
		public function set directory (value:File) : void;

		public function get enumerationMode () : String;
		public function set enumerationMode (value:String) : void;

		public function get extensions () : Array;
		public function set extensions (value:Array) : void;

		public function get filterFunction () : Function;
		public function set filterFunction (value:Function) : void;

		public function get forwardHistory () : Array;

		public function get itemArray () : Array;

		public function get nameCompareFunction () : Function;
		public function set nameCompareFunction (value:Function) : void;

		public function get nativePathToIndexMap () : Object;

		public function get openPaths () : Array;
		public function set openPaths (value:Array) : void;

		public function get selectedPath () : String;
		public function set selectedPath (value:String) : void;

		public function get selectedPaths () : Array;
		public function set selectedPaths (value:Array) : void;

		public function get showExtensions () : Boolean;
		public function set showExtensions (value:Boolean) : void;

		public function get showHidden () : Boolean;
		public function set showHidden (value:Boolean) : void;

		public function get showIcons () : Boolean;
		public function set showIcons (value:Boolean) : void;

		public function clear () : void;

		public function commitProperties () : void;

		public function dispatchDirectoryChangingEvent (newDirectory:File) : Boolean;

		public function dispatchFileChooseEvent (file:File) : void;

		public function fileIconFunction (item:File) : Class;

		public function fileLabelFunction (item:File, column:DataGridColumn = null) : String;

		public function FileSystemControlHelper (owner:Object, hierarchical:Boolean);

		public function fill () : void;

		public function findIndex (nativePath:String) : int;

		public function findItem (nativePath:String) : File;

		public function getParentChain (file:File) : Array;

		public function handleKeyDown (event:KeyboardEvent) : Boolean;

		public function isComputer (f:File) : Boolean;

		public function itemDoubleClickHandler (event:ListEvent) : void;

		public function itemsChanged () : void;

		public function itemToUID (data:Object) : String;

		public function navigateBack (index:int = 0) : void;

		public function navigateDown () : void;

		public function navigateForward (index:int = 0) : void;

		public function navigateTo (directory:File) : void;

		public function navigateUp () : void;

		public function refresh () : void;

		public function resetHistory (directory:File) : void;

		public function setDataProvider (value:Array) : void;

		public function setDirectory (value:File) : void;

		public function styleChanged (styleProp:String) : void;
	}
}
