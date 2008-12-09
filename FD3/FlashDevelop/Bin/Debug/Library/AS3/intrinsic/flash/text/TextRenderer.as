package flash.text
{
	/// The TextRenderer class provides functionality for the advanced anti-aliasing capability of embedded fonts.
	public class TextRenderer
	{
		/// The adaptively sampled distance fields (ADFs) quality level for advanced anti-aliasing.
		public var maxLevel:int;

		/// Controls the rendering of advanced anti-aliased text.
		public var displayMode:String;

		/// Sets a custom continuous stroke modulation (CSM) lookup table for a font.
		public static function setAdvancedAntiAliasingTable(fontName:String, fontStyle:String, colorType:String, advancedAntiAliasingTable:Array):void;

	}

}

