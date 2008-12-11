package flash.text.engine
{
	/// The FontDescription class represents properties necessary to describe a font.
	public class FontDescription
	{
		/// The rendering mode used for this text.
		public var renderingMode:String;

		/// Specifies how the font should be looked up.
		public var fontLookup:String;

		/// The name of the font to use, or a comma-separated list of font names.
		public var fontName:String;

		/// Specifies the font posture.
		public var fontPosture:String;

		/// Specifies the font weight.
		public var fontWeight:String;

		/// The type of CFF hinting used for this text.
		public var cffHinting:String;

		/// Indicates whether or not the FontDescription is locked.
		public var locked:Boolean;

		/// [FP10] Creates a FontDescription object.
		public function FontDescription(fontName:String=_serif, fontWeight:String=normal, fontPosture:String=normal, fontLookup:String=device, renderingMode:String=cff, cffHinting:String=horizontalStem);

		/// [FP10] Returns true if an embedded font is available with the specified fontName, fontWeight, and fontPosture where Font.fontType is flash.text.FontType.EMBEDDED_CFF.
		public static function isFontCompatible(fontName:String, fontWeight:String, fontPosture:String):Boolean;

		/// [FP10] Constructs an unlocked, cloned copy of the FontDescription.
		public function clone():flash.text.engine.FontDescription;

	}

}

