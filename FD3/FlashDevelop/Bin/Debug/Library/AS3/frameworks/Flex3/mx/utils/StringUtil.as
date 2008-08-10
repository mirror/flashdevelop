/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class StringUtil {
		/**
		 * Returns true if the specified string is
		 *  a single space, tab, carriage return, newline, or formfeed character.
		 *
		 * @param character         <String> The String that is is being queried.
		 * @return                  <Boolean> true if the specified string is
		 *                            a single space, tab, carriage return, newline, or formfeed character.
		 */
		public static function isWhitespace(character:String):Boolean;
		/**
		 * Substitutes "{n}" tokens within the specified string
		 *  with the respective arguments passed in.
		 *
		 * @param str               <String> The string to make substitutions in.
		 *                            This string can contain special tokens of the form
		 *                            {n}, where n is a zero based index,
		 *                            that will be replaced with the additional parameters
		 *                            found at that index if specified.
		 * @return                  <String> New string with all of the {n} tokens
		 *                            replaced with the respective arguments specified.
		 */
		public static function substitute(str:String, ... rest):String;
		/**
		 * Removes all whitespace characters from the beginning and end
		 *  of the specified string.
		 *
		 * @param str               <String> The String whose whitespace should be trimmed.
		 * @return                  <String> Updated String where whitespace was removed from the
		 *                            beginning and end.
		 */
		public static function trim(str:String):String;
		/**
		 * Removes all whitespace characters from the beginning and end
		 *  of each element in an Array, where the Array is stored as a String.
		 *
		 * @param value             <String> The String whose whitespace should be trimmed.
		 * @param delimiter         <String> The String that delimits each Array element in the string.
		 * @return                  <String> Updated String where whitespace was removed from the
		 *                            beginning and end of each element.
		 */
		public static function trimArrayElements(value:String, delimiter:String):String;
	}
}
