package mx.utils
{
	/**
	 *  The ColorUtil class is an all-static class *  with methods for working with RGB colors within Flex. *  You do not create instances of ColorUtil; *  instead you simply call static methods such as  *  the <code>ColorUtil.adjustBrightness()</code> method.
	 */
	public class ColorUtil
	{
		/**
		 *  Performs a linear brightness adjustment of an RGB color.	 *	 *  <p>The same amount is added to the red, green, and blue channels	 *  of an RGB color.	 *  Each color channel is limited to the range 0 through 255.</p>	 *	 *  @param rgb Original RGB color.	 *	 *  @param brite Amount to be added to each color channel.	 *  The range for this parameter is -255 to 255;	 *  -255 produces black while 255 produces white.	 *  If this parameter is 0, the RGB color returned	 *  is the same as the original color.	 *	 *  @return New RGB color.
		 */
		public static function adjustBrightness (rgb:uint, brite:Number) : uint;
		/**
		 *  Performs a scaled brightness adjustment of an RGB color.	 *	 *  @param rgb Original RGB color.	 *	 *  @param brite The percentage to brighten or darken the original color.	 *  If positive, the original color is brightened toward white	 *  by this percentage. If negative, it is darkened toward black	 *  by this percentage.	 *  The range for this parameter is -100 to 100;	 *  -100 produces black while 100 produces white.	 *  If this parameter is 0, the RGB color returned	 *  is the same as the original color.	 *	 *  @return New RGB color.
		 */
		public static function adjustBrightness2 (rgb:uint, brite:Number) : uint;
		/**
		 *  Performs an RGB multiplication of two RGB colors.	 *  	 *  <p>This always results in a darker number than either	 *  original color unless one of them is white,	 *  in which case the other color is returned.</p>	 *	 *  @param rgb1 First RGB color.	 *	 *  @param rgb2 Second RGB color.	 *	 *  @return RGB multiplication of the two colors.
		 */
		public static function rgbMultiply (rgb1:uint, rgb2:uint) : uint;
	}
}
