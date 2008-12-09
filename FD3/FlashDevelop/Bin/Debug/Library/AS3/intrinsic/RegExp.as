package 
{
	/// The RegExp class lets you work with regular expressions, which are patterns that you can use to perform searches in strings and to replace text in strings.
	public class RegExp
	{
		/// Specifies whether the dot character (.) in a regular expression pattern matches new-line characters.
		public var dotall:Boolean;

		/// Specifies whether to use extended mode for the regular expression.
		public var extended:Boolean;

		/// Specifies whether to use global matching for the regular expression.
		public var global:Boolean;

		/// Specifies whether the regular expression ignores case sensitivity.
		public var ignoreCase:Boolean;

		/// Specifies the index position in the string at which to start the next search.
		public var lastIndex:int;

		/// Specifies whether the m (multiline) flag is set.
		public var multiline:Boolean;

		/// Specifies the pattern portion of the regular expression.
		public var source:String;

		/// Lets you construct a regular expression from two strings.
		public function RegExp(re:String, flags:String);

		/// Performs a search for the regular expression on the given string str.
		public function exec(str:String):Object;

		/// Tests for the match of the regular expression in the given string str.
		public function test(str:String):Boolean;

	}

}

