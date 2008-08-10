/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class NumberValidator extends Validator {
		/**
		 * Specifies whether negative numbers are permitted.
		 *  Valid values are true or false.
		 */
		public function get allowNegative():Object;
		public function set allowNegative(value:Object):void;
		/**
		 * Error message when the decimal separator character occurs more than once.
		 */
		public function get decimalPointCountError():String;
		public function set decimalPointCountError(value:String):void;
		/**
		 * The character used to separate the whole
		 *  from the fractional part of the number.
		 *  Cannot be a digit and must be distinct from the
		 *  thousandsSeparator.
		 */
		public function get decimalSeparator():String;
		public function set decimalSeparator(value:String):void;
		/**
		 * Type of number to be validated.
		 *  Permitted values are "real" and "int".
		 */
		public function get domain():String;
		public function set domain(value:String):void;
		/**
		 * Error message when the value exceeds the maxValue property.
		 */
		public function get exceedsMaxError():String;
		public function set exceedsMaxError(value:String):void;
		/**
		 * Error message when the number must be an integer, as defined
		 *  by the domain property.
		 */
		public function get integerError():String;
		public function set integerError(value:String):void;
		/**
		 * Error message when the value contains invalid characters.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the value contains invalid format characters, which means that
		 *  it contains a digit or minus sign (-) as a separator character,
		 *  or it contains two or more consecutive separator characters.
		 */
		public function get invalidFormatCharsError():String;
		public function set invalidFormatCharsError(value:String):void;
		/**
		 * Error message when the value is less than minValue.
		 */
		public function get lowerThanMinError():String;
		public function set lowerThanMinError(value:String):void;
		/**
		 * Maximum value for a valid number. A value of NaN means there is no maximum.
		 */
		public function get maxValue():Object;
		public function set maxValue(value:Object):void;
		/**
		 * Minimum value for a valid number. A value of NaN means there is no minimum.
		 */
		public function get minValue():Object;
		public function set minValue(value:Object):void;
		/**
		 * Error message when the value is negative and the
		 *  allowNegative property is false.
		 */
		public function get negativeError():String;
		public function set negativeError(value:String):void;
		/**
		 * The maximum number of digits allowed to follow the decimal point.
		 *  Can be any nonnegative integer.
		 *  Note: Setting to 0 has the same effect
		 *  as setting domain to "int".
		 *  A value of -1 means it is ignored.
		 */
		public function get precision():Object;
		public function set precision(value:Object):void;
		/**
		 * Error message when the value has a precision that exceeds the value defined
		 *  by the precision property.
		 */
		public function get precisionError():String;
		public function set precisionError(value:String):void;
		/**
		 * Error message when the thousands separator is in the wrong location.
		 */
		public function get separationError():String;
		public function set separationError(value:String):void;
		/**
		 * The character used to separate thousands
		 *  in the whole part of the number.
		 *  Cannot be a digit and must be distinct from the
		 *  decimalSeparator.
		 */
		public function get thousandsSeparator():String;
		public function set thousandsSeparator(value:String):void;
		/**
		 * Constructor.
		 */
		public function NumberValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a number.
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
		 * @param validator         <NumberValidator> The NumberValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies value.number,
		 *                            the baseField value is "number".
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validateNumber(validator:NumberValidator, value:Object, baseField:String):Array;
	}
}
