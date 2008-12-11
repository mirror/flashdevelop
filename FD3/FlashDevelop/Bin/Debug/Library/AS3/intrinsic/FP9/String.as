package 
{
	/// The String class is a data type that represents a string of characters.
	public class String
	{
		/// An integer specifying the number of characters in the specified String object.
		public var length:int;

		/// Creates a new String object initialized to the specified string.
		public function String(val:String);

		/// Returns a string comprising the characters represented by the Unicode character codes in the parameters.
		public static function fromCharCode(...charCodes):String;

		/// Returns the character in the position specified by the index parameter.
		public function charAt(index:Number=0):String;

		/// Returns the numeric Unicode character code of the character at the specified index.
		public function charCodeAt(index:Number=0):Number;

		/// Appends the supplied arguments to the end of the String object, converting them to strings if necessary, and returns the resulting string.
		public function concat(...args):String;

		/// Searches the string and returns the position of the first occurrence of val found at or after startIndex within the calling string.
		public function indexOf(val:String, startIndex:Number=0):int;

		/// Searches the string from right to left and returns the index of the last occurrence of val found before startIndex.
		public function lastIndexOf(val:String, startIndex:Number=0x7FFFFFFF):int;

		/// Compares the sort order of two or more strings and returns the result of the comparison as an integer.
		public function localeCompare(other:String, ...values):int;

		/// Matches the specifed pattern against the string and returns a new string in which the first match of pattern is replaced with the content specified by repl.
		public function replace(pattern:*, repl:Object):String;

		/// Matches the specifed pattern against the string.
		public function match(pattern:*):Array;

		/// Searches for the specifed pattern and returns the index of the first matching substring.
		public function search(pattern:*):int;

		/// Returns a string that includes the startIndex character and all characters up to, but not including, the endIndex character.
		public function slice(startIndex:Number=0, endIndex:Number=0x7fffffff):String;

		/// Splits a String object into an array of substrings by dividing it wherever the specified delimiter parameter occurs.
		public function split(delimiter:*, limit:Number=0x7fffffff):Array;

		/// Returns a substring consisting of the characters that start at the specified  startIndex and with a length specified by len.
		public function substr(startIndex:Number=0, len:Number=0x7fffffff):String;

		/// Returns a string consisting of the character specified by startIndex and all characters up to endIndex - 1.
		public function substring(startIndex:Number=0, endIndex:Number=0x7fffffff):String;

		/// Returns a copy of this string, with all uppercase characters converted to lowercase.
		public function toLowerCase():String;

		/// Returns a copy of this string, with all uppercase characters converted to lowercase.
		public function toLocaleLowerCase():String;

		/// Returns a copy of this string, with all lowercase characters converted to uppercase.
		public function toUpperCase():String;

		/// Returns a copy of this string, with all lowercase characters converted to uppercase.
		public function toLocaleUpperCase():String;

		/// Returns the primitive value of a String instance.
		public function valueOf():String;

	}

}

