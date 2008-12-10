package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.validators.IValidatorListener;

	/**
	 *  The CreditCardValidator class validates that a credit card number *  is the correct length, has the correct prefix, and passes *  the Luhn mod10 algorithm for the specified card type.  *  This validator does not check whether the credit card *  is an actual active credit card account. * *  <p>You can specify the input to the CreditCardValidator in two ways:</p> *  <ul> *    <li>Use the <code>cardNumberSource</code> and *    <code>cardNumberProperty</code> properties to specify *    the location of the credit card number, and the  *    <code>cardTypeSource</code> and <code>cardTypeProperty</code> properties *    to specify the location of the credit card type to validate.</li> *    <li>Use the <code>source</code> and  *    <code>property</code> properties to specify a single Object. *    The Object should contain the following fields: *    <ul> *        <li><code>cardType</code> - Specifies the type *        of credit card being validated.  *         <p>In MXML, use the values: <code>"American Express"</code>,  *            <code>"Diners Club"</code>, <code>"Discover"</code>,  *            <code>"MasterCard"</code>, or <code>"Visa"</code>.</p> *         <p>In ActionScript, use the static constants *            <code>CreditCardValidatorCardType.MASTER_CARD</code>,  *            <code>CreditCardValidatorCardType.VISA</code>, or *            <code>CreditCardValidatorCardType.AMERICAN_EXPRESS</code>  *            <code>CreditCardValidatorCardType.DISCOVER</code>, or *            <code>CreditCardValidatorCardType.DINERS_CLUB</code>.</p> *          </li> *       <li><code>cardNumber</code> - Specifies the number of the card *       being validated.</li> *     </ul> *    </li> *  </ul> *   *  <p>To perform the validation, it uses the following guidelines:</p> *  <p>Length:</p> *  <ol> *    <li>Visa: 13 or 16 digits</li>  *    <li>MasterCard: 16 digits</li>  *    <li>Discover: 16 digits</li>  *    <li>American Express: 15 digits</li>  *    <li>Diners Club: 14 digits or 16 digits if it also functions as MasterCard</li> *  </ol> *  Prefix: *  <ol> *    <li>Visa: 4</li>  *    <li>MasterCard: 51 to 55</li> *    <li>Discover: 6011</li> *    <li>American Express: 34 or 37</li> *    <li>Diners Club: 300 to 305, 36 or 38, 51 to 55</li> *  </ol> *   *  @mxml * *  <p>The <code>&lt;mx:CreditCardValidator&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:CreditCardValidator *    allowedFormatChars=" -"  *    cardNumberListener="<i>Object specified by cardNumberSource</i>" *    cardNumberProperty="<i>No default</i>" *    cardNumberSource="<i>No default</i>" *    cardTypeListener="<i>Object specified by cardTypeSource</i>" *    cardTypeProperty="<i>No default</i>" *    cardTypeSource="<i>No default</i>" *    invalidCharError= "Invalid characters in your credit card number. (Enter numbers only.)" *    invalidNumberError="The credit card number is invalid."  *    noNumError="No credit card number is specified." *    noTypeError="No credit card type is specified or the type is not valid."  *    wrongLengthError="Your credit card number contains the wrong number of digits."  *    wrongTypeError="Incorrect card type is specified."  *  /&gt; *  </pre> * *  @see mx.validators.CreditCardValidatorCardType *   *  @includeExample examples/CreditCardValidatorExample.mxml
	 */
	public class CreditCardValidator extends Validator
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
		 *  @private	 *  Storage for the cardNumberListener property.
		 */
		private var _cardNumberListener : IValidatorListener;
		/**
		 *  Name of the card number property to validate. 	 *  This attribute is optional, but if you specify	 *  the <code>cardNumberSource</code> property, 	 *  you should also set this property.
		 */
		public var cardNumberProperty : String;
		/**
		 *  @private	 *  Storage for the cardNumberSource property.
		 */
		private var _cardNumberSource : Object;
		/**
		 *  @private	 *  Storage for the cardTypeListener property.
		 */
		private var _cardTypeListener : IValidatorListener;
		/**
		 *  Name of the card type property to validate. 	 *  This attribute is optional, but if you specify the	 *  <code>cardTypeSource</code> property,	 *  you should also set this property.	 *     *  <p>In MXML, valid values are:</p>     *  <ul>     *    <li><code>"American Express"</code></li>     *    <li><code>"Diners Club"</code></li>     *    <li><code>"Discover"</code></li>     *    <li><code>"MasterCard"</code></li>     *    <li><code>"Visa"</code></li>     *  </ul>	 *	 *  <p>In ActionScript, you can use the following constants to set this property:</p>	 *  <p><code>CreditCardValidatorCardType.AMERICAN_EXPRESS</code>, 	 *  <code>CreditCardValidatorCardType.DINERS_CLUB</code>,	 *  <code>CreditCardValidatorCardType.DISCOVER</code>, 	 *  <code>CreditCardValidatorCardType.MASTER_CARD</code>, and 	 *  <code>CreditCardValidatorCardType.VISA</code>.</p>	 *	 *  @see mx.validators.CreditCardValidatorCardType
		 */
		public var cardTypeProperty : String;
		/**
		 *  @private	 *  Storage for the cardTypeSource property.
		 */
		private var _cardTypeSource : Object;
		/**
		 *  @private	 *  Storage for the invalidCharError property.
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private	 *  Storage for the invalidNumberError property.
		 */
		private var _invalidNumberError : String;
		/**
		 *  @private
		 */
		private var invalidNumberErrorOverride : String;
		/**
		 *  @private	 *  Storage for the noNumError property.
		 */
		private var _noNumError : String;
		/**
		 *  @private
		 */
		private var noNumErrorOverride : String;
		/**
		 *  @private	 *  Storage for the noTypeError property.
		 */
		private var _noTypeError : String;
		/**
		 *  @private
		 */
		private var noTypeErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongLengthError property.
		 */
		private var _wrongLengthError : String;
		/**
		 *  @private
		 */
		private var wrongLengthErrorOverride : String;
		/**
		 *  @private	 *  Storage for the wrongTypeError property.
		 */
		private var _wrongTypeError : String;
		/**
		 *  @private
		 */
		private var wrongTypeErrorOverride : String;

		/**
		 *  @private	 *  Returns either the listener or the source	 *  for the cardType and cardNumber subfields.
		 */
		protected function get actualListeners () : Array;
		/**
		 *  The set of formatting characters allowed in the	 *  <code>cardNumber</code> field.	 *	 *  @default " -" (space and dash)
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  The component that listens for the validation result	 *  for the card number subfield. 	 *  If none is specified, use the value specified	 *  to the <code>cardNumberSource</code> property.
		 */
		public function get cardNumberListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set cardNumberListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the card number field.	 *  If you specify a value for this property, you must also specify	 *  a value for the <code>cardNumberProperty</code> property. 	 *  Do not use this property if you set the <code>source</code> 	 *  and <code>property</code> properties.
		 */
		public function get cardNumberSource () : Object;
		/**
		 *  @private
		 */
		public function set cardNumberSource (value:Object) : void;
		/**
		 *  The component that listens for the validation result	 *  for the card type subfield. 	 *  If none is specified, then use the value	 *  specified to the <code>cardTypeSource</code> property.
		 */
		public function get cardTypeListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set cardTypeListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the card type field.	 *  If you specify a value for this property, you must also specify	 *  a value for the <code>cardTypeProperty</code> property. 	 *  Do not use this property if you set the <code>source</code> 	 *  and <code>property</code> properties.
		 */
		public function get cardTypeSource () : Object;
		/**
		 *  @private
		 */
		public function set cardTypeSource (value:Object) : void;
		/**
		 *  Error message when the <code>cardNumber</code> field contains invalid characters.	 *	 *  @default "Invalid characters in your credit card number. (Enter numbers only.)"
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the credit card number is invalid.	 *	 *  @default "The credit card number is invalid."
		 */
		public function get invalidNumberError () : String;
		/**
		 *  @private
		 */
		public function set invalidNumberError (value:String) : void;
		/**
		 *  Error message when the <code>cardNumber</code> field is empty.	 *	 *  @default "No credit card number is specified."
		 */
		public function get noNumError () : String;
		/**
		 *  @private
		 */
		public function set noNumError (value:String) : void;
		/**
		 *  Error message when the <code>cardType</code> field is blank.	 *	 *  @default "No credit card type is specified or the type is not valid."
		 */
		public function get noTypeError () : String;
		/**
		 *  @private
		 */
		public function set noTypeError (value:String) : void;
		/**
		 *  Error message when the <code>cardNumber</code> field contains the wrong	 *  number of digits for the specified credit card type.	 *	 *  @default "Your credit card number contains the wrong number of digits."
		 */
		public function get wrongLengthError () : String;
		/**
		 *  @private
		 */
		public function set wrongLengthError (value:String) : void;
		/**
		 *  Error message the <code>cardType</code> field contains an invalid credit card type. 	 *  You should use the predefined constants for the <code>cardType</code> field:	 *  <code>CreditCardValidatorCardType.MASTER_CARD</code>,	 *  <code>CreditCardValidatorCardType.VISA</code>, 	 *  <code>CreditCardValidatorCardType.AMERICAN_EXPRESS</code>,	 *  <code>CreditCardValidatorCardType.DISCOVER</code>, or 	 *  <code>CreditCardValidatorCardType.DINERS_CLUB</code>.	 *	 *  @default "Incorrect card type is specified."
		 */
		public function get wrongTypeError () : String;
		/**
		 *  @private
		 */
		public function set wrongTypeError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.	 *  Each of the standard Flex validators has a similar convenience method.	 *	 *  @param validator The CreditCardValidator instance.	 *	 *  @param value A field to validate, which must contain	 *  the following fields:	 *  <ul>	 *    <li><code>cardType</code> - Specifies the type of credit card being validated. 	 *    Use the static constants	 *    <code>CreditCardValidatorCardType.MASTER_CARD</code>, 	 *    <code>CreditCardValidatorCardType.VISA</code>,	 *    <code>CreditCardValidatorCardType.AMERICAN_EXPRESS</code>,	 *    <code>CreditCardValidatorCardType.DISCOVER</code>, or	 *    <code>CreditCardValidatorCardType.DINERS_CLUB</code>.</li>	 *    <li><code>cardNumber</code> - Specifies the number of the card	 *    being validated.</li></ul>	 *	 *  @param baseField Text representation of the subfield	 *  specified in the value parameter. 	 *  For example, if the <code>value</code> parameter	 *  specifies value.date, the <code>baseField</code> value is "date".	 *	 *  @return An Array of ValidationResult objects, with one ValidationResult 	 *  object for each field examined by the validator. 	 *	 *  @see mx.validators.ValidationResult
		 */
		public static function validateCreditCard (validator:CreditCardValidator, value:Object, baseField:String) : Array;
		/**
		 *  Constructor.
		 */
		public function CreditCardValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method	 *  to validate a credit card number.	 *	 *  <p>You do not call this method directly;	 *  Flex calls it as part of performing a validation.	 *  If you create a custom Validator class, you must implement this method. </p>	 *	 *  @param value an Object to validate.     *	 *  @return An Array of ValidationResult objects, with one ValidationResult 	 *  object for each field examined by the validator.
		 */
		protected function doValidation (value:Object) : Array;
		/**
		 *  @private	 *  Grabs the data for the validator from two different sources
		 */
		protected function getValueFromSource () : Object;
	}
}
