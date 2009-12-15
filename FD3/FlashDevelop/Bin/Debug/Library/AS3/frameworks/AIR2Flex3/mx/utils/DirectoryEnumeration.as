package mx.utils
{
	import flash.filesystem.File;
	import mx.collections.ArrayCollection;

	public class DirectoryEnumeration extends Object
	{
		public static const VERSION : String;

		public function get collection () : ArrayCollection;

		public function get enumerationMode () : String;
		public function set enumerationMode (value:String) : void;

		public function get extensions () : Array;
		public function set extensions (value:Array) : void;

		public function get filterFunction () : Function;
		public function set filterFunction (value:Function) : void;

		public function get nameCompareFunction () : Function;
		public function set nameCompareFunction (value:Function) : void;

		public function get showHidden () : Boolean;
		public function set showHidden (value:Boolean) : void;

		public function get source () : Array;
		public function set source (value:Array) : void;

		public function DirectoryEnumeration (source:Array = null);

		public function fileCompareFunction (file1:File, file2:File, fields:Array = null) : int;

		public function fileFilterFunction (file:File) : Boolean;

		public function refresh () : void;
	}
}
