package flash.globalization
{
	public class Collator extends Object
	{
		public function get actualLocaleIDName () : String;

		public function get ignoreCase () : Boolean;
		public function set ignoreCase (value:Boolean) : void;

		public function get ignoreCharacterWidth () : Boolean;
		public function set ignoreCharacterWidth (value:Boolean) : void;

		public function get ignoreDiacritics () : Boolean;
		public function set ignoreDiacritics (value:Boolean) : void;

		public function get ignoreKanaType () : Boolean;
		public function set ignoreKanaType (value:Boolean) : void;

		public function get ignoreSymbols () : Boolean;
		public function set ignoreSymbols (value:Boolean) : void;

		public function get lastOperationStatus () : String;

		public function get numericComparison () : Boolean;
		public function set numericComparison (value:Boolean) : void;

		public function get requestedLocaleIDName () : String;

		public function Collator (requestedLocaleIDName:String, initialMode:String = "sorting");

		public function compare (string1:String, string2:String) : int;

		public function equals (string1:String, string2:String) : Boolean;

		public static function getAvailableLocaleIDNames () : Vector.<String>;
	}
}
