package flash.text.engine
{
	/// The TextElement class represents a string of formatted text.
	public class TextElement extends flash.text.engine.ContentElement
	{
		/// Receives the text that is the content of the element.
		public var text:String;

		/// [FP10] Creates a new TextElement instance.
		public function TextElement(text:String=null, elementFormat:flash.text.engine.ElementFormat=null, eventMirror:flash.events.EventDispatcher=null, textRotation:String=rotate0);

		/// [FP10] Replaces the range of characters that the beginIndex and endIndex parameters specify with the contents of the newText parameter.
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void;

	}

}

