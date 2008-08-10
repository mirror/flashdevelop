/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class SocialSecurityValidator extends Validator {
		/**
		 * Specifies the set of formatting characters allowed in the input.
		 */
		public function get allowedFormatChars():String;
		public function set allowedFormatChars(value:String):void;
		/**
		 * Error message when the value contains characters
		 *  other than digits and formatting characters
		 *  defined by the allowedFormatChars property.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the value is incorrectly formatted.
		 */
		public function get wrongFormatError():String;
		public function set wrongFormatError(value:String):void;
		/**
		 * Error message when the value contains an invalid Social Security number.
		 */
		public function get zeroStartError():String;
		public function set zeroStartError(value:String):void;
		/**
		 * Constructor.
		 */
		public function SocialSecurityValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a Social Security number.
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
		 * @param validator         <SocialSecurityValidator> The SocialSecurityValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies
		 *                            value.social, the baseField value is social.
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validateSocialSecurity(validator:SocialSecurityValidator, value:Object, baseField:String):Array;
	}
}
