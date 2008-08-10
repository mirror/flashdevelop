/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class ColorUtil {
		/**
		 * Performs a linear brightness adjustment of an RGB color.
		 *
		 * @param rgb               <uint> Original RGB color.
		 * @param brite             <Number> Amount to be added to each color channel.
		 *                            The range for this parameter is -255 to 255;
		 *                            -255 produces black while 255 produces white.
		 *                            If this parameter is 0, the RGB color returned
		 *                            is the same as the original color.
		 * @return                  <uint> New RGB color.
		 */
		public static function adjustBrightness(rgb:uint, brite:Number):uint;
		/**
		 * Performs a scaled brightness adjustment of an RGB color.
		 *
		 * @param rgb               <uint> Original RGB color.
		 * @param brite             <Number> The percentage to brighten or darken the original color.
		 *                            If positive, the original color is brightened toward white
		 *                            by this percentage. If negative, it is darkened toward black
		 *                            by this percentage.
		 *                            The range for this parameter is -100 to 100;
		 *                            -100 produces black while 100 produces white.
		 *                            If this parameter is 0, the RGB color returned
		 *                            is the same as the original color.
		 * @return                  <uint> New RGB color.
		 */
		public static function adjustBrightness2(rgb:uint, brite:Number):uint;
		/**
		 * Performs an RGB multiplication of two RGB colors.
		 *
		 * @param rgb1              <uint> First RGB color.
		 * @param rgb2              <uint> Second RGB color.
		 * @return                  <uint> RGB multiplication of the two colors.
		 */
		public static function rgbMultiply(rgb1:uint, rgb2:uint):uint;
	}
}
