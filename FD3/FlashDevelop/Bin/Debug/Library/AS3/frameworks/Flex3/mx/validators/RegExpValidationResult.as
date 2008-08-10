/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class RegExpValidationResult extends ValidationResult {
		/**
		 * An integer that contains the starting index
		 *  in the input String of the match.
		 */
		public var matchedIndex:int;
		/**
		 * A String that contains the substring of the input String
		 *  that matches the regular expression.
		 */
		public var matchedString:String;
		/**
		 * An Array of Strings that contains parenthesized
		 *  substring matches, if any.
		 *  If no substring matches are found, this Array is of length 0.
		 *  Use matchedSubStrings[0] to access
		 *  the first substring match.
		 */
		public var matchedSubstrings:Array;
		/**
		 * Constructor
		 *
		 * @param isError           <Boolean> Pass true if there was a validation error.
		 * @param subField          <String (default = "")> Name of the subfield of the validated Object.
		 * @param errorCode         <String (default = "")> Validation error code.
		 * @param errorMessage      <String (default = "")> Validation error message.
		 * @param matchedString     <String (default = "")> Matching substring.
		 * @param matchedIndex      <int (default = 0)> Index of the matching String.
		 * @param matchedSubstrings <Array (default = null)> Array of substring matches.
		 */
		public function RegExpValidationResult(isError:Boolean, subField:String = "", errorCode:String = "", errorMessage:String = "", matchedString:String = "", matchedIndex:int = 0, matchedSubstrings:Array = null);
	}
}
