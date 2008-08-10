/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public class ConvolutionFilter extends BitmapFilter {
		/**
		 * The alpha transparency value of the substitute color. Valid values are 0 to 1.0. The default is 0. For example,
		 *  .25 sets a transparency value of 25%.
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * The amount of bias to add to the result of the matrix transformation.
		 *  The bias increases the color value of each channel, so that dark colors
		 *  appear brighter. The default value is 0.
		 */
		public function get bias():Number;
		public function set bias(value:Number):void;
		/**
		 * Indicates whether the image should be clamped. For pixels off the source image, a value of
		 *  true indicates that the input
		 *  image is extended along each of its borders as necessary by duplicating the color values at each
		 *  respective edge of the input image. A value of false indicates that another color should
		 *  be used, as specified in the color and alpha properties.
		 *  The default is true.
		 */
		public function get clamp():Boolean;
		public function set clamp(value:Boolean):void;
		/**
		 * The hexadecimal color to substitute for pixels that are off the source image.
		 *  It is an RGB value with no alpha component. The default is 0.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * The divisor used during matrix transformation. The default value is 1.
		 *  A divisor that is the sum of all the matrix values smooths out the overall color intensity of the
		 *  result. A value of 0 is ignored and the default is used instead.
		 */
		public function get divisor():Number;
		public function set divisor(value:Number):void;
		/**
		 * An array of values used for matrix transformation. The number of items
		 *  in the array must equal matrixX * matrixY.
		 */
		public function get matrix():Array;
		public function set matrix(value:Array):void;
		/**
		 * The x dimension of the matrix (the number of columns in the matrix). The default
		 *  value is 0.
		 */
		public function get matrixX():Number;
		public function set matrixX(value:Number):void;
		/**
		 * The y dimension of the matrix (the number of rows in the matrix). The default value
		 *  is 0.
		 */
		public function get matrixY():Number;
		public function set matrixY(value:Number):void;
		/**
		 * Indicates if the alpha channel is preserved without the filter effect
		 *  or if the convolution filter is applied
		 *  to the alpha channel as well as the color channels.
		 *  A value of false indicates that the
		 *  convolution applies to all channels, including the
		 *  alpha channel. A value of true indicates that the convolution applies only to the
		 *  color channels. The default value is true.
		 */
		public function get preserveAlpha():Boolean;
		public function set preserveAlpha(value:Boolean):void;
		/**
		 * Initializes a ConvolutionFilter instance with the specified parameters.
		 *
		 * @param matrixX           <Number (default = 0)> The x dimension of the matrix (the number of columns in the matrix). The
		 *                            default value is 0.
		 * @param matrixY           <Number (default = 0)> The y dimension of the matrix (the number of rows in the matrix). The
		 *                            default value is 0.
		 * @param matrix            <Array (default = null)> The array of values used for matrix transformation. The number of
		 *                            items in the array must equal matrixX * matrixY.
		 * @param divisor           <Number (default = 1.0)> The divisor used during matrix transformation. The default value is 1.
		 *                            A divisor that is the sum of all the matrix values evens out the overall color intensity of the
		 *                            result. A value of 0 is ignored and the default is used instead.
		 * @param bias              <Number (default = 0.0)> The bias to add to the result of the matrix transformation. The default value is 0.
		 * @param preserveAlpha     <Boolean (default = true)> A value of false indicates that the alpha value is not
		 *                            preserved and that the convolution applies to all
		 *                            channels, including the alpha channel. A value of true indicates that
		 *                            the convolution applies only to the color channels. The default value is true.
		 * @param clamp             <Boolean (default = true)> For pixels that are off the source image, a value of true indicates that the
		 *                            input image is extended along each of its borders as necessary by duplicating the color values
		 *                            at the given edge of the input image.  A value of false indicates that another
		 *                            color should be used, as specified in the color and alpha properties.
		 *                            The default is true.
		 * @param color             <uint (default = 0)> The hexadecimal color to substitute for pixels that are off the source image.
		 * @param alpha             <Number (default = 0.0)> The alpha of the substitute color.
		 */
		public function ConvolutionFilter(matrixX:Number = 0, matrixY:Number = 0, matrix:Array = null, divisor:Number = 1.0, bias:Number = 0.0, preserveAlpha:Boolean = true, clamp:Boolean = true, color:uint = 0, alpha:Number = 0.0);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> BitmapFilter A new ConvolutionFilter instance with all the same properties as the original
		 *                            ConvolutionMatrixFilter instance.
		 */
		public override function clone():BitmapFilter;
	}
}
