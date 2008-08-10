/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class DateValidator extends Validator {
		/**
		 * The set of formatting characters allowed for separating
		 *  the month, day, and year values.
		 */
		public function get allowedFormatChars():String;
		public function set allowedFormatChars(value:String):void;
		/**
		 * The component that listens for the validation result
		 *  for the day subfield.
		 *  If none is specified, use the value specified
		 *  for the daySource property.
		 */
		public function get dayListener():IValidatorListener;
		public function set dayListener(value:IValidatorListener):void;
		/**
		 * Name of the day property to validate.
		 *  This property is optional, but if you specify the
		 *  daySource property, you should also set this property.
		 */
		public var dayProperty:String;
		/**
		 * Object that contains the value of the day field.
		 *  If you specify a value for this property, you must also
		 *  specify a value for the dayProperty property.
		 *  Do not use this property if you set the source
		 *  and property properties.
		 */
		public function get daySource():Object;
		public function set daySource(value:Object):void;
		/**
		 * Error message when the inputFormat property
		 *  is not in the correct format.
		 */
		public function get formatError():String;
		public function set formatError(value:String):void;
		/**
		 * The date format to validate the value against.
		 *  "MM" is the month, "DD" is the day, and "YYYY" is the year.
		 *  This String is case-sensitive.
		 */
		public function get inputFormat():String;
		public function set inputFormat(value:String):void;
		/**
		 * Error message when there are invalid characters in the date.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * The component that listens for the validation result
		 *  for the month subfield.
		 *  If none is specified, use the value specified
		 *  for the monthSource property.
		 */
		public function get monthListener():IValidatorListener;
		public function set monthListener(value:IValidatorListener):void;
		/**
		 * Name of the month property to validate.
		 *  This property is optional, but if you specify the
		 *  monthSource property, you should also set this property.
		 */
		public var monthProperty:String;
		/**
		 * Object that contains the value of the month field.
		 *  If you specify a value for this property, you must also specify
		 *  a value for the monthProperty property.
		 *  Do not use this property if you set the source
		 *  and property properties.
		 */
		public function get monthSource():Object;
		public function set monthSource(value:Object):void;
		/**
		 * Determines how to validate the value.
		 *  If set to true, the validator evaluates the value
		 *  as a String, unless the value has a month,
		 *  day, or year property.
		 *  If false, the validator evaluates the value
		 *  as a Date object.
		 */
		public function get validateAsString():Object;
		public function set validateAsString(value:Object):void;
		/**
		 * Error message when the day is invalid.
		 */
		public function get wrongDayError():String;
		public function set wrongDayError(value:String):void;
		/**
		 * Error message when the length of the date
		 *  doesn't match that of the inputFormat property.
		 */
		public function get wrongLengthError():String;
		public function set wrongLengthError(value:String):void;
		/**
		 * Error message when the month is invalid.
		 */
		public function get wrongMonthError():String;
		public function set wrongMonthError(value:String):void;
		/**
		 * Error message when the year is invalid.
		 */
		public function get wrongYearError():String;
		public function set wrongYearError(value:String):void;
		/**
		 * The component that listens for the validation result
		 *  for the year subfield.
		 *  If none is specified, use the value specified
		 *  for the yearSource property.
		 */
		public function get yearListener():IValidatorListener;
		public function set yearListener(value:IValidatorListener):void;
		/**
		 * Name of the year property to validate.
		 *  This property is optional, but if you specify the
		 *  yearSource property, you should also set this property.
		 */
		public var yearProperty:String;
		/**
		 * Object that contains the value of the year field.
		 *  If you specify a value for this property, you must also specify
		 *  a value for the yearProperty property.
		 *  Do not use this property if you set the source
		 *  and property properties.
		 */
		public function get yearSource():Object;
		public function set yearSource(value:Object):void;
		/**
		 * Constructor.
		 */
		public function DateValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a date.
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
		 * @param validator         <DateValidator> The DateValidator instance.
		 * @param value             <Object> A field to validate.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter
		 *                            specifies value.date, the baseField value is "date".
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validateDate(validator:DateValidator, value:Object, baseField:String):Array;
	}
}
