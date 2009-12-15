package flash.text.ime
{
	public class CompositionAttributeRange extends Object
	{
		public var converted : Boolean;
		public var relativeEnd : int;
		public var relativeStart : int;
		public var selected : Boolean;

		public function CompositionAttributeRange (relativeStart:int, relativeEnd:int, selected:Boolean, converted:Boolean);
	}
}
