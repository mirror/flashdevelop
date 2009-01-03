package flash.desktop
{
	/// InteractiveIcon is the abstract base class for the operating system icons associated with applications.
	public class InteractiveIcon extends Icon
	{
		/// [AIR] The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (value:Array) : void;

		/// [AIR] The current display height of the icon in pixels.
		public function get height () : int;

		/// [AIR] The current display width of the icon in pixels.
		public function get width () : int;
	}
}
