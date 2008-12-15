
package flash.filters 
{
	public final class DisplacementMapFilterMode 
	{
		/**
		 * Clamps the displacement value to the edge of the source image.
		 *  Use with the DisplacementMapFilter.mode property.
		 */
		public static const CLAMP:String = "clamp";
		/**
		 * If the displacement value is outside the image, substitutes the values in
		 *  the color and alpha properties.
		 *  Use with the DisplacementMapFilter.mode property.
		 */
		public static const COLOR:String = "color";
		/**
		 * If the displacement value is out of range, ignores the displacement and uses the source pixel.
		 *  Use with the DisplacementMapFilter.mode property.
		 */
		public static const IGNORE:String = "ignore";
		/**
		 * Wraps the displacement value to the other side of the source image.
		 *  Use with the DisplacementMapFilter.mode property.
		 */
		public static const WRAP:String = "wrap";
	}
	
}
