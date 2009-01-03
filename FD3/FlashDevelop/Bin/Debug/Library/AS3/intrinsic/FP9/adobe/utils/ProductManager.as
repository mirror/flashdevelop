package adobe.utils
{
	import flash.events.EventDispatcher;

	public class ProductManager extends EventDispatcher
	{
		public function get installed () : Boolean;

		public function get installedVersion () : String;

		public function get running () : Boolean;

		public function download (caption:String, fileName:String, pathElements:Array) : Boolean;

		public function launch (parameters:String) : Boolean;
	}
}
