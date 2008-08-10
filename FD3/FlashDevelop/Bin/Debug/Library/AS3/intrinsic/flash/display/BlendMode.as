/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	public final  class BlendMode {
		/**
		 * Adds the values of the constituent colors of the display object to the colors of its background, applying a
		 *  ceiling of 0xFF. This setting is commonly used for animating a lightening dissolve between
		 *  two objects.
		 */
		public static const ADD:String = "add";
		/**
		 * Applies the alpha value of each pixel of the display object to the background.
		 *  This requires the blendMode property of the parent display object be set to
		 *  flash.display.BlendMode.LAYER.
		 */
		public static const ALPHA:String = "alpha";
		/**
		 * Selects the darker of the constituent colors of the display object and the colors of the background (the
		 *  colors with the smaller values). This setting is commonly used for superimposing type.
		 */
		public static const DARKEN:String = "darken";
		/**
		 * Compares the constituent colors of the display object with the colors of its background, and subtracts
		 *  the darker of the values of the two constituent colors from the lighter value. This setting is commonly
		 *  used for more vibrant colors.
		 */
		public static const DIFFERENCE:String = "difference";
		/**
		 * Erases the background based on the alpha value of the display object. This process requires
		 *  that the blendMode property of the parent display object be set to
		 *  flash.display.BlendMode.LAYER.
		 */
		public static const ERASE:String = "erase";
		/**
		 * Adjusts the color of each pixel based on the darkness of the display object.
		 *  If the display object is lighter than 50% gray, the display object and background colors are
		 *  screened, which results in a lighter color. If the display object is darker than 50% gray,
		 *  the colors are multiplied, which results in a darker color.
		 *  This setting is commonly used for shading effects.
		 */
		public static const HARDLIGHT:String = "hardlight";
		/**
		 * Inverts the background.
		 */
		public static const INVERT:String = "invert";
		/**
		 * Forces the creation of a transparency group for the display object. This means that the display
		 *  object is precomposed in a temporary buffer before it is processed further. The precomposition is done
		 *  automatically if the display object is precached by means of bitmap caching or if the display object is
		 *  a display object container that has at least one child object with a blendMode
		 *  setting other than "normal".
		 */
		public static const LAYER:String = "layer";
		/**
		 * Selects the lighter of the constituent colors of the display object and the colors of the background (the
		 *  colors with the larger values). This setting is commonly used for superimposing type.
		 */
		public static const LIGHTEN:String = "lighten";
		/**
		 * Multiplies the values of the display object constituent colors by the constituent colors of
		 *  the background color, and normalizes by dividing by 0xFF,
		 *  resulting in darker colors. This setting is commonly used for shadows and depth effects.
		 */
		public static const MULTIPLY:String = "multiply";
		/**
		 * The display object appears in front of the background. Pixel values of the display object
		 *  override the pixel values of the background. Where the display object is transparent, the
		 *  background is visible.
		 */
		public static const NORMAL:String = "normal";
		/**
		 * Adjusts the color of each pixel based on the darkness of the background.
		 *  If the background is lighter than 50% gray, the display object and background colors are
		 *  screened, which results in a lighter color. If the background is darker than 50% gray,
		 *  the colors are multiplied, which results in a darker color.
		 *  This setting is commonly used for shading effects.
		 */
		public static const OVERLAY:String = "overlay";
		/**
		 * Multiplies the complement (inverse) of the display object color by the complement of the background
		 *  color, resulting in a bleaching effect. This setting is commonly used for highlights or to remove black
		 *  areas of the display object.
		 */
		public static const SCREEN:String = "screen";
		/**
		 * Subtracts the values of the constituent colors in the display object from the values of the background
		 *  color, applying a floor of 0. This setting is commonly used for animating a darkening dissolve between
		 *  two objects.
		 */
		public static const SUBTRACT:String = "subtract";
	}
}
