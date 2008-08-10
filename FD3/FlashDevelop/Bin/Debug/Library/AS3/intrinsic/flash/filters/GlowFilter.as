/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public final  class GlowFilter extends BitmapFilter {
		/**
		 * The alpha transparency value for the color. Valid values are 0 to 1.
		 *  For example,
		 *  .25 sets a transparency value of 25%. The default value is 1.
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * The amount of horizontal blur. Valid values are 0 to 255 (floating point). The
		 *  default value is 6. Values that are a power of 2 (such as 2, 4,
		 *  8, 16, and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		/**
		 * The amount of vertical blur. Valid values are 0 to 255 (floating point). The
		 *  default value is 6. Values that are a power of 2 (such as 2, 4,
		 *  8, 16, and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		/**
		 * The color of the glow. Valid values are in the hexadecimal format
		 *  0xRRGGBB. The default value is 0xFF0000.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * Specifies whether the glow is an inner glow. The value true indicates
		 *  an inner glow. The default is false, an outer glow (a glow
		 *  around the outer edges of the object).
		 */
		public function get inner():Boolean;
		public function set inner(value:Boolean):void;
		/**
		 * Specifies whether the object has a knockout effect. A value of true
		 *  makes the object's fill transparent and reveals the background color of the document. The
		 *  default value is false (no knockout effect).
		 */
		public function get knockout():Boolean;
		public function set knockout(value:Boolean):void;
		/**
		 * The number of times to apply the filter. The default value is BitmapFilterQuality.LOW,
		 *  which is equivalent to applying the filter once. The value BitmapFilterQuality.MEDIUM
		 *  applies the filter twice; the value BitmapFilterQuality.HIGH applies it three times.
		 *  Filters with lower values are rendered more quickly.
		 */
		public function get quality():int;
		public function set quality(value:int):void;
		/**
		 * The strength of the imprint or spread. The higher the value,
		 *  the more color is imprinted and the stronger the contrast between the glow and the background.
		 *  Valid values are 0 to 255. The default is 2.
		 */
		public function get strength():Number;
		public function set strength(value:Number):void;
		/**
		 * Initializes a new GlowFilter instance with the specified parameters.
		 *
		 * @param color             <uint (default = 0xFF0000)> The color of the glow, in the hexadecimal format
		 *                            0xRRGGBB. The default value is 0xFF0000.
		 * @param alpha             <Number (default = 1.0)> The alpha transparency value for the color. Valid values are 0 to 1. For example,
		 *                            .25 sets a transparency value of 25%.
		 * @param blurX             <Number (default = 6.0)> The amount of horizontal blur. Valid values are 0 to 255 (floating point). Values
		 *                            that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *                            to render more quickly than other values.
		 * @param blurY             <Number (default = 6.0)> The amount of vertical blur. Valid values are 0 to 255 (floating point).
		 *                            Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *                            to render more quickly than other values.
		 * @param strength          <Number (default = 2)> The strength of the imprint or spread. The higher the value,
		 *                            the more color is imprinted and the stronger the contrast between the glow and the background.
		 *                            Valid values are 0 to 255.
		 * @param quality           <int (default = 1)> The number of times to apply the filter. Use the BitmapFilterQuality constants:
		 *                            BitmapFilterQuality.LOW
		 *                            BitmapFilterQuality.MEDIUM
		 *                            BitmapFilterQuality.HIGH
		 *                            For more information, see the description of the quality property.
		 * @param inner             <Boolean (default = false)> Specifies whether the glow is an inner glow. The value  true specifies
		 *                            an inner glow. The value false specifies an outer glow (a glow
		 *                            around the outer edges of the object).
		 * @param knockout          <Boolean (default = false)> Specifies whether the object has a knockout effect. The value true
		 *                            makes the object's fill transparent and reveals the background color of the document.
		 */
		public function GlowFilter(color:uint = 0xFF0000, alpha:Number = 1.0, blurX:Number = 6.0, blurY:Number = 6.0, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new GlowFilter instance with all the
		 *                            properties of the original GlowFilter instance.
		 */
		public override function clone():BitmapFilter;
	}
}
