package flash.desktop
{
	/// InteractiveIcon is the abstract base class for the operating system icons associated with applications.
	public class InteractiveIcon extends Icon
	{
		/// The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (value:Array) : void;

		/// The current display height of the icon in pixels.
		public function get height () : int;

		/// The current display width of the icon in pixels.
		public function get width () : int;

		public function InteractiveIcon ();
	}
}
