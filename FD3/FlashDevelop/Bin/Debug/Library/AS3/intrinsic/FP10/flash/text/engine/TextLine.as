package flash.text.engine
{
	/// The TextLine class is used to display text on the display list.
	public class TextLine extends flash.display.DisplayObjectContainer
	{
		/// The maximum requested width of a text line, in pixels.
		public static const MAX_LINE_WIDTH:int;

		/// Provides a way for the author to associate arbitrary data with the text line.
		public var userData:*;

		/// The TextBlock containing this text line, or null if the validity of the line is TextLineValidity.STATIC.
		public var textBlock:flash.text.engine.TextBlock;

		/// Indicates whether the text line contains any graphic elements.
		public var hasGraphicElement:Boolean;

		/// The next TextLine in the TextBlock, or null if the current line is the last line in the block or the validity of the line is TextLineValidity.STATIC.
		public var nextLine:flash.text.engine.TextLine;

		/// The previous TextLine in the TextBlock, or null if the line is the first line in the block or the validity of the line is TextLineValidity.STATIC.
		public var previousLine:flash.text.engine.TextLine;

		/// Specifies the number of pixels from the baseline to the top of the tallest characters in the line.
		public var ascent:Number;

		/// Specifies the number of pixels from the baseline to the bottom of the lowest-descending characters in the line.
		public var descent:Number;

		/// The logical height of the text line, which is equal to ascent + descent.
		public var textHeight:Number;

		/// The logical width of the text line, which is the width that the text engine uses to lay out the line.
		public var textWidth:Number;

		/// The index of the first character of the line in the raw text of the text block.
		public var textBlockBeginIndex:int;

		/// The length of the raw text in the text block that became the line, including the U+FDEF characters representing graphic elements and any trailing spaces, which are part of the line but not are displayed.
		public var rawTextLength:int;

		/// The width that was specified to the TextBlock.createTextLine() method when it created the line.
		public var specifiedWidth:Number;

		/// The width of the line if it was not justified.
		public var unjustifiedTextWidth:Number;

		/// Specifies the current validity of the text line.
		public var validity:String;

		/// The number of atoms in the line, which is the number of indivisible elements, including spaces and graphic elements.
		public var atomCount:int;

		/// A Vector containing the TextLineMirrorRegion objects associated with the line, or null if none exist.
		public var mirrorRegions:Vector.<flash.text.engine.TextLineMirrorRegion>;

		/// [FP10] Returns the first TextLineMirrorRegion on the line whose mirror property matches that specified by the mirror parameter, or null if no match exists.
		public function getMirrorRegion(mirror:flash.events.EventDispatcher):flash.text.engine.TextLineMirrorRegion;

		/// [FP10] Releases the atom data of the line for garbage collection.
		public function flushAtomData():void;

		/// [FP10] Returns the index of the atom at the point specified by the x and y parameters, or -1 if no atom exists at that point.
		public function getAtomIndexAtPoint(stageX:Number, stageY:Number):int;

		/// [FP10] Returns the index of the atom containing the character specified by the charIndex parameter, or -1 if the character does not contribute to any atom in the line.
		public function getAtomIndexAtCharIndex(charIndex:int):int;

		/// Gets the bounds of the atom at the specified index relative to the text line.
		public function getAtomBounds(atomIndex:int):flash.geom.Rectangle;

		/// Gets the bidirectional level of the atom at the specified index.
		public function getAtomBidiLevel(atomIndex:int):int;

		/// Gets the rotation of the atom at the specified index.
		public function getAtomTextRotation(atomIndex:int):String;

		/// Gets the text block begin index of the atom at the specified index.
		public function getAtomTextBlockBeginIndex(atomIndex:int):int;

		/// Gets the text block end index of the atom at the specified index.
		public function getAtomTextBlockEndIndex(atomIndex:int):int;

		/// Gets the center of the atom as measured along the baseline at the specified index.
		public function getAtomCenter(atomIndex:int):Number;

		/// Indicates whether a word boundary occurs to the left of the atom at the specified index.
		public function getAtomWordBoundaryOnLeft(atomIndex:int):Boolean;

		/// Gets the graphic of the atom at the specified index, or null if the atom is a character.
		public function getAtomGraphic(atomIndex:int):flash.display.DisplayObject;

		/// Gets the position of the specified baseline, relative to TextBlock.baselineZero.
		public function getBaselinePosition(baseline:String):Number;

		/// [FP10] Dumps the underlying contents of the TextLine as an XML string.
		public function dump():String;

	}

}

