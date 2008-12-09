package flash.filters
{
	/// The BevelFilter class lets you add a bevel effect to display objects.
	public class BevelFilter extends flash.filters.BitmapFilter
	{
		/// The offset distance of the bevel.
		public var distance:Number;

		/// The angle of the bevel.
		public var angle:Number;

		/// The highlight color of the bevel.
		public var highlightColor:uint;

		/// The alpha transparency value of the highlight color.
		public var highlightAlpha:Number;

		/// The shadow color of the bevel.
		public var shadowColor:uint;

		/// The alpha transparency value of the shadow color.
		public var shadowAlpha:Number;

		/// The amount of horizontal blur, in pixels.
		public var blurX:Number;

		/// The amount of vertical blur, in pixels.
		public var blurY:Number;

		/// Applies a knockout effect (true), which effectively makes the object's fill transparent and reveals the background color of the document.
		public var knockout:Boolean;

		/// The number of times to apply the filter.
		public var quality:int;

		/// The strength of the imprint or spread.
		public var strength:Number;

		/// The placement of the bevel on the object.
		public var type:String;

		/// Initializes a new BevelFilter instance with the specified parameters.
		public function BevelFilter(distance:Number=4.0, angle:Number=45, highlightColor:uint=0xFFFFFF, highlightAlpha:Number=1.0, shadowColor:uint=0x000000, shadowAlpha:Number=1.0, blurX:Number=4.0, blurY:Number=4.0, strength:Number=1, quality:int=1, type:String=inner, knockout:Boolean=false);

		/// Returns a copy of this filter object.
		public function clone():flash.filters.BitmapFilter;

	}

}

