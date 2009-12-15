package flash.globalization
{
	public class DateTimeFormatter extends Object
	{
		public function get actualLocaleIDName () : String;

		public function get lastOperationStatus () : String;

		public function get requestedLocaleIDName () : String;

		public function DateTimeFormatter (requestedLocaleIDName:String, dateStyle:String = "long", timeStyle:String = "long");

		public function format (dateTime:Date) : String;

		public function formatUTC (dateTime:Date) : String;

		public static function getAvailableLocaleIDNames () : Vector.<String>;

		public function getDateStyle () : String;

		public function getDateTimePattern () : String;

		public function getFirstWeekday () : int;

		public function getMonthNames (nameStyle:String = "full", context:String = "standalone") : Vector.<String>;

		public function getTimeStyle () : String;

		public function getWeekdayNames (nameStyle:String = "full", context:String = "standalone") : Vector.<String>;

		public function setDateTimePattern (pattern:String) : void;

		public function setDateTimeStyles (dateStyle:String, timeStyle:String) : void;
	}
}
