package flash.filters
{
	/// The DisplacementMapFilter class uses the pixel values from the specified BitmapData object (called the displacement map image) to perform a displacement of an object.
	public class DisplacementMapFilter extends flash.filters.BitmapFilter
	{
		/// A BitmapData object containing the displacement map data.
		public var mapBitmap:flash.display.BitmapData;

		/// A value that contains the offset of the upper-left corner of the target display object from the upper-left corner of the map image.
		public var mapPoint:flash.geom.Point;

		/// Describes which color channel to use in the map image to displace the x result.
		public var componentX:uint;

		/// Describes which color channel to use in the map image to displace the y result.
		public var componentY:uint;

		/// The multiplier to use to scale the x displacement result from the map calculation.
		public var scaleX:Number;

		/// The multiplier to use to scale the y displacement result from the map calculation.
		public var scaleY:Number;

		/// The mode for the filter.
		public var mode:String;

		/// Specifies what color to use for out-of-bounds displacements.
		public var color:uint;

		/// Specifies the alpha transparency value to use for out-of-bounds displacements.
		public var alpha:Number;

		/// Initializes a DisplacementMapFilter instance.
		public function DisplacementMapFilter(mapBitmap:flash.display.BitmapData=null, mapPoint:flash.geom.Point=null, componentX:uint=0, componentY:uint=0, scaleX:Number=0.0, scaleY:Number=0.0, mode:String=wrap, color:uint=0, alpha:Number=0.0);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

