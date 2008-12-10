package mx.validators
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The ZipCodeValidator class validates that a String *  has the correct length and format for a five-digit ZIP code, *  a five-digit+four-digit United States ZIP code, or Canadian postal code. *   *  @mxml * *  <p>The <code>&lt;mx:ZipCodeValidator&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:ZipCodeValidator *    allowedFormatChars=" -"  *    domain="US Only | US or Canada | Canada Only" *    invalidCharError="The ZIP code contains invalid characters."  *    invalidDomainError="The domain parameter is invalid. It must be either 'US Only', 'Canada Only', or 'US or Canada'."  *    wrongCAFormatError="The Canadian postal code must be formatted 'A1B 2C3'."  *    wrongLengthError="The ZIP code must be 5 digits or 5+4 digits."  *    wrongUSFormatError="The ZIP+4 code must be formatted '12345-6789'."  *  /&gt; *  </pre> *   *  @see mx.validators.ZipCodeValidatorDomainType *  *  @includeExample examples/ZipCodeValidatorExample.mxml
	 */
	public class ZipCodeValidator extends Validator
	{
		/**
		 *  @private
		 */
		private static const DOMAIN_US : uint = 1;
		/**
		 *  @private
		 */
		private static const DOMAIN_US_OR_CANADA : uint = 2;
		/**
		 * @private
		 */
		private static const DOMAIN_CANADA : uint = 3;
		/**
		 *  @private
		 */
		private var _allowedFormatChars : String;
		/**
		 *  @private
		 */
		private var allowedFormatCharsOverride : String;
		/**
		 *  @private     *  Storage for the domain property.
		 */
		private var _domain : String;
		/**
		 *  @private
		 */
		private var domainOverride : String;
		/**
		 *  @private     *  Storage for the invalidCharError property.
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private     *  Storage for the invalidDomainError property.
		 */
		private var _invalidDomainError : String;
		/**
		 *  @private
		 */
		private var invalidDomainErrorOverride : String;
		/**
		 *  @private     *  Storage for the wrongCAFormatError property.
		 */
		private var _wrongCAFormatError : String;
		/**
		 *  @private
		 */
		private var wrongCAFormatErrorOverride : String;
		/**
		 *  @private     *  Storage for the wrongLengthError property.
		 */
		private var _wrongLengthError : String;
		/**
		 *  @private
		 */
		private var wrongLengthErrorOverride : String;
		/**
		 *  @private     *  Storage for the wrongUSFormatError property.
		 */
		private var _wrongUSFormatError : String;
		/**
		 *  @private
		 */
		private var wrongUSFormatErrorOverride : String;

		/**
		 *  The set of formatting characters allowed in the ZIP code.     *  This can not have digits or alphabets [a-z A-Z].     *     *  @default " -".
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  Type of ZIP code to check.     *  In MXML, valid values are <code>"US or Canada"</code>,      *  <code>"US Only"</code> and <code>"Canada Only"</code>.     *     *  <p>In ActionScript, you can use the following constants to set this property:      *  <code>ZipCodeValidatorDomainType.US_ONLY</code>,      *  <code>ZipCodeValidatorDomainType.US_OR_CANADA</code>, or     *  <code>ZipCodeValidatorDomainType.CANADA_ONLY</code>.</p>     *     *  @default ZipCodeValidatorDomainType.US_ONLY
		 */
		public function get domain () : String;
		/**
		 *  @private
		 */
		public function set domain (value:String) : void;
		/**
		 *  Error message when the ZIP code contains invalid characters.     *     *  @default "The ZIP code contains invalid characters."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the <code>domain</code> property contains an invalid value.     *     *  @default "The domain parameter is invalid. It must be either 'US Only' or 'US or Canada'."
		 */
		public function get invalidDomainError () : String;
		/**
		 *  @private
		 */
		public function set invalidDomainError (value:String) : void;
		/**
		 *  Error message for an invalid Canadian postal code.     *     *  @default "The Canadian postal code must be formatted 'A1B 2C3'."
		 */
		public function get wrongCAFormatError () : String;
		/**
		 *  @private
		 */
		public function set wrongCAFormatError (value:String) : void;
		/**
		 *  Error message for an invalid US ZIP code.     *     *  @default "The ZIP code must be 5 digits or 5+4 digits."
		 */
		public function get wrongLengthError () : String;
		/**
		 *  @private
		 */
		public function set wrongLengthError (value:String) : void;
		/**
		 *  Error message for an incorrectly formatted ZIP code.     *     *  @default "The ZIP+4 code must be formatted '12345-6789'."
		 */
		public function get wrongUSFormatError () : String;
		/**
		 *  @private
		 */
		public function set wrongUSFormatError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.     *  Each of the standard Flex validators has a similar convenience method.     *     *  @param validator The ZipCodeValidator instance.     *     *  @param value A field to validate.     *     *  @param baseField Text representation of the subfield     *  specified in the <code>value</code> parameter.     *  For example, if the <code>value</code> parameter specifies value.zipCode,     *  the <code>baseField</code> value is <code>"zipCode"</code>.     *     *  @return An Array of ValidationResult objects, with one ValidationResult      *  object for each field examined by the validator.      *     *  @see mx.validators.ValidationResult     *
		 */
		public static function validateZipCode (validator:ZipCodeValidator, value:Object, baseField:String) : Array;
		/**
		 *  @private
		 */
		private function validateUSCode (zip:String, containsLetters:Boolean) : Boolean;
		/**
		 *  @private
		 */
		private function validateCACode (zip:String, containsLetters:Boolean) : Boolean;
		/**
		 *  Constructor.
		 */
		public function ZipCodeValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method     *  to validate a ZIP code.     *     *  <p>You do not call this method directly;     *  Flex calls it as part of performing a validation.     *  If you create a custom Validator class, you must implement this method. </p>     *     *  @param value Object to validate.     *     *  @return An Array of ValidationResult objects, with one ValidationResult      *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
	}
}
