package flash.text.engine
{
	/// The ElementFormat class represents formatting information which can be applied to a ContentElement.
	public class ElementFormat
	{
		/// Specifies which of the baselines of the line containing the element the dominantBaseline snaps to, thus determining the vertical position of the element in the line.
		public var alignmentBaseline:String;

		/// Provides a way for the author to automatically set the alpha property of all line atoms based on the element format to the specified Number.
		public var alpha:Number;

		/// Indicates the baseline shift for the element in pixels.
		public var baselineShift:Number;

		/// The line break opportunity applied to this text.
		public var breakOpportunity:String;

		/// Indicates the color of the text.
		public var color:uint;

		/// Specifies which of the baselines of the element snaps to the alignmentBaseline to determine the vertical position of the element on the line.
		public var dominantBaseline:String;

		/// An object which encapsulates properties necessary to describe a font.
		public var fontDescription:flash.text.engine.FontDescription;

		/// The digit case used for this text.
		public var digitCase:String;

		/// The digit width used for this text.
		public var digitWidth:String;

		/// The ligature level used for this text.
		public var ligatureLevel:String;

		/// The point size of text.
		public var fontSize:Number;

		/// The kerning used for this text.
		public var kerning:String;

		/// The locale of the text.
		public var locale:String;

		/// Sets the rotation applied to individual glyphs.
		public var textRotation:String;

		/// The tracking or manual kerning applied to the right of each glyph in pixels.
		public var trackingRight:Number;

		/// The tracking or manual kerning applied to the left of each glyph in pixels.
		public var trackingLeft:Number;

		/// The typographic case used for this text.
		public var typographicCase:String;

		/// Indicates whether or not the ElementFormat is locked.
		public var locked:Boolean;

		/// [FP10] Creates an ElementFormat object.
		public function ElementFormat(fontDescription:flash.text.engine.FontDescription=null, fontSize:Number=12.0, color:uint=0x000000, alpha:Number=1.0, textRotation:String=auto, dominantBaseline:String=roman, alignmentBaseline:String=useDominantBaseline, baselineShift:Number=0.0, kerning:String=on, trackingRight:Number=0.0, trackingLeft:Number=0.0, locale:String=en, breakOpportunity:String=auto, digitCase:String=default, digitWidth:String=default, ligatureLevel:String=common, typographicCase:String=default);

		/// [FP10] Returns a FontMetrics object with properties which describe the emBox, strikethrough position, strikethrough thickness, underline position, and underline thickness for the font specified by fontDescription and fontSize.
		public function getFontMetrics():flash.text.engine.FontMetrics;

		/// [FP10] Constructs an unlocked, cloned copy of the ElementFormat.
		public function clone():flash.text.engine.ElementFormat;

	}

}

