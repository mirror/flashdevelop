package flash.desktop
{
	import flash.display.NativeMenu;

	/// The DockIcon class represents the MacOS X&#xAE;-style dock icon.
	public class DockIcon extends InteractiveIcon
	{
		/// [AIR] The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (value:Array) : void;

		/// [AIR] The current display height of the icon in pixels.
		public function get height () : int;

		/// [AIR] The system-supplied menu of this dock icon.
		public function get menu () : NativeMenu;
		public function set menu (menu:NativeMenu) : void;

		/// [AIR] The current display width of the icon in pixels.
		public function get width () : int;

		/// [AIR] Notifies the user that an event has occurred that may require attention.
		public function bounce (priority:String) : void;
	}
}
