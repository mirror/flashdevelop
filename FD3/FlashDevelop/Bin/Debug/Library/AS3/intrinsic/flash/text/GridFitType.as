/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	public final  class GridFitType {
		/**
		 * Doesn't set grid fitting. Horizontal and vertical lines
		 *  in the glyphs are not forced to the pixel grid.
		 *  This constant is used in setting the gridFitType property of the
		 *  TextField class. This is often a good setting for animation
		 *  or for large font sizes.
		 *  Use the syntax GridFitType.NONE.
		 */
		public static const NONE:String = "none";
		/**
		 * Fits strong horizontal and vertical lines to the pixel grid.
		 *  This constant is used in setting the gridFitType property of the
		 *  TextField class. This setting only works for left-justified text
		 *  fields and acts like the GridFitType.SUBPIXEL constant in static
		 *  text. This setting generally provides the best readability for left-aligned text.
		 *  Use the syntax GridFitType.PIXEL.
		 */
		public static const PIXEL:String = "pixel";
		/**
		 * Fits strong horizontal and vertical lines to the sub-pixel
		 *  grid on LCD monitors. (Red, green, and blue are actual pixels on an LCD screen.)
		 *  This is often a good setting for right-aligned or center-aligned dynamic
		 *  text, and it is sometimes a useful tradeoff for animation vs. text quality.
		 *  This constant is used in setting the gridFitType property of the
		 *  TextField class.
		 *  Use the syntax GridFitType.SUBPIXEL.
		 */
		public static const SUBPIXEL:String = "subpixel";
	}
}
