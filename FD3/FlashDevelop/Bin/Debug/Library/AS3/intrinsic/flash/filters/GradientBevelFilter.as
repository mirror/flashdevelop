/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public final  class GradientBevelFilter extends BitmapFilter {
		/**
		 * An array of alpha transparency values for the corresponding colors in the
		 *  colors array. Valid values for each element
		 *  in the array are 0 to 1. For example, .25 sets a transparency value of 25%.
		 */
		public function get alphas():Array;
		public function set alphas(value:Array):void;
		/**
		 * The angle, in degrees. Valid values are 0 to 360. The default is 45.
		 */
		public function get angle():Number;
		public function set angle(value:Number):void;
		/**
		 * The amount of horizontal blur. Valid values are 0 to 255. A blur of 1 or
		 *  less means that the original image is copied as is. The default value
		 *  is 4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		/**
		 * The amount of vertical blur. Valid values are 0 to 255. A blur of 1 or less
		 *  means that the original image is copied as is. The default value is
		 *  4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *  to render more quickly than other values.
		 */
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		/**
		 * An array of RGB hexadecimal color values to use in the gradient.
		 *  For example, red is 0xFF0000, blue is 0x0000FF, and so on.
		 */
		public function get colors():Array;
		public function set colors(value:Array):void;
		/**
		 * The offset distance. Valid values are 0 to 8. The default value is 4.0.
		 */
		public function get distance():Number;
		public function set distance(value:Number):void;
		/**
		 * Specifies whether the object has a knockout effect. A knockout effect
		 *  makes the object's fill transparent and reveals the background color of the document.
		 *  The value true specifies a knockout effect;
		 *  the default is false (no knockout effect).
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
		 * An array of color distribution ratios for the corresponding colors in the
		 *  colors array. Valid values for each element
		 *  in the array are 0 to 255.
		 */
		public function get ratios():Array;
		public function set ratios(value:Array):void;
		/**
		 * The strength of the imprint or spread. The higher the value, the more color is imprinted
		 *  and the stronger the contrast between the bevel and the background.
		 *  Valid values are 0 to 255.
		 *  A value of 0 means that the filter is not applied. The default value is 1.
		 */
		public function get strength():Number;
		public function set strength(value:Number):void;
		/**
		 * The placement of the bevel effect. Possible values are BitmapFilterType constants:
		 *  BitmapFilterType.OUTER - Bevel on the outer edge of the object
		 *  BitmapFilterType.INNER - Bevel on the inner edge of the object
		 *  BitmapFilterType.FULL - Bevel on top of the object
		 */
		public function get type():String;
		public function set type(value:String):void;
		/**
		 * Initializes the filter with the specified parameters.
		 *
		 * @param distance          <Number (default = 4.0)> The offset distance. Valid values are 0 to 8.
		 * @param angle             <Number (default = 45)> The angle, in degrees. Valid values are 0 to 360.
		 * @param colors            <Array (default = null)> An array of RGB hexadecimal color values to use in the gradient.
		 *                            For example, red is 0xFF0000, blue is 0x0000FF, and so on.
		 * @param alphas            <Array (default = null)> An array of alpha transparency values for the corresponding colors in
		 *                            the colors array. Valid values for each element in the array are 0 to 1.
		 *                            For example, .25 sets a transparency value of 25%.
		 * @param ratios            <Array (default = null)> An array of color distribution ratios; valid values are
		 *                            0 to 255.
		 * @param blurX             <Number (default = 4.0)> The amount of horizontal blur. Valid values are 0 to 255. A blur of 1 or
		 *                            less means that the original image is copied as is. The default value
		 *                            is 4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized
		 *                            to render more quickly than other values.
		 * @param blurY             <Number (default = 4.0)> The amount of vertical blur. Valid values are 0 to 255. A blur of 1 or less
		 *                            means that the original image is copied as is. Values that are a power of 2
		 *                            (such as 2, 4, 8, 16 and 32) are optimized
		 *                            to render more quickly than other values.
		 * @param strength          <Number (default = 1)> The strength of the imprint or spread. The higher the value, the more color
		 *                            is imprinted and the stronger the contrast between the bevel and the background.
		 *                            Valid values are 0 to 255. A value of 0 means that the filter is not applied.
		 * @param quality           <int (default = 1)> The quality of the filter. Use BitmapFilterQuality constants:
		 *                            BitmapFilterQuality.LOW
		 *                            BitmapFilterQuality.MEDIUM
		 *                            BitmapFilterQuality.HIGH
		 *                            For more information, see the description of the quality property.
		 * @param type              <String (default = "inner")> The placement of the bevel effect. Possible values are BitmapFilterType constants:
		 *                            BitmapFilterType.OUTER - Bevel on the outer edge of the object
		 *                            BitmapFilterType.INNER - Bevel on the inner edge of the object
		 *                            BitmapFilterType.FULL - Bevel on top of the object
		 * @param knockout          <Boolean (default = false)> Specifies whether a knockout effect is applied. The value true
		 *                            makes the object's fill transparent and reveals the background color of the document.
		 */
		public function GradientBevelFilter(distance:Number = 4.0, angle:Number = 45, colors:Array = null, alphas:Array = null, ratios:Array = null, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new GradientBevelFilter instance with all the
		 *                            same properties as the original GradientBevelFilter instance.
		 */
		public override function clone():BitmapFilter;
	}
}
