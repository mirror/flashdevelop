package mx.skins.halo
{
	import mx.utils.ColorUtil;

	/**
	 *  Defines the colors used by components that support the Halo theme.
	 */
	public class HaloColors
	{
		/**
		 *  @private
		 */
		private static var cache : Object;

		/**
		 *  Returns a unique hash key based on the colors that are	 *  passed in. This key is used to store the calculated colors	 *  so they only need to be calculated once.	 *	 *  @param colors An arbitrary number of RGB colors expressed	 *  as <code>uint</code> values (for example, 0xFF0000).
		 */
		public static function getCacheKey (...colors) : String;
		/**
		 *  Calculates colors that are used by components that 	 *  support the Halo theme, such as the colors of beveled	 *  edges.  This method uses the <code>themeColor</code> and	 *  <code>fillColors</code> properties to calculate its	 *  colors.	 * 	 *  @param colors The object on which the calculated color	 *  values are stored.  	 *  	 *  @param themeColor The value of the <code>themeColor</code>	 *  style property.	 * 	 * @param fillColor0 The start color of a fill.	 * @param fillColor1 The end color of a fill.
		 */
		public static function addHaloColors (colors:Object, themeColor:uint, fillColor0:uint, fillColor1:uint) : void;
	}
}
