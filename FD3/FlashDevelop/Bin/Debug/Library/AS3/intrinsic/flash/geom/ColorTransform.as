/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.geom {
	public class ColorTransform {
		/**
		 * A decimal value that is multiplied with the alpha transparency channel value.
		 */
		public var alphaMultiplier:Number;
		/**
		 * A number from -255 to 255 that is added to the alpha transparency channel value after it has
		 *  been multiplied by the alphaMultiplier value.
		 */
		public var alphaOffset:Number;
		/**
		 * A decimal value that is multiplied with the blue channel value.
		 */
		public var blueMultiplier:Number;
		/**
		 * A number from -255 to 255 that is added to the blue channel value after it has
		 *  been multiplied by the blueMultiplier value.
		 */
		public var blueOffset:Number;
		/**
		 * The RGB color value for a ColorTransform object.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * A decimal value that is multiplied with the green channel value.
		 */
		public var greenMultiplier:Number;
		/**
		 * A number from -255 to 255 that is added to the green channel value after it has
		 *  been multiplied by the greenMultiplier value.
		 */
		public var greenOffset:Number;
		/**
		 * A decimal value that is multiplied with the red channel value.
		 */
		public var redMultiplier:Number;
		/**
		 * A number from -255 to 255 that is added to the red channel value after it has been
		 *  multiplied by the redMultiplier value.
		 */
		public var redOffset:Number;
		/**
		 * Creates a ColorTransform object for a display object with the specified
		 *  color channel values and alpha values.
		 *
		 * @param redMultiplier     <Number (default = 1.0)> The value for the red multiplier, in the range from 0 to 1.
		 * @param greenMultiplier   <Number (default = 1.0)> The value for the green multiplier, in the range from 0 to 1.
		 * @param blueMultiplier    <Number (default = 1.0)> The value for the blue multiplier, in the range from 0 to 1.
		 * @param alphaMultiplier   <Number (default = 1.0)> The value for the alpha transparency multiplier, in the range from 0 to 1.
		 * @param redOffset         <Number (default = 0)> The offset value for the red color channel, in the range from -255 to 255.
		 * @param greenOffset       <Number (default = 0)> The offset value for the green color channel, in the range from -255 to 255.
		 * @param blueOffset        <Number (default = 0)> The offset for the blue color channel value, in the range from -255 to 255.
		 * @param alphaOffset       <Number (default = 0)> The offset for alpha transparency channel value, in the range from -255 to 255.
		 */
		public function ColorTransform(redMultiplier:Number = 1.0, greenMultiplier:Number = 1.0, blueMultiplier:Number = 1.0, alphaMultiplier:Number = 1.0, redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0);
		/**
		 * Concatenates the ColorTranform object specified by the second parameter
		 *  with the current ColorTransform object and sets the
		 *  current object as the result, which is an additive combination of the two color transformations.
		 *  When you apply the concatenated ColorTransform object, the effect is the same as applying the
		 *  second color transformation after the original color transformation.
		 *
		 * @param second            <ColorTransform> The ColorTransform object to be combined with the current ColorTransform object.
		 */
		public function concat(second:ColorTransform):void;
		/**
		 * Formats and returns a string that describes all of the properties of the
		 *  ColorTransform object.
		 *
		 * @return                  <String> A string that lists all of the properties of the ColorTransform object.
		 */
		public function toString():String;
	}
}
