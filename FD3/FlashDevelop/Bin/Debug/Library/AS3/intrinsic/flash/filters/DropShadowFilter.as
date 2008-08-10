/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public final  class DropShadowFilter extends BitmapFilter {
		/**
		 * The alpha transparency value for the shadow color. Valid values are 0.0 to 1.0.
		 *  For example,
		 *  .25 sets a transparency value of 25%. The default value is 1.0.
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * The angle of the shadow. Valid values are 0 to 360 degrees (floating point). The
		 *  default value is 45.
		 */
		public function get angle():Number;
		public function set angle(value:Number):void;
		/**
		 * The amount of horizontal blur. Valid values are 0 to 255.0 (floating point). The
		 *  default value is 4.0.
		 */
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		/**
		 * The amount of vertical blur. Valid values are 0 to 255.0 (floating point). The
		 *  default value is 4.0.
		 */
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		/**
		 * The color of the shadow. Valid values are in hexadecimal format 0xRRGGBB. The
		 *  default value is 0x000000.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * The offset distance for the shadow, in pixels. The default
		 *  value is 4.0 (floating point).
		 */
		public function get distance():Number;
		public function set distance(value:Number):void;
		/**
		 * Indicates whether or not the object is hidden. The value true
		 *  indicates that the object itself is not drawn; only the shadow is visible.
		 *  The default is false (the object is shown).
		 */
		public function get hideObject():Boolean;
		public function set hideObject(value:Boolean):void;
		/**
		 * Indicates whether or not the shadow is an inner shadow. The value true indicates
		 *  an inner shadow. The default is false, an outer shadow (a
		 *  shadow around the outer edges of the object).
		 */
		public function get inner():Boolean;
		public function set inner(value:Boolean):void;
		/**
		 * Applies a knockout effect (true), which effectively
		 *  makes the object's fill transparent and reveals the background color of the document. The
		 *  default is false (no knockout).
		 */
		public function get knockout():Boolean;
		public function set knockout(value:Boolean):void;
		/**
		 * The number of times to apply the filter.
		 *  The default value is BitmapFilterQuality.LOW, which is equivalent to applying
		 *  the filter once. The value BitmapFilterQuality.MEDIUM applies the filter twice;
		 *  the value BitmapFilterQuality.HIGH applies it three times. Filters with lower values
		 *  are rendered more quickly.
		 */
		public function get quality():int;
		public function set quality(value:int):void;
		/**
		 * The strength of the imprint or spread. The higher the value,
		 *  the more color is imprinted and the stronger the contrast between the shadow and the background.
		 *  Valid values are from 0 to 255.0. The default is 1.0.
		 */
		public function get strength():Number;
		public function set strength(value:Number):void;
		/**
		 * Creates a new DropShadowFilter instance with the specified parameters.
		 *
		 * @param distance          <Number (default = 4.0)> Offset distance for the shadow, in pixels.
		 * @param angle             <Number (default = 45)> Angle of the shadow, 0 to 360 degrees (floating point).
		 * @param color             <uint (default = 0)> Color of the shadow, in hexadecimal format
		 *                            0xRRGGBB. The default value is 0x000000.
		 * @param alpha             <Number (default = 1.0)> Alpha transparency value for the shadow color. Valid values are 0.0 to 1.0.
		 *                            For example,
		 *                            .25 sets a transparency value of 25%.
		 * @param blurX             <Number (default = 4.0)> Amount of horizontal blur. Valid values are 0 to 255.0 (floating point).
		 * @param blurY             <Number (default = 4.0)> Amount of vertical blur. Valid values are 0 to 255.0 (floating point).
		 * @param strength          <Number (default = 1.0)> The strength of the imprint or spread. The higher the value,
		 *                            the more color is imprinted and the stronger the contrast between the shadow and the background.
		 *                            Valid values are 0 to 255.0.
		 * @param quality           <int (default = 1)> The number of times to apply the filter. Use the BitmapFilterQuality constants:
		 *                            BitmapFilterQuality.LOW
		 *                            BitmapFilterQuality.MEDIUM
		 *                            BitmapFilterQuality.HIGH
		 *                            For more information about these values, see the quality property description.
		 * @param inner             <Boolean (default = false)> Indicates whether or not the shadow is an inner shadow. A value of true specifies
		 *                            an inner shadow. A value of false specifies an outer shadow (a
		 *                            shadow around the outer edges of the object).
		 * @param knockout          <Boolean (default = false)> Applies a knockout effect (true), which effectively
		 *                            makes the object's fill transparent and reveals the background color of the document.
		 * @param hideObject        <Boolean (default = false)> Indicates whether or not the object is hidden. A value of true
		 *                            indicates that the object itself is not drawn; only the shadow is visible.
		 */
		public function DropShadowFilter(distance:Number = 4.0, angle:Number = 45, color:uint = 0, alpha:Number = 1.0, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1.0, quality:int = 1, inner:Boolean = false, knockout:Boolean = false, hideObject:Boolean = false);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new DropShadowFilter instance with all the
		 *                            properties of the original DropShadowFilter instance.
		 */
		public override function clone():BitmapFilter;
	}
}
