/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class StringValidator extends Validator {
		/**
		 * Maximum length for a valid String.
		 *  A value of NaN means this property is ignored.
		 */
		public function get maxLength():Object;
		public function set maxLength(value:Object):void;
		/**
		 * Minimum length for a valid String.
		 *  A value of NaN means this property is ignored.
		 */
		public function get minLength():Object;
		public function set minLength(value:Object):void;
		/**
		 * Error message when the String is longer
		 *  than the maxLength property.
		 */
		public function get tooLongError():String;
		public function set tooLongError(value:String):void;
		/**
		 * Error message when the string is shorter
		 *  than the minLength property.
		 */
		public function get tooShortError():String;
		public function set tooShortError(value:String):void;
		/**
		 * Constructor.
		 */
		public function StringValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a String.
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
		 * @param validator         <StringValidator> The StringValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String (default = null)> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies
		 *                            value.mystring, the baseField value
		 *                            is "mystring".
		 * @return                  <Array> An Array of ValidationResult objects, with one
		 *                            ValidationResult  object for each field examined by the validator.
		 */
		public static function validateString(validator:StringValidator, value:Object, baseField:String = null):Array;
	}
}
