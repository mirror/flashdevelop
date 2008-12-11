package flash.text.engine
{
	/// The ContentElement class serves as a base class for the element types that can appear in a GroupElement, namely a GraphicElement, another GroupElement, or a TextElement.
	public class ContentElement
	{
		/// Indicates the presence a graphic element in the text.
		public static const GRAPHIC_ELEMENT:uint;

		/// Provides a way for the author to associate arbitrary data with the element.
		public var userData:*;

		/// The TextBlock to which this element belongs.
		public var textBlock:flash.text.engine.TextBlock;

		/// The index in the text block of the first character of this element.
		public var textBlockBeginIndex:int;

		/// The ElementFormat object used for the element.
		public var elementFormat:flash.text.engine.ElementFormat;

		/// The EventDispatcher object that receives copies of every event dispatched to valid text lines based on this content element.
		public var eventMirror:flash.events.EventDispatcher;

		/// The GroupElement object that contains this element, or null if it is not in a group.
		public var groupElement:flash.text.engine.GroupElement;

		/// A copy of the text in the element, including the U+FDEF characters.
		public var rawText:String;

		/// A copy of the text in the element, not including the U+FDEF characters, which represent graphic elements in the String.
		public var text:String;

		/// The rotation to apply to the element as a unit.
		public var textRotation:String;

		/// [FP10] Calling the new ContentElement() constructor throws an ArgumentError exception.
		public function ContentElement(elementFormat:flash.text.engine.ElementFormat=null, eventMirror:flash.events.EventDispatcher=null, textRotation:String=rotate0);

	}

}

