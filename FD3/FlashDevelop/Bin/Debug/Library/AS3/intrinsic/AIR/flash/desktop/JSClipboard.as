package flash.desktop
{
	import flash.desktop.NativeDragOptions;
	import flash.desktop.Clipboard;

	public class JSClipboard extends Object
	{
		public function get clipboard () : Clipboard;

		public function get dragOptions () : NativeDragOptions;
		public function set dragOptions (dragOptions:NativeDragOptions) : void;

		public function get dropEffect () : String;
		public function set dropEffect (effect:String) : void;

		public function get effectAllowed () : String;
		public function set effectAllowed (effectAllowed:String) : void;

		public function get propagationStopped () : Boolean;
		public function set propagationStopped (stopped:Boolean) : void;

		public function get types () : Array;

		public function clearAllData () : void;

		public function clearData (mimeType:String) : void;

		public function getData (mimeType:String) : Object;

		public function setData (mimeType:String, data:Object) : Boolean;

		public static function urisFromURIList (uriList:String) : Array;
	}
}
