package mx.core
{
	import flash.text.FontStyle;
	import flash.utils.Dictionary;

include "../core/Version.as"
	/**
	 *  @private
 *  A singleton to contain a list of all the embeded fonts in use
 *  and the associated SWF/moduleFactory where the fonts are defined.
	 */
	public class EmbeddedFontRegistry implements IEmbeddedFontRegistry
	{
		/**
		 *  @private
		 */
		private static var fonts : Object;
		/**
		 *  @private
		 */
		private static var instance : IEmbeddedFontRegistry;

		/**
		 *  @private
		 */
		public static function getInstance () : IEmbeddedFontRegistry;

		/**
		 *  @private
	 *	Creates a key for the embedded font.
	 * 
	 *  @param font	FlexFont object, may not be null.
	 *
	 *  @return String key
		 */
		private static function createFontKey (font:EmbeddedFont) : String;

		/**
		 * Create an embedded font from a font key.
	 *
	 * @param key A string that represents a key created by createFontKey(), may not be null.
	 * 
	 * return An embedded font with the attributes from the key.
		 */
		private static function createEmbeddedFont (key:String) : EmbeddedFont;

		/**
		 * Test if a string end with another string.
	 * 
	 * @returns index into string if it ends with the matching string, otherwise returns -1.
		 */
		private static function endsWith (s:String, match:String) : int;

		/**
		 *  @private
	 *  Registers fonts from the info["fonts"] startup information.
	 * 
	 *  @param fonts Object obtained from the info["fonts"] call
	 *  on a moduleFactory object.
	 *
	 *  @param moduleFactory The module factory of the caller.
		 */
		public static function registerFonts (fonts:Object, moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  Convert a font styles into a String as using by flash.text.FontStyle.
	 * 
	 *  @param bold true if the font is bold, false otherwise.
	 *
	 *  @param italic true if the font is italic, false otherwise.
	 *
	 *  @return A String that matches one of the values in flash.text.FontStyle.
		 */
		public static function getFontStyle (bold:Boolean, italic:Boolean) : String;

		/**
		 *  @inheritDoc
		 */
		public function registerFont (font:EmbeddedFont, moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  @inheritDoc
		 */
		public function deregisterFont (font:EmbeddedFont, moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  @inheritDoc
		 */
		public function getFonts () : Array;

		/**
		 *  @inheritDoc
		 */
		public function getAssociatedModuleFactory (font:EmbeddedFont, defaultModuleFactory:IFlexModuleFactory) : IFlexModuleFactory;
	}
}
