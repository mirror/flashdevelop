package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The PhoneNumberValidator class validates that a string *  is a valid phone number. *  A valid phone number contains at least 10 digits, *  plus additional formatting characters. *  The validator does not check if the phone number *  is an actual active phone number. *   *  @mxml * *  <p>The <code>&lt;mx:PhoneNumberValidator&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:PhoneNumberValidator  *    allowedFormatChars="()- .+"  *    invalidCharError="Your telephone number contains invalid characters." *    wrongLengthError="Your telephone number must contain at least 10 digits." *  /&gt; *  </pre> *   *  @includeExample examples/PhoneNumberValidatorExample.mxml
	 */
	public class PhoneNumberValidator extends Validator
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
		 *  @private	 *  Storage for the invalidCharError property.
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongLengthError property.
		 */
		private var _wrongLengthError : String;
		/**
		 *  @private
		 */
		private var wrongLengthErrorOverride : String;

		/**
		 *  The set of allowable formatting characters.	 *	 *  @default "()- .+"
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  Error message when the value contains invalid characters.	 *	 *  @default "Your telephone number contains invalid characters."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the value has fewer than 10 digits.	 *	 *  @default "Your telephone number must contain at least 10 digits."
		 */
		public function get wrongLengthError () : String;
		/**
		 *  @private
		 */
		public function set wrongLengthError (value:String) : void;

		/**
		 *  Convenience method for calling a validator	 *  from within a custom validation function.	 *  Each of the standard Flex validators has a similar convenience method.	 *	 *  @param validator The PhoneNumberValidator instance.	 *	 *  @param value A field to validate.	 *	 *  @param baseField Text representation of the subfield	 *  specified in the <code>value</code> parameter.	 *  For example, if the <code>value</code> parameter specifies value.phone,	 *  the <code>baseField</code> value is "phone".	 *	 *  @return An Array of ValidationResult objects, with one ValidationResult 	 *  object for each field examined by the validator. 	 *	 *  @see mx.validators.ValidationResult
		 */
		public static function validatePhoneNumber (validator:PhoneNumberValidator, value:Object, baseField:String) : Array;
		/**
		 *  Constructor.
		 */
		public function PhoneNumberValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method     *  to validate a phone number.     *	 *  <p>You do not typically call this method directly;	 *  Flex calls it as part of performing a validation.	 *  If you create a custom Validator class, you must implement this method. </p>	 *     *  @param value Object to validate.     *	 *  @return An Array of ValidationResult objects, with one ValidationResult 	 *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
	}
}
