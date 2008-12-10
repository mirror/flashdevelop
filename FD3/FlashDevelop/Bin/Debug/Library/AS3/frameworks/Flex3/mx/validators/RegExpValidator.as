package mx.validators
{
	import mx.events.ValidationResultEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The RegExpValidator class lets you use a regular expression *  to validate a field.  *  You pass a regular expression to the validator using the *  <code>expression</code> property, and additional flags *  to control the regular expression pattern matching  *  using the <code>flags</code> property.  * *  <p>The validation is successful if the validator can find a match *  of the regular expression in the field to validate. *  A validation error occurs when the validator finds no match.</p> * *  <p>The RegExpValidator class dispatches the <code>valid</code> *  and <code>invalid</code> events. *  For an <code>invalid</code> event, the event object is an instance *  of the ValidationResultEvent class, and it contains an Array *  of ValidationResult objects.</p> * *  <p>However, for a <code>valid</code> event, the ValidationResultEvent *  object contains an Array of RegExpValidationResult objects. *  The RegExpValidationResult class is a child class of the *  ValidationResult class, and contains additional properties  *  used with regular expressions, including the following:</p> *  <ul> *    <li><code>matchedIndex</code> An integer that contains the starting  *      index in the input String of the match.</li> *    <li><code>matchedString</code> A String that contains the substring  *      of the input String that matches the regular expression.</li> *    <li><code>matchedSubStrings</code> An Array of Strings that contains  *      parenthesized substring matches, if any. If no substring matches are found,  *      this Array is of length 0.  Use matchedSubStrings[0] to access the  *      first substring match.</li> *  </ul> *   *  @mxml * *  <p>The <code>&lt;mx:RegExpValidator&gt;</code> tag  *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:RegExpValidator *    expression="<i>No default</i>"  *    flags="<i>No default</i>"  *    noExpressionError="The expression is missing."  *    noMatchError="The field is invalid."  *  /&gt; *  </pre> * *  @includeExample examples/RegExValidatorExample.mxml *   *  @see mx.validators.RegExpValidationResult *  @see mx.validators.ValidationResult *  @see RegExp
	 */
	public class RegExpValidator extends Validator
	{
		/**
		 *  @private
		 */
		private var regExp : RegExp;
		/**
		 *  @private
		 */
		private var foundMatch : Boolean;
		/**
		 *  @private     *  Storage for the expression property.
		 */
		private var _expression : String;
		/**
		 *  @private     *  Storage for the flags property.
		 */
		private var _flags : String;
		/**
		 *  @private	 *  Storage for the noExpressionError property.
		 */
		private var _noExpressionError : String;
		/**
		 *  @private
		 */
		private var noExpressionErrorOverride : String;
		/**
		 *  @private	 *  Storage for the noMatchError property.
		 */
		private var _noMatchError : String;
		/**
		 *  @private
		 */
		private var noMatchErrorOverride : String;

		/**
		 *  The regular expression to use for validation.
		 */
		public function get expression () : String;
		/**
		 *  @private
		 */
		public function set expression (value:String) : void;
		/**
		 *  The regular expression flags to use when matching.
		 */
		public function get flags () : String;
		/**
		 *  @private
		 */
		public function set flags (value:String) : void;
		/**
		 *  Error message when there is no regular expression specifed.      *  The default value is "The expression is missing."
		 */
		public function get noExpressionError () : String;
		/**
		 *  @private
		 */
		public function set noExpressionError (value:String) : void;
		/**
		 *  Error message when there are no matches to the regular expression.      *  The default value is "The field is invalid."
		 */
		public function get noMatchError () : String;
		/**
		 *  @private
		 */
		public function set noMatchError (value:String) : void;

		/**
		 *  Constructor
		 */
		public function RegExpValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method     *  to validate a regular expression.     *     *  <p>You do not call this method directly;     *  Flex calls it as part of performing a validation.     *  If you create a custom Validator class, you must implement this method. </p>     *     *  @param value Object to validate.     *     *  @return For an invalid result, an Array of ValidationResult objects,     *  with one ValidationResult object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
		/**
		 *  @private
		 */
		protected function handleResults (errorResults:Array) : ValidationResultEvent;
		/**
		 *  @private
		 */
		private function createRegExp () : void;
		/**
		 *  @private      *  Performs validation on the validator
		 */
		private function validateRegExpression (value:Object) : Array;
	}
}
