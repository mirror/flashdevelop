package flash.display
{
	/// The Bitmap class represents display objects that represent bitmap images.
	public class Bitmap extends flash.display.DisplayObject
	{
		/// Controls whether or not the Bitmap object is snapped to the nearest pixel.
		public var pixelSnapping:String;

		/// Controls whether or not the bitmap is smoothed when scaled.
		public var smoothing:Boolean;

		/// The BitmapData object being referenced.
		public var bitmapData:flash.display.BitmapData;

		/// Initializes a Bitmap object to refer to the specified BitmapData object.
		public function Bitmap(bitmapData:flash.display.BitmapData=null, pixelSnapping:String=auto, smoothing:Boolean=false);

	}

}

