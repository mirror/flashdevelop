package flash.text
{
	/// The TextField class is used to create display objects for text display and input.
	public class TextField extends flash.display.InteractiveObject
	{
		/** 
		 * Flash Player dispatches the textInput event when a user enters one or more characters of text.
		 * @eventType flash.events.TextEvent.TEXT_INPUT
		 */
		[Event(name="textInput", type="flash.events.TextEvent")]

		/** 
		 * Dispatched by a TextField object after the user scrolls.
		 * @eventType flash.events.Event.SCROLL
		 */
		[Event(name="scroll", type="flash.events.Event")]

		/** 
		 * Dispatched when a user clicks a hyperlink in an HTML-enabled text field, where the URL begins with "event:".
		 * @eventType flash.events.TextEvent.LINK
		 */
		[Event(name="link", type="flash.events.TextEvent")]

		/** 
		 * Dispatched after a control value is modified, unlike the textInput event, which is dispatched before the value is modified.
		 * @eventType flash.events.Event.CHANGE
		 */
		[Event(name="change", type="flash.events.Event")]

		/// When set to true and the text field is not in focus, Flash Player highlights the selection in the text field in gray.
		public var alwaysShowSelection:Boolean;

		/// The type of anti-aliasing used for this text field.
		public var antiAliasType:String;

		/// Controls automatic sizing and alignment of text fields.
		public var autoSize:String;

		/// Specifies whether the text field has a background fill.
		public var background:Boolean;

		/// The color of the text field background.
		public var backgroundColor:uint;

		/// Specifies whether the text field has a border.
		public var border:Boolean;

		/// The color of the text field border.
		public var borderColor:uint;

		/// An integer (1-based index) that indicates the bottommost line that is currently visible in the specified text field.
		public var bottomScrollV:int;

		/// The index of the insertion point (caret) position.
		public var caretIndex:int;

		/// A Boolean value that specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text is removed.
		public var condenseWhite:Boolean;

		/// Specifies the format applied to newly inserted text, such as text inserted with the replaceSelectedText() method or text entered by a user.
		public var defaultTextFormat:flash.text.TextFormat;

		/// Specifies whether to render by using embedded font outlines.
		public var embedFonts:Boolean;

		/// The type of grid fitting used for this text field.
		public var gridFitType:String;

		/// Contains the HTML representation of the text field contents.
		public var htmlText:String;

		/// The number of characters in a text field.
		public var length:int;

		/// The maximum number of characters that the text field can contain, as entered by a user.
		public var maxChars:int;

		/// The maximum value of scrollH.
		public var maxScrollH:int;

		/// The maximum value of scrollV.
		public var maxScrollV:int;

		/// A Boolean value that indicates whether Flash Player automatically scrolls multiline text fields when the user clicks a text field and rolls the mouse wheel.
		public var mouseWheelEnabled:Boolean;

		/// Indicates whether field is a multiline text field.
		public var multiline:Boolean;

		/// Defines the number of text lines in a multiline text field.
		public var numLines:int;

		/// Specifies whether the text field is a password text field.
		public var displayAsPassword:Boolean;

		/// Indicates the set of characters that a user can enter into the text field.
		public var restrict:String;

		/// The current horizontal scrolling position.
		public var scrollH:int;

		/// The vertical position of text in a text field.
		public var scrollV:int;

		/// A Boolean value that indicates whether the text field is selectable.
		public var selectable:Boolean;

		/// The zero-based character index value of the first character in the current selection.
		public var selectionBeginIndex:int;

		/// The zero-based character index value of the last character in the current selection.
		public var selectionEndIndex:int;

		/// The sharpness of the glyph edges in this text field.
		public var sharpness:Number;

		/// Attaches a style sheet to the text field.
		public var styleSheet:flash.text.StyleSheet;

		/// A string that is the current text in the text field.
		public var text:String;

		/// The color of the text in a text field, in hexadecimal format.
		public var textColor:uint;

		/// The height of the text in pixels.
		public var textHeight:Number;

		/// The width of the text in pixels.
		public var textWidth:Number;

		/// The thickness of the glyph edges in this text field.
		public var thickness:Number;

		/// The type of the text field.
		public var type:String;

		/// A Boolean value that indicates whether the text field has word wrap.
		public var wordWrap:Boolean;

		/// Specifies whether to copy and paste the text formatting along with the text.
		public var useRichTextClipboard:Boolean;

		/// Creates a new TextField instance.
		public function TextField();

		/// Appends text to the end of the existing text of the TextField.
		public function appendText(newText:String):void;

		/// Returns a rectangle that is the bounding box of the character.
		public function getCharBoundaries(charIndex:int):flash.geom.Rectangle;

		/// Returns the zero-based index value of the character.
		public function getCharIndexAtPoint(x:Number, y:Number):int;

		/// The zero-based index value of the character.
		public function getFirstCharInParagraph(charIndex:int):int;

		/// The zero-based index value of the line at a specified point.
		public function getLineIndexAtPoint(x:Number, y:Number):int;

		/// The zero-based index value of the line containing the character that the the charIndex parameter specifies.
		public function getLineIndexOfChar(charIndex:int):int;

		/// Returns the number of characters in a specific text line.
		public function getLineLength(lineIndex:int):int;

		/// Returns metrics information about a given text line.
		public function getLineMetrics(lineIndex:int):flash.text.TextLineMetrics;

		/// The zero-based index value of the first character in the line.
		public function getLineOffset(lineIndex:int):int;

		/// The text string contained in the specified line.
		public function getLineText(lineIndex:int):String;

		/// The zero-based index value of the character.
		public function getParagraphLength(charIndex:int):int;

		/// Returns a TextFormat object.
		public function getTextFormat(beginIndex:int=-1, endIndex:int=-1):flash.text.TextFormat;

		/// Replaces the current selection with the contents of the value parameter.
		public function replaceSelectedText(value:String):void;

		/// Replaces a range of characters.
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void;

		/// Sets a new text selection.
		public function setSelection(beginIndex:int, endIndex:int):void;

		/// Applies text formatting.
		public function setTextFormat(format:flash.text.TextFormat, beginIndex:int=-1, endIndex:int=-1):void;

		/// Returns a DisplayObject reference for the given id, for an image or SWF file that has been added to an HTML-formatted text field by using an &lt;img&gt; tag.
		public function getImageReference(id:String):flash.display.DisplayObject;

		/// [FP10] Returns true if an embedded font is available with the specified fontName and fontStyle where Font.fontType is flash.text.FontType.EMBEDDED.
		public static function isFontCompatible(fontName:String, fontStyle:String):Boolean;

	}

}

