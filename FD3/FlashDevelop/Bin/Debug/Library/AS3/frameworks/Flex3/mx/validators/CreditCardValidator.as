/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class CreditCardValidator extends Validator {
		/**
		 * The set of formatting characters allowed in the
		 *  cardNumber field.
		 */
		public function get allowedFormatChars():String;
		public function set allowedFormatChars(value:String):void;
		/**
		 * The component that listens for the validation result
		 *  for the card number subfield.
		 *  If none is specified, use the value specified
		 *  to the cardNumberSource property.
		 */
		public function get cardNumberListener():IValidatorListener;
		public function set cardNumberListener(value:IValidatorListener):void;
		/**
		 * Name of the card number property to validate.
		 *  This attribute is optional, but if you specify
		 *  the cardNumberSource property,
		 *  you should also set this property.
		 */
		public var cardNumberProperty:String;
		/**
		 * Object that contains the value of the card number field.
		 *  If you specify a value for this property, you must also specify
		 *  a value for the cardNumberProperty property.
		 *  Do not use this property if you set the source
		 *  and property properties.
		 */
		public function get cardNumberSource():Object;
		public function set cardNumberSource(value:Object):void;
		/**
		 * The component that listens for the validation result
		 *  for the card type subfield.
		 *  If none is specified, then use the value
		 *  specified to the cardTypeSource property.
		 */
		public function get cardTypeListener():IValidatorListener;
		public function set cardTypeListener(value:IValidatorListener):void;
		/**
		 * Name of the card type property to validate.
		 *  This attribute is optional, but if you specify the
		 *  cardTypeSource property,
		 *  you should also set this property.
		 */
		public var cardTypeProperty:String;
		/**
		 * Object that contains the value of the card type field.
		 *  If you specify a value for this property, you must also specify
		 *  a value for the cardTypeProperty property.
		 *  Do not use this property if you set the source
		 *  and property properties.
		 */
		public function get cardTypeSource():Object;
		public function set cardTypeSource(value:Object):void;
		/**
		 * Error message when the cardNumber field contains invalid characters.
		 */
		public function get invalidCharError():String;
		public function set invalidCharError(value:String):void;
		/**
		 * Error message when the credit card number is invalid.
		 */
		public function get invalidNumberError():String;
		public function set invalidNumberError(value:String):void;
		/**
		 * Error message when the cardNumber field is empty.
		 */
		public function get noNumError():String;
		public function set noNumError(value:String):void;
		/**
		 * Error message when the cardType field is blank.
		 */
		public function get noTypeError():String;
		public function set noTypeError(value:String):void;
		/**
		 * Error message when the cardNumber field contains the wrong
		 *  number of digits for the specified credit card type.
		 */
		public function get wrongLengthError():String;
		public function set wrongLengthError(value:String):void;
		/**
		 * Error message the cardType field contains an invalid credit card type.
		 *  You should use the predefined constants for the cardType field:
		 *  CreditCardValidatorCardType.MASTER_CARD,
		 *  CreditCardValidatorCardType.VISA,
		 *  CreditCardValidatorCardType.AMERICAN_EXPRESS,
		 *  CreditCardValidatorCardType.DISCOVER, or
		 *  CreditCardValidatorCardType.DINERS_CLUB.
		 */
		public function get wrongTypeError():String;
		public function set wrongTypeError(value:String):void;
		/**
		 * Constructor.
		 */
		public function CreditCardValidator();
		/**
		 * Override of the base class doValidation() method
		 *  to validate a credit card number.
		 *
		 * @param value             <Object> an Object to validate.
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		protected override function doValidation(value:Object):Array;
		/**
		 * Convenience method for calling a validator.
		 *  Each of the standard Flex validators has a similar convenience method.
		 *
		 * @param validator         <CreditCardValidator> The CreditCardValidator instance.
		 * @param value             <Object> A field to validate, which must contain
		 *                            the following fields:
		 *                            cardType - Specifies the type of credit card being validated.
		 *                            Use the static constants
		 *                            CreditCardValidatorCardType.MASTER_CARD,
		 *                            CreditCardValidatorCardType.VISA,
		 *                            CreditCardValidatorCardType.AMERICAN_EXPRESS,
		 *                            CreditCardValidatorCardType.DISCOVER, or
		 *                            CreditCardValidatorCardType.DINERS_CLUB.
		 *                            cardNumber - Specifies the number of the card
		 *                            being validated.
		 * @param baseField         <String> Text representation of the subfield
		 *                            specified in the value parameter.
		 *                            For example, if the value parameter
		 *                            specifies value.date, the baseField value is "date".
		 * @return                  <Array> An Array of ValidationResult objects, with one ValidationResult
		 *                            object for each field examined by the validator.
		 */
		public static function validateCreditCard(validator:CreditCardValidator, value:Object, baseField:String):Array;
	}
}
