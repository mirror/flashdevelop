/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.skins.halo {
	public class HaloColors {
		/**
		 * Calculates colors that are used by components that support the Halo theme, such as the colors of beveled edges.
		 *  This method uses the themeColor and fillColors properties to calculate its colors.
		 *
		 * @param colors            <Object> 
		 * @param themeColor        <uint> The value of the themeColor style property.
		 * @param fillColor0        <uint> The start color of a fill.
		 * @param fillColor1        <uint> The end color of a fill.
		 */
		public static function addHaloColors(colors:Object, themeColor:uint, fillColor0:uint, fillColor1:uint):void;
		/**
		 * Returns a unique hash key based on the colors that are passed in. This
		 *  key is used to store the calculated colors so they only need to be
		 *  calculated once.
		 */
		public static function getCacheKey(... colors):String;
	}
}
