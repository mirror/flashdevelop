package mx.formatters
{
	/**
	 *  @private *  The StringFormatter class provides a mechanism for displaying *  and saving data in the specified format. *  The constructor accepts the format and an Array of tokens, *  and uses these values to create the data structures to support *  the formatting during data retrieval and saving.  *   *  <p>This class is used internally by other formatters, *  and is typically not used directly.</p> *   *  @see mx.formatters.DateFormatter
	 */
	public class StringFormatter
	{
		/**
		 *  @private
		 */
		private var extractToken : Function;
		/**
		 *  @private
		 */
		private var reqFormat : String;
		/**
		 *  @private
		 */
		private var patternInfo : Array;

		/**
		 *  Constructor.	 * 	 *  @param format String that contains the desired format.	 *	 *  @param tokens String that contains the character tokens	 *  within the specified format String that is replaced	 *  during data formatting operations.	 *	 *  @param extractTokenFunc The token 	 *  accessor method to call when formatting for display.	 *  The method signature is	 *  value: anything, tokenInfo: {token: id, begin: start, end: finish}.	 *  This method must return a String representation of value	 *  for the specified <code>tokenInfo</code>.
		 */
		public function StringFormatter (format:String, tokens:String, extractTokenFunc:Function);
		/**
		 *  Returns the formatted String using the format, tokens,	 *  and extraction function passed to the constructor.	 *	 *  @param value String to be formatted.	 *	 *  @return Formatted String.
		 */
		public function formatValue (value:Object) : String;
		/**
		 *  @private	 *  Formats a user-defined pattern String into a more usable object.	 *	 *  @param format String that defines the user-requested pattern.	 *	 *  @param tokens List of valid patttern characters.
		 */
		private function formatPattern (format:String, tokens:String) : void;
		/**
		 *  @private
		 */
		private function compareValues (a:Object, b:Object) : int;
	}
}
