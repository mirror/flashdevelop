/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public final  class BlurFilter extends BitmapFilter {
		/**
		 * The amount of horizontal blur. Valid values are from 0 to 255 (floating point). The
		 *  default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		/**
		 * The amount of vertical blur. Valid values are from 0 to 255 (floating point). The
		 *  default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		/**
		 * The number of times to perform the blur. The default value is BitmapFilterQuality.LOW,
		 *  which is equivalent to applying the filter once. The value BitmapFilterQuality.MEDIUM
		 *  applies the filter twice; the value BitmapFilterQuality.HIGH applies it three times
		 *  and approximates a Gaussian blur. Filters with lower values are rendered more quickly.
		 */
		public function get quality():int;
		public function set quality(value:int):void;
		/**
		 * Initializes the filter with the specified parameters.
		 *  The default values create a soft, unfocused image.
		 *
		 * @param blurX             <Number (default = 4.0)> The amount to blur horizontally. Valid values are from 0 to 255.0 (floating-point
		 *                            value).
		 * @param blurY             <Number (default = 4.0)> The amount to blur vertically. Valid values are from 0 to 255.0 (floating-point
		 *                            value).
		 * @param quality           <int (default = 1)> The number of times to apply the filter. You can specify the quality using
		 *                            the BitmapFilterQuality constants:
		 *                            flash.filters.BitmapFilterQuality.LOW
		 *                            flash.filters.BitmapFilterQuality.MEDIUM
		 *                            flash.filters.BitmapFilterQuality.HIGH
		 *                            High quality approximates a Gaussian blur.
		 *                            For most applications, these three values are sufficient.
		 *                            Although you can use additional numeric values up to 15 to achieve different effects, be aware
		 *                            that higher values are rendered more slowly.
		 */
		public function BlurFilter(blurX:Number = 4.0, blurY:Number = 4.0, quality:int = 1);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new BlurFilter instance with all the same
		 *                            properties as the original BlurFilter instance.
		 */
		public override function clone():BitmapFilter;
	}
}
