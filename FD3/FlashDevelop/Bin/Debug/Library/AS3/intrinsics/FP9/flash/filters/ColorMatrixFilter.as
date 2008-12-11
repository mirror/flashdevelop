package flash.filters
{
	/// The ColorMatrixFilter class lets you apply a 4 x 5 matrix transformation on the RGBA color and alpha valuesof every pixel in the input image to produce a result with a new set of RGBA color and alpha values.
	public class ColorMatrixFilter extends flash.filters.BitmapFilter
	{
		/// An array of 20 items for 4 x 5 color transform.
		public var matrix:Array;

		/// Initializes a new ColorMatrixFilter instance.
		public function ColorMatrixFilter(matrix:Array=null);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

