package flash.desktop
{
	import flash.events.EventDispatcher;

	/// The Icon class represents an operating system icon.
	public class Icon extends EventDispatcher
	{
		/// [AIR] The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (ba:Array) : void;
	}
}
