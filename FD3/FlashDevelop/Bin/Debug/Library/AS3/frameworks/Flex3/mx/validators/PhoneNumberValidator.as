/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class PhoneNumberValidator extends Validator {
		/**
		 * The set of allowable formatting characters.
		 */
		public function get allowedFormatChars():String;
		public function set allowedFormatChars(value:String):void;
		/**
		 * Error message when the value contains invalid characters.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the value has fewer than 10 digits.
		 */
		public function get wrongLengthError():String;
		public function set wrongLengthError(value:String):void;
		/**
		 * Constructor.
		 */
		public function PhoneNumberValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a phone number.
		 *
		 * @param value             <Object> Object to validate.
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		protected override function doValidation(value:Object):Array;
		/**
		 * Convenience method for calling a validator
		 *  from within a custom validation function.
		 *  Each of the standard Flex validators has a similar convenience method.
		 *
		 * @param validator         <PhoneNumberValidator> The PhoneNumberValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies value.phone,
		 *                            the baseField value is "phone".
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validatePhoneNumber(validator:PhoneNumberValidator, value:Object, baseField:String):Array;
	}
}
