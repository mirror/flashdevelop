/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class ZipCodeValidator extends Validator {
		/**
		 * The set of formatting characters allowed in the ZIP code.
		 *  This can not have digits or alphabets [a-z A-Z].
		 */
		public function get allowedFormatChars():String;
		public function set allowedFormatChars(value:String):void;
		/**
		 * Type of ZIP code to check.
		 *  In MXML, valid values are "US or Canada"
		 *  and "US Only".
		 */
		public function get domain():String;
		public function set domain(value:String):void;
		/**
		 * Error message when the ZIP code contains invalid characters.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the domain property contains an invalid value.
		 */
		public function get invalidDomainError():String;
		public function set invalidDomainError(value:String):void;
		/**
		 * Error message for an invalid Canadian postal code.
		 */
		public function get wrongCAFormatError():String;
		public function set wrongCAFormatError(value:String):void;
		/**
		 * Error message for an invalid US ZIP code.
		 */
		public function get wrongLengthError():String;
		public function set wrongLengthError(value:String):void;
		/**
		 * Error message for an incorrectly formatted ZIP code.
		 */
		public function get wrongUSFormatError():String;
		public function set wrongUSFormatError(value:String):void;
		/**
		 * Constructor.
		 */
		public function ZipCodeValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a ZIP code.
		 *
		 * @param value             <Object> Object to validate.
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		protected override function doValidation(value:Object):Array;
		/**
		 * Convenience method for calling a validator.
		 *  Each of the standard Flex validators has a similar convenience method.
		 *
		 * @param validator         <ZipCodeValidator> The ZipCodeValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies value.zipCode,
		 *                            the baseField value is "zipCode".
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validateZipCode(validator:ZipCodeValidator, value:Object, baseField:String):Array;
	}
}
