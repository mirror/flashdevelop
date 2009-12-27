package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

include "../core/Version.as"
	/**
	 *  The CurrencyValidator class ensures that a String
 *  represents a valid currency expression.
 *  It can make sure the input falls within a given range
 *  (specified by <code>minValue</code> and <code>maxValue</code>),
 *  is non-negative (specified by <code>allowNegative</code>),
 *  and does not exceed the specified <code>precision</code>. The 
 *  CurrencyValidator class correctly validates formatted and unformatted
 *  currency expressions, e.g., "$12,345.00" and "12345".
 *  You can customize the <code>currencySymbol</code>, <code>alignSymbol</code>,
 *  <code>thousandsSeparator</code>, and <code>decimalSeparator</code>
 *  properties for internationalization.
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:CurrencyValidator&gt;</code> tag
 *  inherits all of the tag properties of its superclass,
 *  and adds the following tag properties:</p>
 *
 *  <pre>
 *  &lt;mx:CurrencyValidator
 *    alignSymbol="left|right|any"
 *    allowNegative="true|false"
 *    currencySymbol="$"
 *    currencySymbolError="The currency symbol occurs in an invalid location."
 *    decimalPointCountError="The decimal separator can occur only once."
 *    decimalSeparator="."
 *    exceedsMaxError="The amount entered is too large."
 *    invalidCharError="The input contains invalid characters."
 *    invalidFormatCharsError="One of the formatting parameters is invalid."
 *    lowerThanMinError="The amount entered is too small."
 *    maxValue="NaN"
 *    minValue="NaN"
 *    negativeError="The amount may not be negative."
 *    precision="2"
 *    precisionError="The amount entered has too many digits beyond the decimal point."
 *    separationError="The thousands separator must be followed by three digits."
 *    thousandsSeparator=","
 *  /&gt;
 *  </pre>
 *
 *  @see mx.validators.CurrencyValidatorAlignSymbol
 *
 *  @includeExample examples/CurrencyValidatorExample.mxml
	 */
	public class CurrencyValidator extends Validator
	{
		/**
		 *  @private
     *  Formatting characters for negative values.
		 */
		private static const NEGATIVE_FORMATTING_CHARS : String = "-()";
		/**
		 *  @private
     *  Storage for the alignSymbol property.
		 */
		private var _alignSymbol : String;
		/**
		 *  @private
		 */
		private var alignSymbolOverride : String;
		/**
		 *  @private
     *  Storage for the allowNegative property.
		 */
		private var _allowNegative : Object;
		/**
		 *  @private
		 */
		private var allowNegativeOverride : Object;
		/**
		 *  @private
     *  Storage for the currencySymbol property.
		 */
		private var _currencySymbol : String;
		/**
		 *  @private
		 */
		private var currencySymbolOverride : String;
		/**
		 *  @private
     *  Storage for the decimalSeparator property.
		 */
		private var _decimalSeparator : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorOverride : String;
		/**
		 *  @private
     *  Storage for the maxValue property.
		 */
		private var _maxValue : Object;
		/**
		 *  @private
		 */
		private var maxValueOverride : Object;
		/**
		 *  @private
     *  Storage for the minValue property.
		 */
		private var _minValue : Object;
		/**
		 *  @private
		 */
		private var minValueOverride : Object;
		/**
		 *  @private
     *  Storage for the precision property.
		 */
		private var _precision : Object;
		/**
		 *  @private
		 */
		private var precisionOverride : Object;
		/**
		 *  @private
     *  Storage for the thousandsSeparator property.
		 */
		private var _thousandsSeparator : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorOverride : String;
		/**
		 *  @private
     *  Storage for the currencySymbolError property.
		 */
		private var _currencySymbolError : String;
		/**
		 *  @private
		 */
		private var currencySymbolErrorOverride : String;
		/**
		 *  @private
     *  Storage for the decimalPointCountError property.
		 */
		private var _decimalPointCountError : String;
		/**
		 *  @private
		 */
		private var decimalPointCountErrorOverride : String;
		/**
		 *  @private
     *  Storage for the exceedsMaxError property.
		 */
		private var _exceedsMaxError : String;
		/**
		 *  @private
		 */
		private var exceedsMaxErrorOverride : String;
		/**
		 *  @private
     *  Storage for the invalidCharError property.
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private
     *  Storage for the invalidFormatCharsError property.
		 */
		private var _invalidFormatCharsError : String;
		/**
		 *  @private
		 */
		private var invalidFormatCharsErrorOverride : String;
		/**
		 *  @private
     *  Storage for the lowerThanMinError property.
		 */
		private var _lowerThanMinError : String;
		/**
		 *  @private
		 */
		private var lowerThanMinErrorOverride : String;
		/**
		 *  @private
     *  Storage for the negativeError property.
		 */
		private var _negativeError : String;
		/**
		 *  @private
		 */
		private var negativeErrorOverride : String;
		/**
		 *  @private
     *  Storage for the precisionError property.
		 */
		private var _precisionError : String;
		/**
		 *  @private
		 */
		private var precisionErrorOverride : String;
		/**
		 *  @private
     *  Storage for the separationError property.
		 */
		private var _separationError : String;
		/**
		 *  @private
		 */
		private var separationErrorOverride : String;

		/**
		 *  Specifies the alignment of the <code>currencySymbol</code>
     *  relative to the rest of the expression.
     *  Acceptable values in ActionScript are <code>CurrencyValidatorAlignSymbol.LEFT</code>, 
     *  <code>CurrencyValidatorAlignSymbol.RIGHT</code>, and 
     *  <code>CurrencyValidatorAlignSymbol.ANY</code>.
     *  Acceptable values in MXML are <code>"left"</code>, 
     *  <code>"right"</code>, and 
     *  <code>"any"</code>.
     * 
     *  @default CurrencyValidatorAlignSymbol.LEFT
     *
     *  @see mx.validators.CurrencyValidatorAlignSymbol
		 */
		public function get alignSymbol () : String;
		/**
		 *  @private
		 */
		public function set alignSymbol (value:String) : void;

		/**
		 *  Specifies whether negative numbers are permitted.
     *  Can be <code>true</code> or <code>false</code>.
     *  
     *  @default true
		 */
		public function get allowNegative () : Object;
		/**
		 *  @private
		 */
		public function set allowNegative (value:Object) : void;

		/**
		 *  The character String used to specify the currency symbol, 
     *  such as "$", "R$", or "&#163;".
     *  Cannot be a digit and must be distinct from the
     *  <code>thousandsSeparator</code> and the <code>decimalSeparator</code>.
     *
     *  @default "$"
		 */
		public function get currencySymbol () : String;
		/**
		 *  @private
		 */
		public function set currencySymbol (value:String) : void;

		/**
		 *  The character used to separate the whole
     *  from the fractional part of the number.
     *  Cannot be a digit and must be distinct from the
     *  <code>currencySymbol</code> and the <code>thousandsSeparator</code>.
     *  
     *  @default "."
		 */
		public function get decimalSeparator () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparator (value:String) : void;

		/**
		 *  Maximum value for a valid number.
     *  A value of NaN means it is ignored.
     *  
     *  @default NaN
		 */
		public function get maxValue () : Object;
		/**
		 *  @private
		 */
		public function set maxValue (value:Object) : void;

		/**
		 *  Minimum value for a valid number.
     *  A value of NaN means it is ignored.
     *  
     *  @default NaN
		 */
		public function get minValue () : Object;
		/**
		 *  @private
		 */
		public function set minValue (value:Object) : void;

		/**
		 *  The maximum number of digits allowed to follow the decimal point.
     *  Can be any non-negative integer.
     *  Note: Setting to <code>0</code>
     *  has the same effect as setting <code>NumberValidator.domain</code>
     *  to <code>int</code>.
     *  Setting it to -1, means it is ignored.
     * 
     *  @default 2
		 */
		public function get precision () : Object;
		/**
		 *  @private
		 */
		public function set precision (value:Object) : void;

		/**
		 *  The character used to separate thousands.
     *  Cannot be a digit and must be distinct from the
     *  <code>currencySymbol</code> and the <code>decimalSeparator</code>.
     *  
     *  @default ","
		 */
		public function get thousandsSeparator () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparator (value:String) : void;

		/**
		 *  Error message when the currency symbol, defined by <code>currencySymbol</code>,
     *  is in the wrong location.
     *  
     *  @default "The currency symbol occurs in an invalid location."
		 */
		public function get currencySymbolError () : String;
		/**
		 *  @private
		 */
		public function set currencySymbolError (value:String) : void;

		/**
		 *  Error message when the decimal separator character occurs more than once.
     *  
     *  @default "The decimal separator can only occur once."
		 */
		public function get decimalPointCountError () : String;
		/**
		 *  @private
		 */
		public function set decimalPointCountError (value:String) : void;

		/**
		 *  Error message when the value is greater than <code>maxValue</code>.
     *  
     *  @default "The amount entered is too large."
		 */
		public function get exceedsMaxError () : String;
		/**
		 *  @private
		 */
		public function set exceedsMaxError (value:String) : void;

		/**
		 *  Error message when the currency contains invalid characters.
     *  
     *  @default "The input contains invalid characters."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;

		/**
		 *  Error message when the value contains an invalid formatting character.
     *  
     *  @default "One of the formatting parameters is invalid."
		 */
		public function get invalidFormatCharsError () : String;
		/**
		 *  @private
		 */
		public function set invalidFormatCharsError (value:String) : void;

		/**
		 *  Error message when the value is less than <code>minValue</code>.
     *  
     *  @default "The amount entered is too small."
		 */
		public function get lowerThanMinError () : String;
		/**
		 *  @private
		 */
		public function set lowerThanMinError (value:String) : void;

		/**
		 *  Error message when the value is negative and
     *  the <code>allowNegative</code> property is <code>false</code>.
     *  
     *  @default "The amount may not be negative."
		 */
		public function get negativeError () : String;
		/**
		 *  @private
		 */
		public function set negativeError (value:String) : void;

		/**
		 *  Error message when the value has a precision that exceeds the value
     *  defined by the <code>precision</code> property.
     *  
     *  @default "The amount entered has too many digits beyond 
     *  the decimal point."
		 */
		public function get precisionError () : String;
		/**
		 *  @private
		 */
		public function set precisionError (value:String) : void;

		/**
		 *  Error message when the thousands separator is incorrectly placed.
     *  
     *  @default "The thousands separator must be followed by three digits."
		 */
		public function get separationError () : String;
		/**
		 *  @private
		 */
		public function set separationError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.
     *  Each of the standard Flex validators has a similar convenience method.
     *
     *  @param validator The CurrencyValidator instance.
     *
     *  @param value The object to validate.
     *
     *  @param baseField Text representation of the subfield
     *  specified in the <code>value</code> parameter.
     *  For example, if the <code>value</code> parameter specifies value.currency,
     *  the baseField value is "currency".
     *
     *  @return An Array of ValidationResult objects, with one ValidationResult 
     *  object for each field examined by the validator. 
     *
     *  @see mx.validators.ValidationResult
		 */
		public static function validateCurrency (validator:CurrencyValidator, value:Object, baseField:String) : Array;

		/**
		 *  Constructor.
		 */
		public function CurrencyValidator ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Override of the base class <code>doValidation()</code> method
     *  to validate a currency expression.
     *
     *  <p>You do not call this method directly;
     *  Flex calls it as part of performing a validation.
     *  If you create a custom Validator class, you must implement this method. </p>
     *
     *  @param value Object to validate.
     *
     *  @return An Array of ValidationResult objects, with one ValidationResult 
     *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
	}
}
