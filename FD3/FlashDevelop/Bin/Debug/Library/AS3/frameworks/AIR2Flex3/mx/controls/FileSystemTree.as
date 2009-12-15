package mx.controls
{
	import flash.filesystem.File;
	import mx.events.ListEvent;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.events.TreeEvent;
	import flash.events.KeyboardEvent;
	import flash.events.FileListEvent;

	public class FileSystemTree extends Tree
	{
		public static const COMPUTER : File;
		public var helper : FileSystemControlHelper;
		public static const VERSION : String;

		public function get directory () : File;
		public function set directory (value:File) : void;

		public function get enumerationMode () : String;
		public function set enumerationMode (value:String) : void;

		public function get extensions () : Array;
		public function set extensions (value:Array) : void;

		public function get filterFunction () : Function;
		public function set filterFunction (value:Function) : void;

		public function get nameCompareFunction () : Function;
		public function set nameCompareFunction (value:Function) : void;

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

		public function closeItem (item:File) : void;

		public function closeSubdirectory (nativePath:String) : void;

		public function FileSystemTree ();

		public function findIndex (nativePath:String) : int;

		public function findItem (nativePath:String) : File;

		public function fixSelectionAfterClose (item:File) : void;

		public function getStyle (styleProp:String) : *;

		public function insertChildItems (subdirectory:File, childItems:Array) : void;

		public function openItem (item:File, async:Boolean = true) : void;

		public function openSubdirectory (nativePath:String) : void;

		public function refresh () : void;

		public function styleChanged (styleProp:String) : void;
	}
}
