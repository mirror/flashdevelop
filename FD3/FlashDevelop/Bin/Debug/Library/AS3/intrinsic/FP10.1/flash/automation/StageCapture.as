package flash.automation
{
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	public class StageCapture extends EventDispatcher
	{
		public static const CURRENT : String;
		public static const MULTIPLE : String;
		public static const NEXT : String;

		public function get clipRect () : Rectangle;
		public function set clipRect (value:Rectangle) : void;

		public function get fileNameBase () : String;
		public function set fileNameBase (value:String) : void;

		public function cancel () : void;

		public function capture (type:String) : void;

		public function StageCapture ();
	}
}
