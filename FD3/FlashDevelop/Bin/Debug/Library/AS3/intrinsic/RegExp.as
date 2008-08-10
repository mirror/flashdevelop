/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public dynamic  class RegExp {
		/**
		 * Specifies whether the dot character (.) in a regular expression pattern matches
		 *  new-line characters. Use the s flag when constructing
		 *  a regular expression to set dotall = true.
		 */
		public function get dotall():Boolean;
		/**
		 * Specifies whether to use extended mode for the regular expression.
		 *  When a RegExp object is in extended mode, white space characters in the constructor
		 *  string are ignored. This is done to allow more readable constructors.
		 */
		public function get extended():Boolean;
		/**
		 * Specifies whether to use global matching for the regular expression. When
		 *  global == true, the lastIndex property is set after a match is
		 *  found. The next time a match is requested, the regular expression engine starts from
		 *  the lastIndex position in the string. Use the g flag when
		 *  constructing a regular expression  to set global to true.
		 */
		public function get global():Boolean;
		/**
		 * Specifies whether the regular expression ignores case sensitivity. Use the
		 *  i flag when constructing a regular expression to set
		 *  ignoreCase = true.
		 */
		public function get ignoreCase():Boolean;
		/**
		 * Specifies the index position in the string at which to start the next search. This property
		 *  affects the exec() and test() methods of the RegExp class.
		 *  However, the match(), replace(), and search() methods
		 *  of the String class ignore the lastIndex property and start all searches from
		 *  the beginning of the string.
		 */
		public function get lastIndex():Number;
		public function set lastIndex(value:Number):void;
		/**
		 * Specifies whether the m (multiline) flag is set. If it is set,
		 *  the caret (^) and dollar sign ($) in a regular expression
		 *  match before and after new lines.
		 *  Use the m flag when constructing a regular expression to set
		 *  multiline = true.
		 */
		public function get multiline():Boolean;
		/**
		 * Specifies the pattern portion of the regular expression.
		 */
		public function get source():String;
		/**
		 * Lets you construct a regular expression from two strings. One string defines the pattern of the
		 *  regular expression, and the other defines the flags used in the regular expression.
		 *
		 * @param re                <String> The pattern of the regular expression (also known as the constructor string). This is the
		 *                            main part  of the regular expression (the part that goes within the "/" characters).
		 *                            Notes:
		 *                            Do not include the starting and trailing "/" characters; use these only when defining a regular expression
		 *                            literal without using the constructor. For example, the following two regular expressions are equivalent:
		 *                            var re1:RegExp = new RegExp("bob", "i");
		 *                            var re2:RegExp = /bob/i;
		 *                            In a regular expression that is defined with the RegExp() constructor method, to use a
		 *                            metasequence that begins with the backslash (\) character, such as \d (which matches any digit),
		 *                            type the backslash character twice. For example, the following two regular expressions are equivalent:
		 *                            var re1:RegExp = new RegExp("\\d+", "");
		 *                            var re2:RegExp = /\d/;
		 *                            In the first expression, you must type the backlash character twice in this case, because the first parameter of the RegExp()
		 *                            constructor method is a string, and in a string literal you must type a backslash character twice to have it
		 *                            recognized as a single  backslash character.
		 * @param flags             <String> The modifiers of the regular expression. These can include the following:
		 *                            g - When using the replace() method of the String class,
		 *                            specify this modifier to replace all matches, rather than only the first one.
		 *                            This modifier corresponds to the global property of the RegExp instance.
		 *                            i - The regular expression is evaluated without case
		 *                            sensitivity. This modifier corresponds to the ignoreCase property of the RegExp instance.
		 *                            s - The dot (.) character matches new-line characters. Note
		 *                            This modifier corresponds to the dotall property of the RegExp instance.
		 *                            m - The caret (^) character and dollar sign ($) match
		 *                            before and after new-line characters. This modifier corresponds to the
		 *                            multiline property of the RegExp instance.
		 *                            x - White space characters in the re string are ignored,
		 *                            so that you can write more readable constructors. This modifier corresponds to the
		 *                            extended property of the RegExp instance.
		 *                            All other characters in the flags string are ignored.
		 */
		public function RegExp(re:String, flags:String);
		/**
		 * Performs a search for the regular expression on the given string str.
		 *
		 * @param str               <String> The string to search.
		 * @return                  <Object> If there is no match, null; otherwise, an object with the following properties:
		 *                            An array, in which element 0 contains the complete matching substring, and
		 *                            other elements of the array (1 through n) contain substrings that match parenthetical groups
		 *                            in the regular expression
		 *                            index - The character position of the matched substring within
		 *                            the string
		 *                            input - The string (str)
		 */
		AS3 function exec(str:String):Object;
		/**
		 * Tests for the match of the regular expression in the given string str.
		 *
		 * @param str               <String> The string to test.
		 * @return                  <Boolean> If there is a match, true; otherwise, false.
		 */
		AS3 function test(str:String):Boolean;
	}
}
