/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class CurrencyValidator extends Validator {
		/**
		 * Specifies the alignment of the currencySymbol
		 *  relative to the rest of the expression.
		 *  Acceptable values in ActionScript are CurrencyValidatorAlignSymbol.LEFT,
		 *  CurrencyValidatorAlignSymbol.RIGHT, and
		 *  CurrencyValidatorAlignSymbol.ANY.
		 *  Acceptable values in MXML are "left",
		 *  "right", and
		 *  "any".
		 */
		public function get alignSymbol():String;
		public function set alignSymbol(value:String):void;
		/**
		 * Specifies whether negative numbers are permitted.
		 *  Can be true or false.
		 */
		public function get allowNegative():Object;
		public function set allowNegative(value:Object):void;
		/**
		 * The single-character String used to specify the currency symbol,
		 *  such as "$" or "£".
		 *  Cannot be a digit and must be distinct from the
		 *  thousandsSeparator and the decimalSeparator.
		 */
		public function get currencySymbol():String;
		public function set currencySymbol(value:String):void;
		/**
		 * Error message when the currency symbol, defined by currencySymbol,
		 *  is in the wrong location.
		 */
		public function get currencySymbolError():String;
		public function set currencySymbolError(value:String):void;
		/**
		 * Error message when the decimal separator character occurs more than once.
		 */
		public function get decimalPointCountError():String;
		public function set decimalPointCountError(value:String):void;
		/**
		 * The character used to separate the whole
		 *  from the fractional part of the number.
		 *  Cannot be a digit and must be distinct from the
		 *  currencySymbol and the thousandsSeparator.
		 */
		public function get decimalSeparator():String;
		public function set decimalSeparator(value:String):void;
		/**
		 * Error message when the value is greater than maxValue.
		 */
		public function get exceedsMaxError():String;
		public function set exceedsMaxError(value:String):void;
		/**
		 * Error message when the currency contains invalid characters.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the value contains an invalid formatting character.
		 */
		public function get invalidFormatCharsError():String;
		public function set invalidFormatCharsError(value:String):void;
		/**
		 * Error message when the value is less than minValue.
		 */
		public function get lowerThanMinError():String;
		public function set lowerThanMinError(value:String):void;
		/**
		 * Maximum value for a valid number.
		 *  A value of NaN means it is ignored.
		 */
		public function get maxValue():Object;
		public function set maxValue(value:Object):void;
		/**
		 * Minimum value for a valid number.
		 *  A value of NaN means it is ignored.
		 */
		public function get minValue():Object;
		public function set minValue(value:Object):void;
		/**
		 * Error message when the value is negative and
		 *  the allowNegative property is false.
		 */
		public function get negativeError():String;
		public function set negativeError(value:String):void;
		/**
		 * The maximum number of digits allowed to follow the decimal point.
		 *  Can be any non-negative integer.
		 *  Note: Setting to 0
		 *  has the same effect as setting NumberValidator.domain
		 *  to int.
		 *  Setting it to -1, means it is ignored.
		 */
		public function get precision():Object;
		public function set precision(value:Object):void;
		/**
		 * Error message when the value has a precision that exceeds the value
		 *  defined by the precision property.
		 */
		public function get precisionError():String;
		public function set precisionError(value:String):void;
		/**
		 * Error message when the thousands separator is incorrectly placed.
		 */
		public function get separationError():String;
		public function set separationError(value:String):void;
		/**
		 * The character used to separate thousands.
		 *  Cannot be a digit and must be distinct from the
		 *  currencySymbol and the decimalSeparator.
		 */
		public function get thousandsSeparator():String;
		public function set thousandsSeparator(value:String):void;
		/**
		 * Constructor.
		 */
		public function CurrencyValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a currency expression.
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
		 * @param validator         <CurrencyValidator> The CurrencyValidator instance.
		 * @param value             <Object> The object to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter specifies value.currency,
		 *                            the baseField value is "currency".
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validateCurrency(validator:CurrencyValidator, value:Object, baseField:String):Array;
	}
}
