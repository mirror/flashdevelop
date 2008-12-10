	/**
	 *  @copy flash.text.TextField#appendText()
	 */
	function appendText (newText:String) : void;
	/**
	 *  @copy flash.text.TextField#getCharBoundaries()
	 */
	function getCharBoundaries (charIndex:int) : Rectangle;
	/**
	 *  @copy flash.text.TextField#getCharIndexAtPoint()
	 */
	function getCharIndexAtPoint (x:Number, y:Number) : int;
	/**
	 *  @copy flash.text.TextField#getFirstCharInParagraph()
	 */
	function getFirstCharInParagraph (charIndex:int) : int;
	/**
	 *  @copy flash.text.TextField#getLineIndexAtPoint()
	 */
	function getLineIndexAtPoint (x:Number, y:Number) : int;
	/**
	 *  @copy flash.text.TextField#getLineIndexOfChar()
	 */
	function getLineIndexOfChar (charIndex:int) : int;
	/**
	 *  @copy flash.text.TextField#getLineLength()
	 */
	function getLineLength (lineIndex:int) : int;
	/**
	 *  @copy flash.text.TextField#getLineMetrics()
	 */
	function getLineMetrics (lineIndex:int) : TextLineMetrics;
	/**
	 *  @copy flash.text.TextField#getLineOffset()
	 */
	function getLineOffset (lineIndex:int) : int;
	/**
	 *  @copy flash.text.TextField#getLineText()
	 */
	function getLineText (lineIndex:int) : String;
	/**
	 *  @copy flash.text.TextField#getParagraphLength()
	 */
	function getParagraphLength (charIndex:int) : int;
	/**
	 *  @copy flash.text.TextField#getTextFormat()
	 */
	function getTextFormat (beginIndex:int, endIndex:int) : TextFormat;
	/**
	 *  @copy flash.text.TextField#replaceSelectedText()
	 */
	function replaceSelectedText (value:String) : void;
	/**
	 *  @copy flash.text.TextField#replaceText()
	 */
	function replaceText (beginIndex:int, endIndex:int, newText:String) : void;
	/**
	 *  @copy flash.text.TextField#setSelection()
	 */
	function setSelection (beginIndex:int, endIndex:int) : void;
	/**
	 *  @copy flash.text.TextField#setTextFormat()
	 */
	function setTextFormat (format:TextFormat, beginIndex:int, endIndex:int) : void;
	/**
	 *  @copy flash.text.TextField#getImageReference()
	 */
	function getImageReference (id:String) : DisplayObject;
