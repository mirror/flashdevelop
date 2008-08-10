/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class EmailValidator extends Validator {
		/**
		 * Error message when there are invalid characters in the e-mail address.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the suffix (the top level domain)
		 *  is not 2, 3, 4 or 6 characters long.
		 */
		public function get invalidDomainError():String;
		public function set invalidDomainError(value:String):void;
		/**
		 * Error message when the IP domain is invalid. The IP domain must be enclosed by square brackets.
		 */
		public function get invalidIPDomainError():String;
		public function set invalidIPDomainError(value:String):void;
		/**
		 * Error message when there are continuous periods in the domain.
		 */
		public function get invalidPeriodsInDomainError():String;
		public function set invalidPeriodsInDomainError(value:String):void;
		/**
		 * Error message when there is no at sign in the email address.
		 */
		public function get missingAtSignError():String;
		public function set missingAtSignError(value:String):void;
		/**
		 * Error message when there is no period in the domain.
		 */
		public function get missingPeriodInDomainError():String;
		public function set missingPeriodInDomainError(value:String):void;
		/**
		 * Error message when there is no username.
		 */
		public function get missingUsernameError():String;
		public function set missingUsernameError(value:String):void;
		/**
		 * Error message when there is more than one at sign in the e-mail address.
		 *  This property is optional.
		 */
		public function get tooManyAtSignsError():String;
		public function set tooManyAtSignsError(value:String):void;
		/**
		 * Constructor.
		 */
		public function EmailValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate an e-mail address.
		 *
		 * @param value             <Object> Either a String or an Object to validate.
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		protected override function doValidation(value:Object):Array;
		/**
		 * Convenience method for calling a validator
		 *  from within a custom validation function.
		 *  Each of the standard Flex validators has a similar convenience method.
		 *
		 * @param validator         <EmailValidator> The EmailValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies value.email,
		 *                            the baseField value is "email".
		 * @return                  <Array> An Array of ValidationResult objects, with one
		 *                            ValidationResult object for each field examined by the validator.
		 */
		public static function validateEmail(validator:EmailValidator, value:Object, baseField:String):Array;
	}
}
