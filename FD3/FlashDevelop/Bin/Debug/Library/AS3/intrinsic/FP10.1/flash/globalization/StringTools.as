package flash.globalization
{
	public class StringTools extends Object
	{
		public function get actualLocaleIDName () : String;

		public function get lastOperationStatus () : String;

		public function get requestedLocaleIDName () : String;

		public static function getAvailableLocaleIDNames () : Vector.<String>;

		public function StringTools (requestedLocaleIDName:String);

		public function toLowerCase (s:String) : String;

		public function toUpperCase (s:String) : String;
	}
}
