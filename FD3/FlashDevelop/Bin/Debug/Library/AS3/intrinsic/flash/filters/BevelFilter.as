/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public final  class BevelFilter extends BitmapFilter {
		/**
		 * The angle of the bevel. Valid values are from 0 to 360°. The default value is 45°.
		 */
		public function get angle():Number;
		public function set angle(value:Number):void;
		/**
		 * The amount of horizontal blur, in pixels. Valid values are from 0 to 255 (floating point).
		 *  The default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16, and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		/**
		 * The amount of vertical blur, in pixels. Valid values are from 0 to 255 (floating point).
		 *  The default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16, and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		/**
		 * The offset distance of the bevel. Valid values are in pixels (floating point). The default is 4.
		 */
		public function get distance():Number;
		public function set distance(value:Number):void;
		/**
		 * The alpha transparency value of the highlight color. The value is specified as a normalized
		 *  value from 0 to 1. For example,
		 *  .25 sets a transparency value of 25%. The default value is 1.
		 */
		public function get highlightAlpha():Number;
		public function set highlightAlpha(value:Number):void;
		/**
		 * The highlight color of the bevel. Valid values are in hexadecimal format,
		 *  0xRRGGBB. The default is 0xFFFFFF.
		 */
		public function get highlightColor():uint;
		public function set highlightColor(value:uint):void;
		/**
		 * Applies a knockout effect (true), which effectively
		 *  makes the object's fill transparent and reveals the background color of the document. The
		 *  default value is false (no knockout).
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
		 * The alpha transparency value of the shadow color. This value is specified as a normalized
		 *  value from 0 to 1. For example,
		 *  .25 sets a transparency value of 25%. The default is 1.
		 */
		public function get shadowAlpha():Number;
		public function set shadowAlpha(value:Number):void;
		/**
		 * The shadow color of the bevel. Valid values are in hexadecimal format, 0xRRGGBB. The default
		 *  is 0x000000.
		 */
		public function get shadowColor():uint;
		public function set shadowColor(value:uint):void;
		/**
		 * The strength of the imprint or spread. Valid values are from 0 to 255. The larger the value,
		 *  the more color is imprinted and the stronger the contrast between the bevel and the background.
		 *  The default value is 1.
		 */
		public function get strength():Number;
		public function set strength(value:Number):void;
		/**
		 * The placement of the bevel on the object. Inner and outer bevels are placed on
		 *  the inner or outer edge; a full bevel is placed on the entire object.
		 *  Valid values are the BitmapFilterType constants:
		 *  BitmapFilterType.INNER
		 *  BitmapFilterType.OUTER
		 *  BitmapFilterType.FULL
		 */
		public function get type():String;
		public function set type(value:String):void;
		/**
		 * Initializes a new BevelFilter instance with the specified parameters.
		 *
		 * @param distance          <Number (default = 4.0)> The offset distance of the bevel, in pixels (floating point).
		 * @param angle             <Number (default = 45)> The angle of the bevel, from 0 to 360 degrees.
		 * @param highlightColor    <uint (default = 0xFFFFFF)> The highlight color of the bevel, 0xRRGGBB.
		 * @param highlightAlpha    <Number (default = 1.0)> The alpha transparency value of the highlight color. Valid values are 0.0 to
		 *                            1.0. For example,
		 *                            .25 sets a transparency value of 25%.
		 * @param shadowColor       <uint (default = 0x000000)> The shadow color of the bevel, 0xRRGGBB.
		 * @param shadowAlpha       <Number (default = 1.0)> The alpha transparency value of the shadow color. Valid values are 0.0 to 1.0. For example,
		 *                            .25 sets a transparency value of 25%.
		 * @param blurX             <Number (default = 4.0)> The amount of horizontal blur in pixels. Valid values are 0 to 255.0 (floating point).
		 * @param blurY             <Number (default = 4.0)> The amount of vertical blur in pixels. Valid values are 0 to 255.0 (floating point).
		 * @param strength          <Number (default = 1)> The strength of the imprint or spread. The higher the value, the more color is imprinted and the stronger the contrast between the bevel and the background. Valid values are 0 to 255.0.
		 * @param quality           <int (default = 1)> The quality of the bevel. Valid values are 0 to 15, but for most applications,
		 *                            you can use BitmapFilterQuality constants:
		 *                            BitmapFilterQuality.LOW
		 *                            BitmapFilterQuality.MEDIUM
		 *                            BitmapFilterQuality.HIGH
		 *                            Filters with lower values render faster. You can use
		 *                            the other available numeric values to achieve different effects.
		 * @param type              <String (default = "inner")> The type of bevel. Valid values are BitmapFilterType constants:
		 *                            BitmapFilterType.INNER, BitmapFilterType.OUTER, or
		 *                            BitmapFilterType.FULL.
		 * @param knockout          <Boolean (default = false)> Applies a knockout effect (true), which effectively
		 *                            makes the object's fill transparent and reveals the background color of the document.
		 */
		public function BevelFilter(distance:Number = 4.0, angle:Number = 45, highlightColor:uint = 0xFFFFFF, highlightAlpha:Number = 1.0, shadowColor:uint = 0x000000, shadowAlpha:Number = 1.0, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new BevelFilter instance with all the same properties as
		 *                            the original BevelFilter instance.
		 */
		public override function clone():BitmapFilter;
	}
}
