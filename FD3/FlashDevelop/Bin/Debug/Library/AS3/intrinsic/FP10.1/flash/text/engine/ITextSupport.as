package flash.text.engine
{
	public interface ITextSupport
	{
		public function get canReconvert () : Boolean;

		public function get selectionActiveIndex () : int;

		public function get selectionAnchorIndex () : int;

		public function getTextInRange (startIndex:int = -1, endIndex:int = -1) : String;

		public function selectRange (anchorIndex:int, activeIndex:int) : void;
	}
}
