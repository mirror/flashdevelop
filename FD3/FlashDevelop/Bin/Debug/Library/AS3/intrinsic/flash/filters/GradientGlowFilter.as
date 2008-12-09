package flash.filters
{
	/// The GradientGlowFilter class lets you apply a gradient glow effect to display objects.
	public class GradientGlowFilter extends flash.filters.BitmapFilter
	{
		/// The angle, in degrees.
		public var angle:Number;

		/// An array of alpha transparency values for the corresponding colors in the colors array.
		public var alphas:Array;

		/// The amount of horizontal blur.
		public var blurX:Number;

		/// The amount of vertical blur.
		public var blurY:Number;

		/// An array of colors that defines a gradient.
		public var colors:Array;

		/// The offset distance of the glow.
		public var distance:Number;

		/// Specifies whether the object has a knockout effect.
		public var knockout:Boolean;

		/// The number of times to apply the filter.
		public var quality:int;

		/// An array of color distribution ratios for the corresponding colors in the colors array.
		public var ratios:Array;

		/// The strength of the imprint or spread.
		public var strength:Number;

		/// The placement of the filter effect.
		public var type:String;

		/// Initializes the filter with the specified parameters.
		public function GradientGlowFilter(distance:Number=4.0, angle:Number=45, colors:Array=null, alphas:Array=null, ratios:Array=null, blurX:Number=4.0, blurY:Number=4.0, strength:Number=1, quality:int=1, type:String=inner, knockout:Boolean=false);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

