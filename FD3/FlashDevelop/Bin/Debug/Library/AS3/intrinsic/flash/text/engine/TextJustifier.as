package flash.text.engine
{
	/// The TextJustifier class is an abstract base class for the justifier types that you can apply to a TextBlock, specifically the EastAsianJustifier and SpaceJustifier classes.
	public class TextJustifier
	{
		/// Specifies the locale to determine the justification rules for the text in a text block.
		public var locale:String;

		/// Specifies the line justification for the text in a text block.
		public var lineJustification:String;

		/// [FP10] Calling the new TextJustifier() constructor throws an ArgumentError exception.
		public function TextJustifier(locale:String, lineJustification:String);

		/// [FP10] Constructs a cloned copy of the TextJustifier.
		public function clone():flash.text.engine.TextJustifier;

		/// [FP10] Constructs a default TextJustifier subclass appropriate to the specified locale.
		public static function getJustifierForLocale(locale:String):flash.text.engine.TextJustifier;

	}

}

