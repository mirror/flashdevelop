package flash.globalization
{
	public class NumberParseResult extends Object
	{
		public function get endIndex () : int;

		public function get startIndex () : int;

		public function get value () : Number;

		public function NumberParseResult (value:Number = Non Numérique, startIndex:int = 2147483647, endIndex:int = 2147483647);
	}
}
