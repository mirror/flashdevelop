package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

include "../core/Version.as"
	/**
	 *  The NumberValidator class ensures that a String represents a valid number.
 *  It can ensure that the input falls within a given range
 *  (specified by <code>minValue</code> and <code>maxValue</code>),
 *  is an integer (specified by <code>domain</code>),
 *  is non-negative (specified by <code>allowNegative</code>),
 *  and does not exceed the specified <code>precision</code>.
 *  The validator correctly validates formatted numbers (e.g., "12,345.67")
 *  and you can customize the <code>thousandsSeparator</code> and
 *  <code>decimalSeparator</code> properties for internationalization.
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:NumberValidator&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:NumberValidator 
 *    allowNegative="true|false" 
 *    decimalPointCountError="The decimal separator can only occur once." 
 *    decimalSeparator="." 
 *    domain="real|int" 
 *    exceedsMaxError="The number entered is too large." 
 *    integerError="The number must be an integer." 
 *    invalidCharError="The input contains invalid characters." 
 *    invalidFormatCharsError="One of the formatting parameters is invalid." 
 *    lowerThanMinError="The amount entered is too small." 
 *    maxValue="NaN" 
 *    minValue="NaN" 
 *    negativeError="The amount may not be negative." 
 *    precision="-1" 
 *    precisionError="The amount entered has too many digits beyond the decimal point." 
 *    separationError="The thousands separator must be followed by three digits." 
 *    thousandsSeparator="," 
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/NumberValidatorExample.mxml
	 */
	public class NumberValidator extends Validator
	{
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
	 *  Storage for the decimalSeparator property.
		 */
		private var _decimalSeparator : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorOverride : String;
		/**
		 *  @private
	 *  Storage for the domain property.
		 */
		private var _domain : String;
		/**
		 *  @private
		 */
		private var domainOverride : String;
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
	 *  Storage for the integerError property.
		 */
		private var _integerError : String;
		/**
		 *  @private
		 */
		private var integerErrorOverride : String;
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
		 *  Specifies whether negative numbers are permitted.
	 *  Valid values are <code>true</code> or <code>false</code>.
	 *
	 *  @default true
		 */
		public function get allowNegative () : Object;
		/**
		 *  @private
		 */
		public function set allowNegative (value:Object) : void;

		/**
		 *  The character used to separate the whole
	 *  from the fractional part of the number.
	 *  Cannot be a digit and must be distinct from the
     *  <code>thousandsSeparator</code>.
	 *
	 *  @default "."
		 */
		public function get decimalSeparator () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparator (value:String) : void;

		/**
		 *  Type of number to be validated.
	 *  Permitted values are <code>"real"</code> and <code>"int"</code>.
	 *
	 *  <p>In ActionScript, you can use the following constants to set this property: 
     *  <code>NumberValidatorDomainType.REAL</code> or
     *  <code>NumberValidatorDomainType.INT</code>.</p>
     * 
	 *  @default "real"
		 */
		public function get domain () : String;
		/**
		 *  @private
		 */
		public function set domain (value:String) : void;

		/**
		 *  Maximum value for a valid number. A value of NaN means there is no maximum.
	 *
	 *  @default NaN
		 */
		public function get maxValue () : Object;
		/**
		 *  @private
		 */
		public function set maxValue (value:Object) : void;

		/**
		 *  Minimum value for a valid number. A value of NaN means there is no minimum.
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
	 *  Can be any nonnegative integer. 
	 *  Note: Setting to <code>0</code> has the same effect
	 *  as setting <code>domain</code> to <code>"int"</code>.
	 *  A value of -1 means it is ignored.
	 *
	 *  @default -1
		 */
		public function get precision () : Object;
		/**
		 *  @private
		 */
		public function set precision (value:Object) : void;

		/**
		 *  The character used to separate thousands
	 *  in the whole part of the number.
	 *  Cannot be a digit and must be distinct from the
     *  <code>decimalSeparator</code>.
	 *
	 *  @default ","
		 */
		public function get thousandsSeparator () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparator (value:String) : void;

		/**
		 *  Error message when the decimal separator character occurs more than once.
	 *
	 *  @default "The decimal separator can occur only once."
		 */
		public function get decimalPointCountError () : String;
		/**
		 *  @private
		 */
		public function set decimalPointCountError (value:String) : void;

		/**
		 *  Error message when the value exceeds the <code>maxValue</code> property.
	 *
	 *  @default "The number entered is too large."
		 */
		public function get exceedsMaxError () : String;
		/**
		 *  @private
		 */
		public function set exceedsMaxError (value:String) : void;

		/**
		 *  Error message when the number must be an integer, as defined 
     * by the <code>domain</code> property.
	 *
	 *  @default "The number must be an integer."
		 */
		public function get integerError () : String;
		/**
		 *  @private
		 */
		public function set integerError (value:String) : void;

		/**
		 *  Error message when the value contains invalid characters.
	 *
	 *  @default The input contains invalid characters."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;

		/**
		 *  Error message when the value contains invalid format characters, which means that 
     *  it contains a digit or minus sign (-) as a separator character, 
     *  or it contains two or more consecutive separator characters.
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
		 *  Error message when the value is negative and the 
     *  <code>allowNegative</code> property is <code>false</code>.
	 *
	 *  @default "The amount may not be negative."
		 */
		public function get negativeError () : String;
		/**
		 *  @private
		 */
		public function set negativeError (value:String) : void;

		/**
		 *  Error message when the value has a precision that exceeds the value defined 
     *  by the precision property.
	 *
	 *  @default "The amount entered has too many digits beyond the decimal point."
		 */
		public function get precisionError () : String;
		/**
		 *  @private
		 */
		public function set precisionError (value:String) : void;

		/**
		 *  Error message when the thousands separator is in the wrong location.
	 *
	 *  @default "The thousands separator must be followed by three digits."
		 */
		public function get separationError () : String;
		/**
		 *  @private
		 */
		public function set separationError (value:String) : void;

		/**
		 *  Convenience method for calling a validator
	 *  from within a custom validation function.
	 *  Each of the standard Flex validators has a similar convenience method.
	 *
	 *  @param validator The NumberValidator instance.
	 *
	 *  @param value A field to validate.
	 *
     *  @param baseField Text representation of the subfield
	 *  specified in the <code>value</code> parameter.
	 *  For example, if the <code>value</code> parameter specifies value.number,
	 *  the <code>baseField</code> value is "number".
	 *
	 *  @return An Array of ValidationResult objects, with one ValidationResult 
	 *  object for each field examined by the validator. 
	 *
	 *  @see mx.validators.ValidationResult
		 */
		public static function validateNumber (validator:NumberValidator, value:Object, baseField:String) : Array;

		/**
		 *  Constructor.
		 */
		public function NumberValidator ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Override of the base class <code>doValidation()</code> method 
     *  to validate a number.
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
