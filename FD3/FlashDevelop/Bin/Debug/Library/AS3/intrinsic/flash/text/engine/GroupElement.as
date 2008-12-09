package flash.text.engine
{
	/// A GroupElement object groups a collection of TextElement, GraphicElement, or other GroupElement objects that you can assign as a whole to the content property of a TextBlock object.
	public class GroupElement extends flash.text.engine.ContentElement
	{
		/// The number of elements in the group.
		public var elementCount:int;

		/// [FP10] Creates a new GroupElement instance.
		public function GroupElement(elements:Vector.<flash.text.engine.ContentElement>=null, elementFormat:flash.text.engine.ElementFormat=null, eventMirror:flash.events.EventDispatcher=null, textRotation:String=rotate0);

		/// Retrieves an element from within the group.
		public function getElementAt(index:int):flash.text.engine.ContentElement;

		/// Sets the elements in the group to the contents of the Vector.
		public function setElements(value:Vector.<flash.text.engine.ContentElement>):void;

		/// [FP10] Replaces the range of elements that the beginIndex and endIndex parameters specify with a new GroupElement containing those elements.
		public function groupElements(beginIndex:int, endIndex:int):flash.text.engine.GroupElement;

		/// [FP10] Ungroups the elements in a nested GroupElement that groupIndex specifies within an outer GroupElement object.
		public function ungroupElements(groupIndex:int):void;

		/// [FP10] Merges the text from the range of elements that the beginIndex and endIndex parameters specify into the element specified by beginIndex without affecting the format of that element.
		public function mergeTextElements(beginIndex:int, endIndex:int):flash.text.engine.TextElement;

		/// [FP10] Splits a portion of a TextElement in the group into a new TextElement which is inserted into the group following the specified TextElement.
		public function splitTextElement(elementIndex:int, splitIndex:int):flash.text.engine.TextElement;

		/// [FP10] Replaces the range of elements that the beginIndex and endIndex parameters specify with the contents of the newElements parameter.
		public function replaceElements(beginIndex:int, endIndex:int, newElements:Vector.<flash.text.engine.ContentElement>):Vector.<flash.text.engine.ContentElement>;

		/// [FP10] Returns the element containing the character specified by the charIndex parameter.
		public function getElementAtCharIndex(charIndex:int):flash.text.engine.ContentElement;

		/// [FP10] Returns the index of the element specified by the element parameter.
		public function getElementIndex(element:flash.text.engine.ContentElement):int;

	}

}

