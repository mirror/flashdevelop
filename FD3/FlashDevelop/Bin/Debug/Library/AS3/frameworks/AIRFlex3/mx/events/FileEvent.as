package mx.events
{
	import flash.events.Event;
	import flash.filesystem.File;

	public class FileEvent extends Event
	{
		public static const DIRECTORY_CHANGE : String = "directoryChange";
		public static const DIRECTORY_CHANGING : String = "directoryChanging";
		public static const DIRECTORY_CLOSING : String = "directoryClosing";
		public static const DIRECTORY_OPENING : String = "directoryOpening";
		public var file : File;
		public static const FILE_CHOOSE : String = "fileChoose";
		public static const VERSION : String;

		public function clone () : Event;

		public function FileEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, file:File = null);
	}
}
