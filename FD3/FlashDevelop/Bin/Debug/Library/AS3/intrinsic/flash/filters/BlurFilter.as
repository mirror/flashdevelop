package flash.filters
{
	/// The BlurFilter class lets you apply a blur visual effect to display objects.
	public class BlurFilter extends flash.filters.BitmapFilter
	{
		/// The amount of horizontal blur.
		public var blurX:Number;

		/// The amount of vertical blur.
		public var blurY:Number;

		/// The number of times to perform the blur.
		public var quality:int;

		/// Initializes the filter.
		public function BlurFilter(blurX:Number=4.0, blurY:Number=4.0, quality:int=1);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

