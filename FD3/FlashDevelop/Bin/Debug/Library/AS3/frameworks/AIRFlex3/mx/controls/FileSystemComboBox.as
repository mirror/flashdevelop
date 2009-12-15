package mx.controls
{
	import flash.filesystem.File;
	import flash.events.Event;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;

	public class FileSystemComboBox extends ComboBox
	{
		public static const COMPUTER : File;
		public var helper : FileSystemControlHelper;
		public static const VERSION : String;

		public function get directory () : File;
		public function set directory (value:File) : void;

		public function get indent () : int;
		public function set indent (value:int) : void;

		public function get showIcons () : Boolean;
		public function set showIcons (value:Boolean) : void;

		public function FileSystemComboBox ();
	}
}
