package mx.core
{
	import flash.text.FontStyle;

include "../core/Version.as"
	/**
	 *  @private
 *  Describes the properties that make an embedded font unique.
	 */
	public class EmbeddedFont
	{
		/**
		 *  @private
	 *  Storage for the fontName property.
		 */
		private var _fontName : String;
		/**
		 *  @private
	 *  Storage for the fontStyle property.
		 */
		private var _fontStyle : String;

		/**
		 *  The name of the font.
		 */
		public function get fontName () : String;

		/**
		 *  The style of the font.
	 *  The value is one of the values in flash.text.FontStyle.
		 */
		public function get fontStyle () : String;

		/**
		 *  Create a new EmbeddedFont object.
	 * 
	 *  @param fontName The name of the font.
	 *
	 *  @param bold true if the font is bold, false otherwise.
	 *
	 *  @param italic true if the fotn is italic, false otherwise,
		 */
		public function EmbeddedFont (fontName:String, bold:Boolean, italic:Boolean);
	}
}
