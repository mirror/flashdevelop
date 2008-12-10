package mx.validators
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The DateValidator class validates that a String, Date, or Object contains a  *  proper date and matches a specified format. Users can enter a single  *  digit or two digits for month, day, and year.  *  By default, the validator ensures the following formats: * *  <ul> *    <li>The month is between 1 and 12 (or 0-11 for <code>Date</code> objects)</li> *    <li>The day is between 1 and 31</li> *    <li>The year is a number</li> *  </ul> * *  <p>You can specify the date in the DateValidator class in two ways:</p> *  <ul> *    <li>Single String containing the date - Use the <code>source</code> *    and <code>property</code> properties to specify the String. *    The String can contain digits and the formatting characters *    specified by the <code>allowedFormatChars</code> property, *    which include the "/\-. " characters.  *    By default, the input format of the date in a String field *    is "MM/DD/YYYY" where "MM" is the month, "DD" is the day, *    and "YYYY" is the year.  *    You can use the <code>inputFormat</code> property *    to specify a different format.</li> * 	  <li><code>Date</code> object.</li> *    <li>Object or multiple fields containing the day, month, and year.   *    Use all of the following properties to specify the day, month, *    and year inputs: <code>daySource</code>, <code>dayProperty</code>, *    <code>monthSource</code>, <code>monthProperty</code>, *    <code>yearSource</code>, and <code>yearProperty</code>.</li> *  </ul> *   *  @mxml * *  <p>The <code>&lt;mx:DateValidator&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p>   *   *  <pre> *  &lt;mx:DateValidator  *    allowedFormatChars="/\-. "  *    dayListener="<i>Object specified by daySource</i>" *    dayProperty="<i>No default</i>" *    daySource="<i>No default</i>" *    formatError= "Configuration error: Incorrect formatting string."  *    inputFormat="MM/DD/YYYY"  *    invalidCharError="The date contains invalid characters." *    monthListener="<i>Object specified by monthSource</i>" *    monthProperty="<i>No default</i>" *    monthSource="<i>No default</i>" *    validateAsString="true|false" *    wrongDayError="Enter a valid day for the month." *    wrongLengthError="Type the date in the format <i>inputFormat</i>."  *    wrongMonthError="Enter a month between 1 and 12." *    wrongYearError="Enter a year between 0 and 9999." *    yearListener="<i>Object specified by yearSource</i>" *    yearProperty="<i>No default</i>" *    yearSource="<i>No default</i>" *  /&gt; *  </pre> *   *  @includeExample examples/DateValidatorExample.mxml
	 */
	public class DateValidator extends Validator
	{
		/**
		 *  @private	 *  Storage for the allowedFormatChars property.
		 */
		private var _allowedFormatChars : String;
		/**
		 *  @private
		 */
		private var allowedFormatCharsOverride : String;
		/**
		 *  @private	 *  Storage for the dayListener property.
		 */
		private var _dayListener : IValidatorListener;
		/**
		 *  Name of the day property to validate. 	 *  This property is optional, but if you specify the	 *  <code>daySource</code> property, you should also set this property.
		 */
		public var dayProperty : String;
		/**
		 *  @private	 *  Storage for the daySource property.
		 */
		private var _daySource : Object;
		/**
		 *  @private	 *  Storage for the inputFormat property.
		 */
		private var _inputFormat : String;
		/**
		 *  @private
		 */
		private var inputFormatOverride : String;
		/**
		 *  @private	 *  Storage for the monthListener property.
		 */
		private var _monthListener : IValidatorListener;
		/**
		 *  Name of the month property to validate. 	 *  This property is optional, but if you specify the	 *  <code>monthSource</code> property, you should also set this property.
		 */
		public var monthProperty : String;
		/**
		 *  @private	 *  Storage for the monthSource property.
		 */
		private var _monthSource : Object;
		/**
		 *  @private	 *  Storage for the validateAsString property.
		 */
		private var _validateAsString : Object;
		/**
		 *  @private
		 */
		private var validateAsStringOverride : Object;
		/**
		 *  @private	 *  Storage for the yearListener property.
		 */
		private var _yearListener : IValidatorListener;
		/**
		 *  Name of the year property to validate. 	 *  This property is optional, but if you specify the	 *  <code>yearSource</code> property, you should also set this property.
		 */
		public var yearProperty : String;
		/**
		 *  @private	 *  Storage for the yearSource property.
		 */
		private var _yearSource : Object;
		/**
		 *  @private	 *  Storage for the formatError property.
		 */
		private var _formatError : String;
		/**
		 *  @private
		 */
		private var formatErrorOverride : String;
		/**
		 *  @private	 *  Storage for the invalidCharError property.
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongDayError property.
		 */
		private var _wrongDayError : String;
		/**
		 *  @private
		 */
		private var wrongDayErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongLengthError property.
		 */
		private var _wrongLengthError : String;
		/**
		 *  @private
		 */
		private var wrongLengthErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongMonthError property.
		 */
		private var _wrongMonthError : String;
		/**
		 *  @private
		 */
		private var wrongMonthErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongYearError property.
		 */
		private var _wrongYearError : String;
		/**
		 *  @private
		 */
		private var wrongYearErrorOverride : String;

		/**
		 *  @private	 *  Returns either the listener or the source	 *  for the day, month and year subfields.
		 */
		protected function get actualListeners () : Array;
		/**
		 *  The set of formatting characters allowed for separating	 *  the month, day, and year values.	 *	 *  @default "/\-. "
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  The component that listens for the validation result	 *  for the day subfield.	 *  If none is specified, use the value specified	 *  for the <code>daySource</code> property.
		 */
		public function get dayListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set dayListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the day field.	 *  If you specify a value for this property, you must also	 *  specify a value for the <code>dayProperty</code> property. 	 *  Do not use this property if you set the <code>source</code> 	 *  and <code>property</code> properties.
		 */
		public function get daySource () : Object;
		/**
		 *  @private
		 */
		public function set daySource (value:Object) : void;
		/**
		 *  The date format to validate the value against.	 *  "MM" is the month, "DD" is the day, and "YYYY" is the year.	 *  This String is case-sensitive.	 *	 *  @default "MM/DD/YYYY"
		 */
		public function get inputFormat () : String;
		/**
		 *  @private
		 */
		public function set inputFormat (value:String) : void;
		/**
		 *  The component that listens for the validation result	 *  for the month subfield. 	 *  If none is specified, use the value specified	 *  for the <code>monthSource</code> property.
		 */
		public function get monthListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set monthListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the month field.	 *  If you specify a value for this property, you must also specify	 *  a value for the <code>monthProperty</code> property. 	 *  Do not use this property if you set the <code>source</code> 	 *  and <code>property</code> properties.
		 */
		public function get monthSource () : Object;
		/**
		 *  @private
		 */
		public function set monthSource (value:Object) : void;
		/**
		 *  Determines how to validate the value.	 *  If set to <code>true</code>, the validator evaluates the value	 *  as a String, unless the value has a <code>month</code>,	 *  <code>day</code>, or <code>year</code> property.	 *  If <code>false</code>, the validator evaluates the value	 *  as a Date object. 	 *	 *  @default true
		 */
		public function get validateAsString () : Object;
		/**
		 *  @private
		 */
		public function set validateAsString (value:Object) : void;
		/**
		 *  The component that listens for the validation result	 *  for the year subfield. 	 *  If none is specified, use the value specified	 *  for the <code>yearSource</code> property.
		 */
		public function get yearListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set yearListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the year field.	 *  If you specify a value for this property, you must also specify	 *  a value for the <code>yearProperty</code> property. 	 *  Do not use this property if you set the <code>source</code> 	 *  and <code>property</code> properties.
		 */
		public function get yearSource () : Object;
		/**
		 *  @private
		 */
		public function set yearSource (value:Object) : void;
		/**
		 *  Error message when the <code>inputFormat</code> property	 *  is not in the correct format.	 *	 *  @default "Configuration error: Incorrect formatting string."
		 */
		public function get formatError () : String;
		/**
		 *  @private
		 */
		public function set formatError (value:String) : void;
		/**
		 *  Error message when there are invalid characters in the date.	 *	 *  @default "Invalid characters in your date."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the day is invalid.	 *	 *  @default "Enter a valid day for the month."
		 */
		public function get wrongDayError () : String;
		/**
		 *  @private
		 */
		public function set wrongDayError (value:String) : void;
		/**
		 *  Error message when the length of the date	 *  doesn't match that of the <code>inputFormat</code> property.	 *	 *  @default "Type the date in the format <i>inputFormat</i>."
		 */
		public function get wrongLengthError () : String;
		/**
		 *  @private
		 */
		public function set wrongLengthError (value:String) : void;
		/**
		 *  Error message when the month is invalid.	 *	 *  @default "Enter a month between 1 and 12."
		 */
		public function get wrongMonthError () : String;
		/**
		 *  @private
		 */
		public function set wrongMonthError (value:String) : void;
		/**
		 *  Error message when the year is invalid.	 *	 *  @default "Enter a year between 0 and 9999."
		 */
		public function get wrongYearError () : String;
		/**
		 *  @private
		 */
		public function set wrongYearError (value:String) : void;

		/**
		 *  Convenience method for calling a validator	 *  from within a custom validation function.	 *  Each of the standard Flex validators has a similar convenience method.	 *	 *  @param validator The DateValidator instance.	 *	 *  @param value A field to validate.	 *	 *  @param baseField Text representation of the subfield	 *  specified in the value parameter. 	 *  For example, if the <code>value</code> parameter	 *  specifies value.date, the <code>baseField</code> value is "date".	 *	 *  @return An Array of ValidationResult objects, with one ValidationResult 	 *  object for each field examined by the validator. 	 *	 *  @see mx.validators.ValidationResult
		 */
		public static function validateDate (validator:DateValidator, value:Object, baseField:String) : Array;
		/**
		 *  @private
		 */
		private static function validateFormatString (validator:DateValidator, format:String, baseField:String) : ValidationResult;
		/**
		 *  Constructor.
		 */
		public function DateValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method     *  to validate a date.	 *	 *  <p>You do not call this method directly;	 *  Flex calls it as part of performing a validation.	 *  If you create a custom validator class, you must implement this method. </p>	 *	 *  @param value Either a String or an Object to validate.     *	 *  @return An Array of ValidationResult objects, with one ValidationResult 	 *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
		/**
		 *  @private	 *  Grabs the data for the validator from three different sources.
		 */
		protected function getValueFromSource () : Object;
	}
}
