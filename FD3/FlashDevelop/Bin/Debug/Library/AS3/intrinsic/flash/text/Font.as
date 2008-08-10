/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	public class Font {
		/**
		 * The name of an embedded font.
		 */
		public function get fontName():String;
		/**
		 * The style of the font. This value can be any of the values defined in the FontStyle class.
		 */
		public function get fontStyle():String;
		/**
		 * The type of the font. This value can be any of the constants defined in the FontType class.
		 */
		public function get fontType():String;
		/**
		 * Specifies whether to provide a list of the currently available embedded fonts.
		 *
		 * @param enumerateDeviceFonts<Boolean (default = false)> Indicates whether you want to limit the list to only the currently available embedded fonts.
		 *                            If this is set to true then a list of all fonts, both device fonts and embedded fonts, is returned.
		 *                            If this is set to false then only a list of embedded fonts is returned.
		 * @return                  <Array> A list of available fonts as an array of Font objects.
		 */
		public static function enumerateFonts(enumerateDeviceFonts:Boolean = false):Array;
		/**
		 * Specifies whether a provided string can be displayed using the currently assigned font.
		 *
		 * @param str               <String> The string to test against the current font.
		 * @return                  <Boolean> A value of true if the specified string can be fully displayed using this font.
		 */
		public function hasGlyphs(str:String):Boolean;
		/**
		 * Registers a font class in the global font list.
		 *
		 * @param font              <Class> The class you want to add to the global font list.
		 */
		public static function registerFont(font:Class):void;
	}
}
