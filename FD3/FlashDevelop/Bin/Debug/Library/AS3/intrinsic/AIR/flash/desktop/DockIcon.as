package flash.desktop
{
	/// The DockIcon class represents the MacOS X&#xAE;-style dock icon.
	public class DockIcon extends flash.desktop.InteractiveIcon
	{
		/// [AIR] The icon image as an array of BitmapData objects of different sizes.
		public var bitmaps:Array;

		/// [AIR] The current display width of the icon in pixels.
		public var width:int;

		/// [AIR] The current display height of the icon in pixels.
		public var height:int;

		/// [AIR] The system-supplied menu of this dock icon.
		public var menu:flash.display.NativeMenu;

		/// [AIR] Notifies the user that an event has occurred that may require attention.
		public function bounce(priority:String=informational):void;

	}

}

