package flash.display 
{
	public final class InterpolationMethod 
	{
		/**
		 * Specifies that the linear RGB interpolation method should be used. This means that
		 *  an RGB color space based on a linear RGB color model is used.
		 */
		public static const LINEAR_RGB:String = "linearRGB";
		/**
		 * Specifies that the RGB interpolation method should be used. This means that the gradient is rendered with
		 *  exponential sRGB (standard RGB) space.
		 *  The sRGB space is a W3C-endorsed standard that defines a non-linear conversion between
		 *  red, green, and blue component values and the actual intensity of the visible component color.
		 */
		public static const RGB:String = "rgb";
	}
	
}