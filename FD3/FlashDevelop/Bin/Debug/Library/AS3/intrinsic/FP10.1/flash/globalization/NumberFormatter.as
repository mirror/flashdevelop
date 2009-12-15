package flash.globalization
{
	import flash.globalization.NumberParseResult;

	public class NumberFormatter extends Object
	{
		public function get actualLocaleIDName () : String;

		public function get decimalSeparator () : String;
		public function set decimalSeparator (value:String) : void;

		public function get digitsType () : uint;
		public function set digitsType (value:uint) : void;

		public function get fractionalDigits () : int;
		public function set fractionalDigits (value:int) : void;

		public function get groupingPattern () : String;
		public function set groupingPattern (value:String) : void;

		public function get groupingSeparator () : String;
		public function set groupingSeparator (value:String) : void;

		public function get lastOperationStatus () : String;

		public function get leadingZero () : Boolean;
		public function set leadingZero (value:Boolean) : void;

		public function get negativeNumberFormat () : uint;
		public function set negativeNumberFormat (value:uint) : void;

		public function get negativeSymbol () : String;
		public function set negativeSymbol (value:String) : void;

		public function get requestedLocaleIDName () : String;

		public function get trailingZeros () : Boolean;
		public function set trailingZeros (value:Boolean) : void;

		public function get useGrouping () : Boolean;
		public function set useGrouping (value:Boolean) : void;

		public function formatInt (value:int) : String;

		public function formatNumber (value:Number) : String;

		public function formatUint (value:uint) : String;

		public static function getAvailableLocaleIDNames () : Vector.<String>;

		public function NumberFormatter (requestedLocaleIDName:String);

		public function parse (parseString:String) : NumberParseResult;

		public function parseNumber (parseString:String) : Number;
	}
}
