/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class RegExpValidator extends Validator {
		/**
		 * The regular expression to use for validation.
		 */
		public function get expression():String;
		public function set expression(value:String):void;
		/**
		 * The regular expression flags to use when matching.
		 */
		public function get flags():String;
		public function set flags(value:String):void;
		/**
		 * Error message when there is no regular expression specifed.
		 *  The default value is "The expression is missing."
		 */
		public function get noExpressionError():String;
		public function set noExpressionError(value:String):void;
		/**
		 * Error message when there are no matches to the regular expression.
		 *  The default value is "The field is invalid."
		 */
		public function get noMatchError():String;
		public function set noMatchError(value:String):void;
		/**
		 * Constructor
		 */
		public function RegExpValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a regular expression.
		 *
		 * @param value             <Object> Object to validate.
		 * @return                  <Array> For an invalid result, an Array of ValidationResult objects,
		 *                            with one ValidationResult object for each field examined by the validator.
		 */
		protected override function doValidation(value:Object):Array;
	}
}
