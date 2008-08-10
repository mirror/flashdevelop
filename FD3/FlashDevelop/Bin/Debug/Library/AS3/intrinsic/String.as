/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class String {
		/**
		 * An integer specifying the number of characters in the specified String object.
		 */
		public function get length():int;
		/**
		 * Creates a new String object initialized to the specified string.
		 *
		 * @param val               <String> The initial value of the new String object.
		 */
		public function String(val:String);
		/**
		 * Returns the character in the position specified by the index parameter.
		 *  If index is not a number from 0 to string.length - 1, an
		 *  empty string is returned.
		 *
		 * @param index             <Number (default = 0)> An integer specifying the position of a character in the string. The first
		 *                            character is indicated by 0, and the last character is indicated by
		 *                            my_str.length - 1.
		 * @return                  <String> The character at the specified index. Or an empty string if the
		 *                            specified index is outside the range of this string's indices.
		 */
		AS3 function charAt(index:Number = 0):String;
		/**
		 * Returns the numeric Unicode character code of the character at the specified
		 *  index. If index is not a number from 0 to
		 *  string.length - 1, NaN is returned.
		 *
		 * @param index             <Number (default = 0)> An integer that specifies the position of a character in the string. The
		 *                            first character is indicated by 0, and the last character is indicated by
		 *                            my_str.length - 1.
		 * @return                  <Number> The Unicode character code of the character at the specified index. Or
		 *                            NaN if the index is outside the range of this string's indices.
		 */
		AS3 function charCodeAt(index:Number = 0):Number;
		/**
		 * Appends the supplied arguments to the end of the String object, converting them to strings if
		 *  necessary, and returns the resulting string. The original value of the source String object
		 *  remains unchanged.
		 *
		 * @return                  <String> A new string consisting of this string concatenated
		 *                            with the specified parameters.
		 */
		AS3 function concat(... args):String;
		/**
		 * Returns a string comprising the characters represented by the Unicode character codes
		 *  in the parameters.
		 *
		 * @return                  <String> The string value of the specified Unicode character codes.
		 */
		AS3 static function fromCharCode(... charCodes):String;
		/**
		 * Searches the string and returns the position of the first occurrence of val
		 *  found at or after startIndex within the calling string. This index is zero-based,
		 *  meaning that the first character in a string is considered to be at index 0--not index 1. If
		 *  val is not found, the method returns -1.
		 *
		 * @param val               <String> The substring for which to search.
		 * @param startIndex        <Number (default = 0)> An optional integer specifying the starting index of the search.
		 * @return                  <int> The index of the first occurrence of the specified substring or -1.
		 */
		AS3 function indexOf(val:String, startIndex:Number = 0):int;
		/**
		 * Searches the string from right to left and returns the index of the last occurrence
		 *  of val found before startIndex. The index is zero-based,
		 *  meaning that the first character is at index 0, and the last is at string.length
		 *  - 1. If val is not found, the method returns -1.
		 *
		 * @param val               <String> The string for which to search.
		 * @param startIndex        <Number (default = 0x7FFFFFFF)> An optional integer specifying the starting index from which to
		 *                            search for val. The default is the maximum value allowed for an index.
		 *                            If startIndex is not specified, the search starts at the last item in the string.
		 * @return                  <int> The position of the last occurrence of the specified substring or -1 if not found.
		 */
		AS3 function lastIndexOf(val:String, startIndex:Number = 0x7FFFFFFF):int;
		/**
		 * Compares the sort order of two or more strings and returns the result of the comparison as an integer. While this
		 *  method is intended to handle the comparison in a locale-specific way, the ActionScript 3.0 implementation
		 *  does not produce a different result from other string comparisons such as the equality (==) or
		 *  inequality (!=) operators.
		 *  If the strings are equivalent, the return value is 0.
		 *  If the original string value precedes the string value specified by other,
		 *  the return value is a negative integer, the absolute value of which represents
		 *  the number of characters that separates the two string values.
		 *  If the original string value comes after other,
		 *  the return value is a positive integer, the absolute value of which represents
		 *  the number of characters that separates the two string values.
		 *
		 * @param other             <String> A string value to compare.
		 * @return                  <int> The value 0 if the strings are equal. Otherwise, a negative integer if the original
		 *                            string precedes the string argument and a positive integer if the string argument precedes
		 *                            the original string. In both cases the absolute value of the number represents the difference
		 *                            between the two strings.
		 */
		AS3 function localeCompare(other:String, ... values):int;
		/**
		 * Matches the specifed pattern against the
		 *  string.
		 *
		 * @param pattern           <*> The pattern to match, which can be any type of object, but it is typically
		 *                            either a string or a regular expression. If the pattern is not a regular expression
		 *                            or a string, then the method converts it to a string before executing.
		 * @return                  <Array> An array of strings consisting of all substrings in
		 *                            the string that match the specified pattern.
		 *                            If pattern is a regular expression, in order to return an array with
		 *                            more than one matching substring, the g (global) flag must be set
		 *                            in the regular expression:
		 *                            If the g (global) flag is not set,
		 *                            the return array will contain no more than one match, and the lastIndex
		 *                            property of the regular expression remains unchanged.
		 *                            If the g (global) flag is set, the method starts the search at
		 *                            the beginning of the string (index position 0). If a matching substring is an empty string (which
		 *                            can occur with a regular expression such as /x*/), the method adds that
		 *                            empty string to the array of matches, and then continues searching at the next index position.
		 *                            The lastIndex property of the regular expression is set to 0 after the
		 *                            method completes.
		 *                            If no match is found, the method returns null. If you pass
		 *                            no value (or an undefined value) as the pattern parameter,
		 *                            the method returns null.
		 */
		AS3 function match(pattern:*):Array;
		/**
		 * Matches the specifed pattern against the string and returns a new string
		 *  in which the first match of pattern is replaced with the content specified by repl.
		 *  The pattern parameter can be a string or a regular expression. The repl parameter
		 *  can be a string or a function; if it is a function, the string returned
		 *  by the function is inserted in place of the match. The original string is not modified.
		 *
		 * @param pattern           <*> The pattern to match, which can be any type of object, but it is typically
		 *                            either a string or a regular expression. If you specify a pattern parameter
		 *                            that is any object other than a string or a regular expression, the toString() method is
		 *                            applied to the parameter and the replace() method executes using the resulting string
		 *                            as the pattern.
		 * @param repl              <Object> Typically, the string that is inserted in place of the matching content. However, you can
		 *                            also specify a function as this parameter. If you specify a function, the string returned
		 *                            by the function is inserted in place of the matching content.
		 *                            When you specify a string as the repl parameter and specify a regular expression
		 *                            as the pattern parameter, you can use the following special $ replacement codes
		 *                            in the repl string:
		 *                            $ Code
		 *                            Replacement Text
		 *                            $$
		 *                            $
		 * @return                  <String> The resulting string. Note that the source string remains unchanged.
		 */
		AS3 function replace(pattern:*, repl:Object):String;
		/**
		 * Searches for the specifed pattern and returns the index of
		 *  the first matching substring. If there is no matching substring, the method returns
		 *  -1.
		 *
		 * @param pattern           <*> The pattern to match, which can be any type of object but is typically
		 *                            either a string or a regular expression.. If the pattern is not a regular expression
		 *                            or a string, then the method converts it to a string before executing.
		 *                            Note that if you specify a regular expression, the method ignores the global flag ("g") of the
		 *                            regular expression, and it ignores the lastIndex property of the regular
		 *                            expression (and leaves it unmodified). If you pass an undefined value (or no value),
		 *                            the method returns -1.
		 * @return                  <int> The index of the first matching substring, or -1 if
		 *                            there is no match. Note that the string is zero-indexed; the first character of
		 *                            the string is at index 0, the last is at string.length - 1.
		 */
		AS3 function search(pattern:*):int;
		/**
		 * Returns a string that includes the startIndex character
		 *  and all characters up to, but not including, the endIndex character. The original String object is not modified.
		 *  If the endIndex parameter is not specified, then the end of the
		 *  substring is the end of the string. If the character indexed by startIndex is the same as or to the right of the
		 *  character indexed by endIndex, the method returns an empty string.
		 *
		 * @param startIndex        <Number (default = 0)> The zero-based index of the starting point for the slice. If
		 *                            startIndex is a negative number, the slice is created from right-to-left, where
		 *                            -1 is the last character.
		 * @param endIndex          <Number (default = 0x7fffffff)> An integer that is one greater than the index of the ending point for
		 *                            the slice. The character indexed by the endIndex parameter is not included in the extracted
		 *                            string.
		 *                            If endIndex is a negative number, the ending point is determined by
		 *                            counting back from the end of the string, where -1 is the last character.
		 *                            The default is the maximum value allowed for an index. If this parameter is omitted, String.length is used.
		 * @return                  <String> A substring based on the specified indices.
		 */
		AS3 function slice(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String;
		/**
		 * Splits a String object into an array of substrings
		 *  by dividing it wherever the specified delimiter parameter
		 *  occurs.
		 *
		 * @param delimiter         <*> The pattern that specifies where to split this string. This can be any type of
		 *                            object but is typically either a string or a regular expression. If the delimiter
		 *                            is not a regular expression or string, then the method converts it to a string before executing.
		 * @param limit             <Number (default = 0x7fffffff)> The maximum number of items to place into the array.
		 *                            The default is the maximum value allowed.
		 * @return                  <Array> An array of substrings.
		 */
		AS3 function split(delimiter:*, limit:Number = 0x7fffffff):Array;
		/**
		 * Returns a substring consisting of the characters that start at the specified
		 *  startIndex and with a length specified by len. The original
		 *  string is unmodified.
		 *
		 * @param startIndex        <Number (default = 0)> An integer that specified the index of the first character to be
		 *                            used to create the substring. If startIndex is a negative number, the
		 *                            starting index is determined from the end of the string, where -1 is the
		 *                            last character.
		 * @param len               <Number (default = 0x7fffffff)> The number of characters in the substring being created.
		 *                            The default value is the maximum value allowed. If len
		 *                            is not specified, the substring includes all the characters from startIndex
		 *                            to the end of the string.
		 * @return                  <String> A substring based on the specified parameters.
		 */
		AS3 function substr(startIndex:Number = 0, len:Number = 0x7fffffff):String;
		/**
		 * Returns a string consisting of the character specified by startIndex
		 *  and all characters up to endIndex - 1. If endIndex is not
		 *  specified, String.length is used. If the value of startIndex
		 *  equals the value of endIndex, the method returns an empty string.
		 *  If the value of startIndex is greater than the value of
		 *  endIndex, the parameters are automatically swapped before the function
		 *  executes. The original string is unmodified.
		 *
		 * @param startIndex        <Number (default = 0)> An integer specifying the index of the first character used to create
		 *                            the substring. Valid values for startIndex are 0 through
		 *                            String.length. If startIndex is a negative value, 0
		 *                            is used.
		 * @param endIndex          <Number (default = 0x7fffffff)> An integer that is one greater than the index of the last character in the
		 *                            extracted substring. Valid values for endIndex are 0 through
		 *                            String.length. The character at endIndex is not included in
		 *                            the substring. The default is the maximum value allowed for an index.
		 *                            If this parameter is omitted, String.length is used. If
		 *                            this parameter is a negative value, 0 is used.
		 * @return                  <String> A substring based on the specified parameters.
		 */
		AS3 function substring(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String;
		/**
		 * Returns a copy of this string, with all uppercase characters converted
		 *  to lowercase. The original string is unmodified. While this
		 *  method is intended to handle the conversion in a locale-specific way, the ActionScript 3.0 implementation
		 *  does not produce a different result from the toLowerCase() method.
		 *
		 * @return                  <String> A copy of this string with all uppercase characters converted
		 *                            to lowercase.
		 */
		AS3 function toLocaleLowerCase():String;
		/**
		 * Returns a copy of this string, with all lowercase characters converted
		 *  to uppercase. The original string is unmodified. While this
		 *  method is intended to handle the conversion in a locale-specific way, the ActionScript 3.0 implementation
		 *  does not produce a different result from the toUpperCase() method.
		 *
		 * @return                  <String> A copy of this string with all lowercase characters converted
		 *                            to uppercase.
		 */
		AS3 function toLocaleUpperCase():String;
		/**
		 * Returns a copy of this string, with all uppercase characters converted
		 *  to lowercase. The original string is unmodified.
		 *
		 * @return                  <String> A copy of this string with all uppercase characters converted
		 *                            to lowercase.
		 */
		AS3 function toLowerCase():String;
		/**
		 * Returns a copy of this string, with all lowercase characters converted
		 *  to uppercase. The original string is unmodified.
		 *
		 * @return                  <String> A copy of this string with all lowercase characters converted
		 *                            to uppercase.
		 */
		AS3 function toUpperCase():String;
		/**
		 * Returns the primitive value of a String instance. This method is designed to
		 *  convert a String object into a primitive string value. Because Flash Player
		 *  automatically calls valueOf() when necessary,
		 *  you rarely need to explicitly call this method.
		 *
		 * @return                  <String> The value of the string.
		 */
		AS3 function valueOf():String;
	}
}
