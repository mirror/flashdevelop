package flash.text.ime
{
	import flash.text.ime.CompositionAttributeRange;
	import flash.geom.Rectangle;

	public interface IIMEClient
	{
		public function get compositionEndIndex () : int;

		public function get compositionStartIndex () : int;

		public function get verticalTextLayout () : Boolean;

		public function confirmComposition (text:String = null, preserveSelection:Boolean = false) : void;

		public function getTextBounds (startIndex:int, endIndex:int) : Rectangle;

		public function updateComposition (text:String, attributes:Vector.<CompositionAttributeRange>, compositionStartIndex:int, compositionEndIndex:int) : void;
	}
}
