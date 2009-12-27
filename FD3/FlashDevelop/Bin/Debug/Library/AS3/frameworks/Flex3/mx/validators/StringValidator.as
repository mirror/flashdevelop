package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.utils.StringUtil;

include "../core/Version.as"
	/**
	 *  The StringValidator class validates that the length of a String 
 *  is within a specified range. 
 *  
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:StringValidator&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and add the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:StringValidator
 *    maxLength="NaN" 
 *    minLength="NaN" 
 *    tooLongError="This string is longer than the maximum allowed length. This must be less than {0} characters long." 
 *    tooShortError="This string is shorter than the minimum allowed length. This must be at least {0} characters long." 
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/StringValidatorExample.mxml
	 */
	public class StringValidator extends Validator
	{
		/**
		 *  @private
	 *  Storage for the maxLength property.
		 */
		private var _maxLength : Object;
		/**
		 *  @private
		 */
		private var maxLengthOverride : Object;
		/**
		 *  @private
	 *  Storage for the minLength property.
		 */
		private var _minLength : Object;
		/**
		 *  @private
		 */
		private var minLengthOverride : Object;
		/**
		 *  @private
	 *  Storage for the tooLongError property.
		 */
		private var _tooLongError : String;
		/**
		 *  @private
		 */
		private var tooLongErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the tooShortError property.
		 */
		private var _tooShortError : String;
		/**
		 *  @private
		 */
		private var tooShortErrorOverride : String;

		/**
		 *  Maximum length for a valid String. 
	 *  A value of NaN means this property is ignored.
	 *
	 *  @default NaN
		 */
		public function get maxLength () : Object;
		/**
		 *  @private
		 */
		public function set maxLength (value:Object) : void;

		/**
		 *  Minimum length for a valid String.
	 *  A value of NaN means this property is ignored.
	 *
	 *  @default NaN
		 */
		public function get minLength () : Object;
		/**
		 *  @private
		 */
		public function set minLength (value:Object) : void;

		/**
		 *  Error message when the String is longer
	 *  than the <code>maxLength</code> property.
	 *
	 *  @default "This string is longer than the maximum allowed length. This must be less than {0} characters long."
		 */
		public function get tooLongError () : String;
		/**
		 *  @private
		 */
		public function set tooLongError (value:String) : void;

		/**
		 *  Error message when the string is shorter
	 *  than the <code>minLength</code> property.
	 *
	 *  @default "This string is shorter than the minimum allowed length. This must be at least {0} characters long."
		 */
		public function get tooShortError () : String;
		/**
		 *  @private
		 */
		public function set tooShortError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.
	 *  Each of the standard Flex validators has a similar convenience method.
	 *
	 *  @param validator The StringValidator instance.
	 *
	 *  @param value A field to validate.
	 *
	 *  @param baseField Text representation of the subfield
	 *  specified in the <code>value</code> parameter.
	 *  For example, if the <code>value</code> parameter specifies
	 *  value.mystring, the <code>baseField</code> value
	 *  is <code>"mystring"</code>.
     *
	 *  @return An Array of ValidationResult objects, with one
	 *  ValidationResult  object for each field examined by the validator. 
	 *
	 *  @see mx.validators.ValidationResult
		 */
		public static function validateString (validator:StringValidator, value:Object, baseField:String = null) : Array;

		/**
		 *  Constructor.
		 */
		public function StringValidator ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Override of the base class <code>doValidation()</code> method
     *  to validate a String.
     *
	 *  <p>You do not call this method directly;
	 *  Flex calls it as part of performing a validation.
	 *  If you create a custom Validator class, you must implement this method.</p>
	 *
     *  @param value Object to validate.
     *
	 *  @return An Array of ValidationResult objects, with one ValidationResult 
	 *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
	}
}
