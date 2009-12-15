package flash.ui
{
	public class Multitouch extends Object
	{
		public static function get inputMode () : String;
		public static function set inputMode (value:String) : void;

		public static function get maxTouchPoints () : int;

		public static function get supportedGestures () : Vector.<String>;

		public static function get supportsGestureEvents () : Boolean;

		public static function get supportsTouchEvents () : Boolean;

		public function Multitouch ();
	}
}
