package mx.validators
{
include "../core/Version.as"
	/**
	 *  The EmailValidator class validates that a String has a single &#64; sign,
 *  a period in the domain name and that the top-level domain suffix has
 *  two, three, four, or six characters.
 *  IP domain names are valid if they are enclosed in square brackets. 
 *  The validator does not check whether the domain and user name
 *  actually exist.
 *
 *  <p>You can use IP domain names if they are enclosed in square brackets; 
 *  for example, myname&#64;[206.132.22.1].
 *  You can use individual IP numbers from 0 to 255.</p>
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:EmailValidator&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:EmailValidator 
 *    invalidCharError="Your e-mail address contains invalid characters."
 *    invalidDomainError= "The domain in your e-mail address is incorrectly formatted." 
 *    invalidIPDomainError="The IP domain in your e-mail address is incorrectly formatted." 
 *    invalidPeriodsInDomainError="The domain in your e-mail address has consecutive periods." 
 *    missingAtSignError="An at sign (&64;) is missing in your e-mail address."
 *    missingPeriodInDomainError="The domain in your e-mail address is missing a period." 
 *    missingUsernameError="The username in your e-mail address is missing." 
 *    tooManyAtSignsError="Your e-mail address contains too many &64; characters."
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/EmailValidatorExample.mxml
	 */
	public class EmailValidator extends Validator
	{
		/**
		 *  @private
		 */
		private static const DISALLOWED_LOCALNAME_CHARS : String;
		/**
		 *  @private
		 */
		private static const DISALLOWED_DOMAIN_CHARS : String;
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
	 *  Storage for the invalidDomainError property.
		 */
		private var _invalidDomainError : String;
		/**
		 *  @private
		 */
		private var invalidDomainErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the invalidIPDomainError property.
		 */
		private var _invalidIPDomainError : String;
		/**
		 *  @private
		 */
		private var invalidIPDomainErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the invalidPeriodsInDomainError property.
		 */
		private var _invalidPeriodsInDomainError : String;
		/**
		 *  @private
		 */
		private var invalidPeriodsInDomainErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the missingAtSignError property.
		 */
		private var _missingAtSignError : String;
		/**
		 *  @private
		 */
		private var missingAtSignErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the missingPeriodInDomainError property.
		 */
		private var _missingPeriodInDomainError : String;
		/**
		 *  @private
		 */
		private var missingPeriodInDomainErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the missingUsernameError property.
		 */
		private var _missingUsernameError : String;
		/**
		 *  @private
		 */
		private var missingUsernameErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the tooManyAtSignsError property.
		 */
		private var _tooManyAtSignsError : String;
		/**
		 *  @private
		 */
		private var tooManyAtSignsErrorOverride : String;

		/**
		 *  Error message when there are invalid characters in the e-mail address.
	 *
	 *  @default "Your e-mail address contains invalid characters."
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;

		/**
		 *  Error message when the suffix (the top level domain)
	 *  is not 2, 3, 4 or 6 characters long.
	 *
	 *  @default "The domain in your e-mail address is incorrectly formatted."
		 */
		public function get invalidDomainError () : String;
		/**
		 *  @private
		 */
		public function set invalidDomainError (value:String) : void;

		/**
		 *  Error message when the IP domain is invalid. The IP domain must be enclosed by square brackets.
	 *
	 *  @default "The IP domain in your e-mail address is incorrectly formatted."
		 */
		public function get invalidIPDomainError () : String;
		/**
		 *  @private
		 */
		public function set invalidIPDomainError (value:String) : void;

		/**
		 *  Error message when there are continuous periods in the domain.
	 *
	 *  @default "The domain in your e-mail address has continous periods."
		 */
		public function get invalidPeriodsInDomainError () : String;
		/**
		 *  @private
		 */
		public function set invalidPeriodsInDomainError (value:String) : void;

		/**
		 *  Error message when there is no at sign in the email address.
	 *
	 *  @default "An at sign (&64;) is missing in your e-mail address."
		 */
		public function get missingAtSignError () : String;
		/**
		 *  @private
		 */
		public function set missingAtSignError (value:String) : void;

		/**
		 *  Error message when there is no period in the domain.
	 *
	 *  @default "The domain in your e-mail address is missing a period."
		 */
		public function get missingPeriodInDomainError () : String;
		/**
		 *  @private
		 */
		public function set missingPeriodInDomainError (value:String) : void;

		/**
		 *  Error message when there is no username.
	 *
	 *  @default "The username in your e-mail address is missing."
		 */
		public function get missingUsernameError () : String;
		/**
		 *  @private
		 */
		public function set missingUsernameError (value:String) : void;

		/**
		 *  Error message when there is more than one at sign in the e-mail address.
	 *  This property is optional. 
	 *
	 *  @default "Your e-mail address contains too many &64; characters."
		 */
		public function get tooManyAtSignsError () : String;
		/**
		 *  @private
		 */
		public function set tooManyAtSignsError (value:String) : void;

		/**
		 *  Convenience method for calling a validator
	 *  from within a custom validation function.
	 *  Each of the standard Flex validators has a similar convenience method.
	 *
	 *  @param validator The EmailValidator instance.
	 *
	 *  @param value A field to validate.
	 *
	 *  @param baseField Text representation of the subfield
	 *  specified in the value parameter.
	 *  For example, if the <code>value</code> parameter specifies value.email,
	 *  the <code>baseField</code> value is "email".
	 *
	 *  @return An Array of ValidationResult objects, with one
	 *  ValidationResult object for each field examined by the validator. 
	 *
	 *  @see mx.validators.ValidationResult
		 */
		public static function validateEmail (validator:EmailValidator, value:Object, baseField:String) : Array;

		/**
		 * Validate a given IP address
	 * 
	 * If IP domain, then must follow [x.x.x.x] format
	 * or for IPv6, then follow [x:x:x:x:x:x:x:x] or [x::x:x:x] or some
	 * IPv4 hybrid, like [::x.x.x.x] or [0:00::192.168.0.1]
	 *
	 * @private
		 */
		private static function isValidIPAddress (ipAddr:String) : Boolean;

		/**
		 *  Constructor.
		 */
		public function EmailValidator ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Override of the base class <code>doValidation()</code> method
     *  to validate an e-mail address.
	 *
	 *  <p>You do not call this method directly;
	 *  Flex calls it as part of performing a validation.
	 *  If you create a custom Validator class, you must implement this method. </p>
	 *
	 *  @param value Either a String or an Object to validate.
     *
	 *  @return An Array of ValidationResult objects, with one ValidationResult 
	 *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
	}
}
