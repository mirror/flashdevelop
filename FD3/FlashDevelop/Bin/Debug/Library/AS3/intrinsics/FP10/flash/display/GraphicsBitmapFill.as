package flash.display
{
	/// Defines a bitmap fill.
	public class GraphicsBitmapFill
	{
		/// A transparent or opaque bitmap image.
		public var bitmapData:flash.display.BitmapData;

		/// A matrix object (of the flash.geom.Matrix class) that defines transformations on the bitmap.
		public var matrix:flash.geom.Matrix;

		/// Specifies whether to repeat the bitmap image in a tiled pattern.
		public var repeat:Boolean;

		/// Specifies whether to apply a smoothing algorithm to the bitmap image.
		public var smooth:Boolean;

		/// [FP10] Creates a new GraphicsBitmapFill object.
		public function GraphicsBitmapFill(bitmapData:flash.display.BitmapData=null, matrix:flash.geom.Matrix=null, repeat:Boolean=true, smooth:Boolean=false);

	}

}

