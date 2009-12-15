package air.update.descriptors
{
	import flash.geom.Point;

	public class ApplicationDescriptor extends Object
	{
		public static const ICON_IMAGES : Object;

		public function get copyright () : String;

		public function get description () : String;

		public function get filename () : String;

		public function get fileTypes () : XMLList;

		public function get id () : String;

		public function get initialWindowCloseable () : Boolean;

		public function get initialWindowContent () : String;

		public function get initialWindowHeight () : Number;

		public function get initialWindowMaximizable () : Boolean;

		public function get initialWindowMaxSize () : Point;

		public function get initialWindowMinimizable () : Boolean;

		public function get initialWindowMinSize () : Point;

		public function get initialWindowResizable () : Boolean;

		public function get initialWindowSystemChrome () : String;

		public function get initialWindowTitle () : String;

		public function get initialWindowTransparent () : Boolean;

		public function get initialWindowVisible () : Boolean;

		public function get initialWindowWidth () : Number;

		public function get initialWindowX () : Number;

		public function get initialWindowY () : Number;

		public function get installFolder () : String;

		public function get minimumPatchLevel () : int;

		public function get name () : String;

		public function get namespace () : Namespace;

		public function get programMenuFolder () : String;

		public function get version () : String;

		public function ApplicationDescriptor (xml:XML);

		public function getIcon (size:String) : String;

		public function hasCustomUpdateUI () : Boolean;

		public function validate () : void;
	}
}
