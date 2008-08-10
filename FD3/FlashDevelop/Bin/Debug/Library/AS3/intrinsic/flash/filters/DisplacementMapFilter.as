/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	import flash.display.BitmapData;
	import flash.geom.Point;
	public final  class DisplacementMapFilter extends BitmapFilter {
		/**
		 * Specifies the alpha transparency value to use for out-of-bounds displacements.
		 *  It is specified as a normalized value from 0.0 to 1.0. For example,
		 *  .25 sets a transparency value of 25%. The default value is 0.
		 *  Use this property if the mode property is set to DisplacementMapFilterMode.COLOR.
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * Specifies what color to use for out-of-bounds displacements.  The valid range of
		 *  displacements is 0.0 to 1.0. Values are in hexadecimal format. The default value
		 *  for color is 0. Use this property if the mode property
		 *  is set to DisplacementMapFilterMode.COLOR.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * Describes which color channel to use in the map image to displace the x result.
		 *  Possible values are BitmapDataChannel constants:
		 *  BitmapDataChannel.ALPHA
		 *  BitmapDataChannel.BLUE
		 *  BitmapDataChannel.GREEN
		 *  BitmapDataChannel.RED
		 */
		public function get componentX():uint;
		public function set componentX(value:uint):void;
		/**
		 * Describes which color channel to use in the map image to displace the y result.
		 *  Possible values are BitmapDataChannel constants:
		 *  BitmapDataChannel.ALPHA
		 *  BitmapDataChannel.BLUE
		 *  BitmapDataChannel.GREEN
		 *  BitmapDataChannel.RED
		 */
		public function get componentY():uint;
		public function set componentY(value:uint):void;
		/**
		 * A BitmapData object containing the displacement map data.
		 */
		public function get mapBitmap():BitmapData;
		public function set mapBitmap(value:BitmapData):void;
		/**
		 * A value that contains the offset of the upper-left corner of
		 *  the target display object from the upper-left corner of the map image.
		 */
		public function get mapPoint():Point;
		public function set mapPoint(value:Point):void;
		/**
		 * The mode for the filter. Possible values are DisplacementMapFilterMode
		 *  constants:
		 *  DisplacementMapFilterMode.WRAP - Wraps the displacement value to the other side of the source image.
		 *  DisplacementMapFilterMode.CLAMP - Clamps the displacement value to the edge of the source image.
		 *  DisplacementMapFilterMode.IGNORE - If the displacement value is out of range, ignores the displacement and uses the source pixel.
		 *  DisplacementMapFilterMode.COLOR - If the displacement value is outside the image, substitutes the values in the color and alpha properties.
		 */
		public function get mode():String;
		public function set mode(value:String):void;
		/**
		 * The multiplier to use to scale the x displacement result from the map calculation.
		 */
		public function get scaleX():Number;
		public function set scaleX(value:Number):void;
		/**
		 * The multiplier to use to scale the y displacement result from the map calculation.
		 */
		public function get scaleY():Number;
		public function set scaleY(value:Number):void;
		/**
		 * Initializes a DisplacementMapFilter instance with the specified parameters.
		 *
		 * @param mapBitmap         <BitmapData (default = null)> A BitmapData object containing the displacement map data.
		 * @param mapPoint          <Point (default = null)> A value that contains the offset of the upper-left corner of the
		 *                            target display object from the upper-left corner of the map image.
		 * @param componentX        <uint (default = 0)> Describes which color channel to use in the map image to displace the x result.
		 *                            Possible values are the BitmapDataChannel constants.
		 * @param componentY        <uint (default = 0)> Describes which color channel to use in the map image to displace the y result.
		 *                            Possible values are the BitmapDataChannel constants.
		 * @param scaleX            <Number (default = 0.0)> The multiplier to use to scale the x displacement result from the map calculation.
		 * @param scaleY            <Number (default = 0.0)> The multiplier to use to scale the y displacement result from the map calculation.
		 * @param mode              <String (default = "wrap")> The mode of the filter. Possible values are the DisplacementMapFilterMode
		 *                            constants.
		 * @param color             <uint (default = 0)> Specifies the color to use for out-of-bounds displacements. The valid range of
		 *                            displacements is 0.0 to 1.0. Use this parameter if mode is set to DisplacementMapFilterMode.COLOR.
		 * @param alpha             <Number (default = 0.0)> Specifies what alpha value to use for out-of-bounds displacements.
		 *                            It is specified as a normalized value from 0.0 to 1.0. For example,
		 *                            .25 sets a transparency value of 25%.
		 *                            Use this parameter if mode is set to DisplacementMapFilterMode.COLOR.
		 */
		public function DisplacementMapFilter(mapBitmap:BitmapData = null, mapPoint:Point = null, componentX:uint = 0, componentY:uint = 0, scaleX:Number = 0.0, scaleY:Number = 0.0, mode:String = "wrap", color:uint = 0, alpha:Number = 0.0);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new DisplacementMapFilter instance with all the same properties as the
		 *                            original one.
		 */
		public override function clone():BitmapFilter;
	}
}
