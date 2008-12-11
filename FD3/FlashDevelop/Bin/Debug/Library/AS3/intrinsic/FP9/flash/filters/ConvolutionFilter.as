package flash.filters
{
	/// The ConvolutionFilter class applies a matrix convolution filter effect.
	public class ConvolutionFilter extends flash.filters.BitmapFilter
	{
		/// An array of values used for matrix transformation.
		public var matrix:Array;

		/// The x dimension of the matrix (the number of columns in the matrix).
		public var matrixX:Number;

		/// The y dimension of the matrix (the number of rows in the matrix).
		public var matrixY:Number;

		/// The divisor used during matrix transformation.
		public var divisor:Number;

		/// The amount of bias to add to the result of the matrix transformation.
		public var bias:Number;

		/// Indicates if the alpha channel is preserved without the filter effect or if the convolution filter is applied to the alpha channel as well as the color channels.
		public var preserveAlpha:Boolean;

		/// Indicates whether the image should be clamped.
		public var clamp:Boolean;

		/// The hexadecimal color to substitute for pixels that are off the source image.
		public var color:uint;

		/// The alpha transparency value of the substitute color.
		public var alpha:Number;

		/// Initializes a ConvolutionFilter instance with the specified parameters.
		public function ConvolutionFilter(matrixX:Number=0, matrixY:Number=0, matrix:Array=null, divisor:Number=1.0, bias:Number=0.0, preserveAlpha:Boolean=true, clamp:Boolean=true, color:uint=0, alpha:Number=0.0);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

