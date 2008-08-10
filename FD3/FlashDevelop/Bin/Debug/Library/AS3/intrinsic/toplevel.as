/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	/**
	 * A special value representing positive Infinity. The value of this constant is the same as Number.POSITIVE_INFINITY.
	 */
	public const Infinity:Number;
	/**
	 * A special member of the Number data type that represents a value that is "not a number" (NaN).
	 *  When a mathematical expression results in a value that cannot be expressed as a number, the result is NaN.
	 *  The following list describes common expressions that result in NaN.
	 *  Division by 0 results in NaN only if the divisor is also 0. If the divisor is greater than 0, division by 0 results in Infinity. If the divisor is less than 0,  division by 0 results in -Infinity;
	 *  Square root of a negative number;
	 *  The arcsine of a number outside the valid range of 0 to 1;
	 *  Infinity subtracted from Infinity;
	 *  Infinity or -Infinity divided by Infinity or -Infinity;
	 *  Infinity or -Infinity multiplied by 0;
	 */
	public const NaN:Number;
	/**
	 * A special value that applies to untyped variables that have not been initialized or dynamic object properties that are not initialized.
	 *  In ActionScript 3.0, only variables that are untyped can hold the value undefined,
	 *  which is not true in ActionScript 1.0 and ActionScript 2.0.
	 *  For example, both of the following variables are undefined because they are untyped and unitialized:
	 *  var foo;
	 *  var bar:*;
	 */
	public const undefined:*;
	/**
	 * Decodes an encoded URI into a string. Returns a string in which all characters previously encoded
	 *  by the encodeURI function are restored to their unencoded representation.
	 *
	 * @param uri               <String> A string encoded with the encodeURI function.
	 * @return                  <String> A string in which all characters previously escaped by the encodeURI function are
	 *                            restored to their unescaped representation.
	 */
	public function decodeURI(uri:String):String;
	/**
	 * Decodes an encoded URI component into a string. Returns a string in which
	 *  all characters previously escaped by the encodeURIComponent
	 *  function are restored to their uncoded representation.
	 *
	 * @param uri               <String> A string encoded with the encodeURIComponent function.
	 * @return                  <String> A string in which all characters previously escaped by the encodeURIComponent function are
	 *                            restored to their unescaped representation.
	 */
	public function decodeURIComponent(uri:String):String;
	/**
	 * Encodes a string into a valid URI (Uniform Resource Identifier).
	 *  Converts a complete URI into a string in which all characters are encoded
	 *  as UTF-8 escape sequences unless a character belongs to a small group of basic characters.
	 *
	 * @param uri               <String> A string representing a complete URI.
	 * @return                  <String> A string with certain characters encoded as UTF-8 escape sequences.
	 */
	public function encodeURI(uri:String):String;
	/**
	 * Encodes a string into a valid URI component. Converts a substring of a URI into a
	 *  string in which all characters are encoded as UTF-8 escape sequences unless a character
	 *  belongs to a very small group of basic characters.
	 *
	 * @param uri               <String> A string representing a complete URI.
	 * @return                  <String> A string with certain characters encoded as UTF-8 escape sequences.
	 */
	public function encodeURIComponent(uri:String):String;
	/**
	 * Converts the parameter to a string and encodes it in a URL-encoded format,
	 *  where most nonalphanumeric characters are replaced with % hexadecimal sequences.
	 *  When used in a URL-encoded string, the percentage symbol (%) is used to introduce
	 *  escape characters, and is not equivalent to the modulo operator (%).
	 *
	 * @param str               <String> The expression to convert into a string and encode in a URL-encoded format.
	 * @return                  <String> A URL-encoded string.
	 */
	public function escape(str:String):String;
	/**
	 * Returns true if the value is a finite number,
	 *  or false if the value is Infinity or -Infinity.
	 *  The presence of Infinity or -Infinity indicates a mathematical
	 *  error condition such as division by 0.
	 *
	 * @param num               <Number> A number to evaluate as finite or infinite.
	 * @return                  <Boolean> Returns true if it is a finite number
	 *                            or false if it is infinity or negative infinity.
	 */
	public function isFinite(num:Number):Boolean;
	/**
	 * Returns true if the value is NaN(not a number). The isNaN() function is useful for checking whether a mathematical expression evaluates successfully to a number. The NaN value is a special member of the Number data type that represents a value that is "not a number."
	 *
	 * @param num               <Number> A numeric value or mathematical expression to evaluate.
	 * @return                  <Boolean> Returns true if the value is NaN(not a number) and false otherwise.
	 */
	public function isNaN(num:Number):Boolean;
	/**
	 * Determines whether the specified string is a valid name for an XML element or attribute.
	 *
	 * @param str               <String> A string to evaluate.
	 * @return                  <Boolean> Returns true if the str argument is a valid XML name; false otherwise.
	 */
	public function isXMLName(str:String):Boolean;
	/**
	 * Converts a string to a floating-point number. The function reads, or parses, and returns the numbers in a string until it reaches a character that is not a part of the initial number. If the string does not begin with a number that can be parsed, parseFloat() returns NaN. White space preceding valid integers is ignored, as are trailing nonnumeric characters.
	 *
	 * @param str               <String> The string to read and convert to a floating-point number.
	 * @return                  <Number> A number or NaN (not a number).
	 */
	public function parseFloat(str:String):Number;
	/**
	 * Converts a string to an integer. If the specified string in the parameters cannot be converted to a number, the function returns NaN. Strings beginning with 0x are interpreted as hexadecimal numbers. Unlike in previous versions of ActionScript, integers beginning with 0 are not interpreted as octal numbers. You must specify a radix of 8 for octal numbers. White space and zeroes preceding valid integers are ignored, as are trailing nonnumeric characters.
	 *
	 * @param str               <String> A string to convert to an integer.
	 * @param radix             <uint (default = 0)> An integer representing the radix (base) of the number to parse. Legal values are from 2 to 36.
	 * @return                  <Number> A number or NaN (not a number).
	 */
	public function parseInt(str:String, radix:uint = 0):Number;
	/** */
	public function trace(... arguments):void;
	/**
	 * Evaluates the parameter str as a string, decodes the string from URL-encoded format
	 *  (converting all hexadecimal sequences to ASCII characters), and returns the string.
	 *
	 * @param str               <String> A string with hexadecimal sequences to escape.
	 * @return                  <String> A string decoded from a URL-encoded parameter.
	 */
	public function unescape(str:String):String;
}
