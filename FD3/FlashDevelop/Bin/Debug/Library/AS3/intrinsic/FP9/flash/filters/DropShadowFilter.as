package flash.filters
{
	/// The DropShadowFilter class lets you add a drop shadow to display objects.
	public class DropShadowFilter extends flash.filters.BitmapFilter
	{
		/// The offset distance for the shadow, in pixels.
		public var distance:Number;

		/// The angle of the shadow.
		public var angle:Number;

		/// The color of the shadow.
		public var color:uint;

		/// The alpha transparency value for the shadow color.
		public var alpha:Number;

		/// The amount of horizontal blur.
		public var blurX:Number;

		/// The amount of vertical blur.
		public var blurY:Number;

		/// Indicates whether or not the object is hidden.
		public var hideObject:Boolean;

		/// Indicates whether or not the shadow is an inner shadow.
		public var inner:Boolean;

		/// Applies a knockout effect (true), which effectively makes the object's fill transparent and reveals the background color of the document.
		public var knockout:Boolean;

		/// The number of times to apply the filter.
		public var quality:int;

		/// The strength of the imprint or spread.
		public var strength:Number;

		/// Creates a new DropShadowFilter instance with the specified parameters.
		public function DropShadowFilter(distance:Number=4.0, angle:Number=45, color:uint=0, alpha:Number=1.0, blurX:Number=4.0, blurY:Number=4.0, strength:Number=1.0, quality:int=1, inner:Boolean=false, knockout:Boolean=false, hideObject:Boolean=false);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

