package mx.controls
{
	import flash.filesystem.File;
	import mx.events.ListEvent;
	import flash.events.KeyboardEvent;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;

	public class FileSystemList extends List
	{
		public static const COMPUTER : File;
		public var helper : FileSystemControlHelper;
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

		public function get nameCompareFunction () : Function;
		public function set nameCompareFunction (value:Function) : void;

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

		public function FileSystemList ();

		public function findIndex (nativePath:String) : int;

		public function findItem (nativePath:String) : File;

		public function itemToDataTip (data:Object) : String;

		public function navigateBack (index:int = 0) : void;

		public function navigateDown () : void;

		public function navigateForward (index:int = 0) : void;

		public function navigateTo (directory:File) : void;

		public function navigateUp () : void;

		public function refresh () : void;

		public function resetHistory (dir:File) : void;

		public function styleChanged (styleProp:String) : void;
	}
}
