package flash.filters
{
	/// The GlowFilter class lets you apply a glow effect to display objects.
	public class GlowFilter extends flash.filters.BitmapFilter
	{
		/// The color of the glow.
		public var color:uint;

		/// The alpha transparency value for the color.
		public var alpha:Number;

		/// The amount of horizontal blur.
		public var blurX:Number;

		/// The amount of vertical blur.
		public var blurY:Number;

		/// Specifies whether the glow is an inner glow.
		public var inner:Boolean;

		/// Specifies whether the object has a knockout effect.
		public var knockout:Boolean;

		/// The number of times to apply the filter.
		public var quality:int;

		/// The strength of the imprint or spread.
		public var strength:Number;

		/// Initializes a new GlowFilter instance with the specified parameters.
		public function GlowFilter(color:uint=0xFF0000, alpha:Number=1.0, blurX:Number=6.0, blurY:Number=6.0, strength:Number=2, quality:int=1, inner:Boolean=false, knockout:Boolean=false);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

