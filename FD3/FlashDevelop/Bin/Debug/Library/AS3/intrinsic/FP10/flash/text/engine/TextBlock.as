package flash.text.engine
{
	/// The TextBlock class is a factory for the creation of TextLine objects, which you can render by placing them on the display list.
	public class TextBlock
	{
		/// Provides a way for the author to associate arbitrary data with the text block.
		public var userData:*;

		/// Specifies that you want to enhance screen appearance at the expense of what-you-see-is-what-you-get (WYSIWYG) print fidelity.
		public var applyNonLinearFontScaling:Boolean;

		/// The font used to determine the baselines for all the lines created from the block, independent of their content.
		public var baselineFontDescription:flash.text.engine.FontDescription;

		/// The font size used to calculate the baselines for the lines created from the block.
		public var baselineFontSize:Number;

		/// Specifies which baseline is at y=0 for lines created from this block.
		public var baselineZero:String;

		/// Holds the contents of the text block.
		public var content:flash.text.engine.ContentElement;

		/// Specifies the default bidirectional embedding level of the text in the text block.
		public var bidiLevel:int;

		/// Identifies the first line in the text block in which TextLine.validity is not equal to TextLineValidity.VALID.
		public var firstInvalidLine:flash.text.engine.TextLine;

		/// The first TextLine in the TextBlock, if any.
		public var firstLine:flash.text.engine.TextLine;

		/// The last TextLine in the TextBlock, if any.
		public var lastLine:flash.text.engine.TextLine;

		/// Specifies the TextJustifier to use during line creation.
		public var textJustifier:flash.text.engine.TextJustifier;

		/// Indicates the result of a createTextLine() operation.
		public var textLineCreationResult:String;

		/// Rotates the text lines in the text block as a unit.
		public var lineRotation:String;

		/// Specifies the tab stops for the text in the text block, in the form of a Vector of TabStop objects.
		public var tabStops:Vector.<flash.text.engine.TabStop>;

		/// [FP10] Creates a TextBlock object
		public function TextBlock(content:flash.text.engine.ContentElement=null, tabStops:Vector.<flash.text.engine.TabStop>=null, textJustifier:flash.text.engine.TextJustifier=null, lineRotation:String=rotate0, baselineZero:String=roman, bidiLevel:int=0, applyNonLinearFontScaling:Boolean=true, baselineFontDescription:flash.text.engine.FontDescription=null, baselineFontSize:Number=12.0);

		/// [FP10] Finds the index of the next Atom boundary from the specified character index, not including the character at the specified index.
		public function findNextAtomBoundary(afterCharIndex:int):int;

		/// [FP10] Finds the index of the previous atom boundary to the specified character index, not including the character at the specified index.
		public function findPreviousAtomBoundary(beforeCharIndex:int):int;

		/// [FP10] Finds the index of the next word boundary from the specified character index, not including the character at the specified index.
		public function findNextWordBoundary(afterCharIndex:int):int;

		/// [FP10] Finds the index of the previous word boundary to the specified character index, not including the character at the specified index.
		public function findPreviousWordBoundary(beforeCharIndex:int):int;

		/// [FP10] Returns the TextLine containing the character specified by the charIndex parameter.
		public function getTextLineAtCharIndex(charIndex:int):flash.text.engine.TextLine;

		/// [FP10] Instructs the text block to create a line of text from its content, beginning at the point specified by the previousLine parameter and breaking at the point specified by the width parameter.
		public function createTextLine(previousLine:flash.text.engine.TextLine=null, width:Number=1000000, lineOffset:Number=0.0, fitSomething:Boolean=false):flash.text.engine.TextLine;

		/// [FP10] Removes a range of text lines from the list of lines maintained by the TextBlock.
		public function releaseLines(firstLine:flash.text.engine.TextLine, lastLine:flash.text.engine.TextLine):void;

		/// [FP10] Dumps the underlying contents of the TextBlock as an XML string.
		public function dump():String;

	}

}

