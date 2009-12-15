package flash.desktop
{
	import flash.display.NativeMenu;

	/// The DockIcon class represents the MacOS X®-style dock icon.
	public class DockIcon extends InteractiveIcon
	{
		/// The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (value:Array) : void;

		/// The current display height of the icon in pixels.
		public function get height () : int;

		/// The system-supplied menu of this dock icon.
		public function get menu () : NativeMenu;
		public function set menu (menu:NativeMenu) : void;

		/// The current display width of the icon in pixels.
		public function get width () : int;

		/// Notifies the user that an event has occurred that may require attention.
		public function bounce (priority:String = "informational") : void;

		public function DockIcon ();
	}
}
