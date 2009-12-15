package mx.utils
{
	public class StringUtil extends Object
	{
		public static const VERSION : String;

		public static function isWhitespace (character:String) : Boolean;

		public function StringUtil ();

		public static function substitute (str:String, ...rest) : String;

		public static function trim (str:String) : String;

		public static function trimArrayElements (value:String, delimiter:String) : String;
	}
}
