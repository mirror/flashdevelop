package flash.globalization
{
	import flash.globalization.CurrencyParseResult;

	public class CurrencyFormatter extends Object
	{
		public function get actualLocaleIDName () : String;

		public function get currencyISOCode () : String;

		public function get currencySymbol () : String;

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

		public function get negativeCurrencyFormat () : uint;
		public function set negativeCurrencyFormat (value:uint) : void;

		public function get negativeSymbol () : String;
		public function set negativeSymbol (value:String) : void;

		public function get positiveCurrencyFormat () : uint;
		public function set positiveCurrencyFormat (value:uint) : void;

		public function get requestedLocaleIDName () : String;

		public function get trailingZeros () : Boolean;
		public function set trailingZeros (value:Boolean) : void;

		public function get useGrouping () : Boolean;
		public function set useGrouping (value:Boolean) : void;

		public function CurrencyFormatter (requestedLocaleIDName:String);

		public function format (value:Number, withCurrencySymbol:Boolean = false) : String;

		public function formattingWithCurrencySymbolIsSafe (requestedISOCode:String) : Boolean;

		public static function getAvailableLocaleIDNames () : Vector.<String>;

		public function parse (inputString:String) : CurrencyParseResult;

		public function setCurrency (currencyISOCode:String, currencySymbol:String) : void;
	}
}
