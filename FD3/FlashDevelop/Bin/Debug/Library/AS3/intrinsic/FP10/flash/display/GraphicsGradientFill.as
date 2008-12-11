package flash.display
{
	/// Defines a gradient fill.
	public class GraphicsGradientFill
	{
		/// An array of RGB hexadecimal color values to use in the gradient.
		public var colors:Array;

		/// An array of alpha values for the corresponding colors in the colors array.
		public var alphas:Array;

		/// An array of color distribution ratios.
		public var ratios:Array;

		/// A transformation matrix as defined by the Matrix class.
		public var matrix:flash.geom.Matrix;

		/// A number that controls the location of the focal point of the gradient.
		public var focalPointRatio:Number;

		/// A value from the GradientType class that specifies which gradient type to use.
		public var type:String;

		/// A value from the SpreadMethod class that specifies which spread method to use.
		public var spreadMethod:String;

		/// A value from the InterpolationMethod class that specifies which value to use.
		public var interpolationMethod:String;

		/// [FP10] Creates a new GraphicsGradientFill object.
		public function GraphicsGradientFill(type:String=linear, colors:Array=null, alphas:Array=null, ratios:Array=null, matrix:*=null, spreadMethod:*=pad, interpolationMethod:String=rgb, focalPointRatio:Number=0.0);

	}

}

