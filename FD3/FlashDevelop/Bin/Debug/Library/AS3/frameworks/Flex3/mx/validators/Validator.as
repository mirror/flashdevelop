/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	import flash.events.IEventDispatcher;
	import mx.resources.IResourceManager;
	public class Validator extends EventDispatcher implements IMXMLObject {
		/**
		 * Contains an Array of listener objects, if any,
		 *  or the source object. Used to determine which object
		 *  to notify about the validation result.
		 */
		protected function get actualListeners():Array;
		/**
		 * Contains the trigger object, if any,
		 *  or the source object. Used to determine the listener object
		 *  for the triggerEvent.
		 */
		protected function get actualTrigger():IEventDispatcher;
		/**
		 * Setting this value to false will stop the validator
		 *  from performing validation.
		 *  When a validator is disabled, it dispatch no events,
		 *  and the validate() method returns null.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * Specifies the validation listener.
		 */
		public function get listener():Object;
		public function set listener(value:Object):void;
		/**
		 * A String specifying the name of the property
		 *  of the source object that contains
		 *  the value to validate.
		 *  The property is optional, but if you specify source,
		 *  you should set a value for this property as well.
		 */
		public function get property():String;
		public function set property(value:String):void;
		/**
		 * If true, specifies that a missing or empty
		 *  value causes a validation error.
		 */
		public var required:Boolean = true;
		/**
		 * Error message when a value is missing and the
		 *  required property is true.
		 */
		public function get requiredFieldError():String;
		public function set requiredFieldError(value:String):void;
		/**
		 * A reference to the object which manages
		 *  all of the application's localized resources.
		 *  This is a singleton instance which implements
		 *  the IResourceManager interface.
		 */
		protected function set resourceManager(value:IResourceManager):void;
		/**
		 * Specifies the object containing the property to validate.
		 *  Set this to an instance of a component or a data model.
		 *  You use data binding syntax in MXML to specify the value.
		 *  This property supports dot-delimited Strings
		 *  for specifying nested properties.
		 *  If you specify a value to the source property,
		 *  then you should specify a value to the property
		 *  property as well.
		 *  The source property is optional.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * An Array of Strings containing the names for the properties contained
		 *  in the value Object passed to the validate() method.
		 *  For example, CreditCardValidator sets this property to
		 *  [ "cardNumber", "cardType" ].
		 *  This value means that the value Object
		 *  passed to the validate() method
		 *  should contain a cardNumber and a cardType property.
		 */
		protected var subFields:Array;
		/**
		 * Specifies the component generating the event that triggers the validator.
		 *  If omitted, by default Flex uses the value of the source property.
		 *  When the trigger dispatches a triggerEvent,
		 *  validation executes.
		 */
		public function get trigger():IEventDispatcher;
		public function set trigger(value:IEventDispatcher):void;
		/**
		 * Specifies the event that triggers the validation.
		 *  If omitted, Flex uses the valueCommit event.
		 *  Flex dispatches the valueCommit event
		 *  when a user completes data entry into a control.
		 *  Usually this is when the user removes focus from the component,
		 *  or when a property value is changed programmatically.
		 *  If you want a validator to ignore all events,
		 *  set triggerEvent to the empty string ("").
		 */
		public function get triggerEvent():String;
		public function set triggerEvent(value:String):void;
		/**
		 * Constructor.
		 */
		public function Validator();
		/**
		 * Sets up all of the listeners for the
		 *  valid and invalid
		 *  events dispatched from the validator. Subclasses of the Validator class
		 *  should first call the removeListenerHandler() method,
		 *  and then the addListenerHandler() method if
		 *  the value of one of their listeners or sources changes.
		 *  The CreditCardValidator and DateValidator classes use this function internally.
		 */
		protected function addListenerHandler():void;
		/**
		 * Executes the validation logic of this validator,
		 *  including validating that a missing or empty value
		 *  causes a validation error as defined by
		 *  the value of the required property.
		 *
		 * @param value             <Object> Value to validate.
		 * @return                  <Array> For an invalid result, an Array of ValidationResult objects,
		 *                            with one ValidationResult object for each field examined
		 *                            by the validator that failed validation.
		 */
		protected function doValidation(value:Object):Array;
		/**
		 * Returns the Object to validate. Subclasses, such as the
		 *  CreditCardValidator and DateValidator classes,
		 *  override this method because they need
		 *  to access the values from multiple subfields.
		 *
		 * @return                  <Object> The Object to validate.
		 */
		protected function getValueFromSource():Object;
		/**
		 * Returns a ValidationResultEvent from the Array of error results.
		 *  Internally, this function takes the results from the
		 *  doValidation() method and puts it into a ValidationResultEvent object.
		 *  Subclasses, such as the RegExpValidator class,
		 *  should override this function if they output a subclass
		 *  of ValidationResultEvent objects, such as the RegExpValidationResult objects, and
		 *  needs to populate the object with additional information. You never
		 *  call this function directly, and you should rarely override it.
		 *
		 * @param errorResults      <Array> Array of ValidationResult objects.
		 * @return                  <ValidationResultEvent> The ValidationResultEvent returned by the validate() method.
		 */
		protected function handleResults(errorResults:Array):ValidationResultEvent;
		/**
		 * Called automatically by the MXML compiler when the Validator
		 *  is created using an MXML tag.
		 *
		 * @param document          <Object> The MXML document containing this Validator.
		 * @param id                <String> Ignored.
		 */
		public function initialized(document:Object, id:String):void;
		/**
		 * Returns true if value is not null.
		 *
		 * @param value             <Object> The value to test.
		 * @return                  <Boolean> true if value is not null.
		 */
		protected function isRealValue(value:Object):Boolean;
		/**
		 * Disconnects all of the listeners for the
		 *  valid and invalid
		 *  events dispatched from the validator. Subclasses should first call the
		 *  removeListenerHandler() method and then the
		 *  addListenerHandler method if
		 *  the value of one of their listeners or sources changes.
		 *  The CreditCardValidator and DateValidator classes use this function internally.
		 */
		protected function removeListenerHandler():void;
		/**
		 * This method is called when a Validator is constructed,
		 *  and again whenever the ResourceManager dispatches
		 *  a "change" Event to indicate
		 *  that the localized resources have changed in some way.
		 */
		protected function resourcesChanged():void;
		/**
		 * Performs validation and optionally notifies
		 *  the listeners of the result.
		 *
		 * @param value             <Object (default = null)> Optional value to validate.
		 *                            If null, then the validator uses the source and
		 *                            property properties to determine the value.
		 *                            If you specify this argument, you should also set the
		 *                            listener property to specify the target component
		 *                            for any validation error messages.
		 * @param suppressEvents    <Boolean (default = false)> If false, then after validation,
		 *                            the validator will notify the listener of the result.
		 * @return                  <ValidationResultEvent> A ValidationResultEvent object
		 *                            containing the results of the validation.
		 *                            For a successful validation, the
		 *                            ValidationResultEvent.results Array property is empty.
		 *                            For a validation failure, the
		 *                            ValidationResultEvent.results Array property contains
		 *                            one ValidationResult object for each field checked by the validator,
		 *                            both for fields that failed the validation and for fields that passed.
		 *                            Examine the ValidationResult.isError
		 *                            property to determine if the field passed or failed the validation.
		 */
		public function validate(value:Object = null, suppressEvents:Boolean = false):ValidationResultEvent;
		/**
		 * Invokes all the validators in the validators Array.
		 *  Returns an Array containing one ValidationResultEvent object
		 *  for each validator that failed.
		 *  Returns an empty Array if all validators succeed.
		 *
		 * @param validators        <Array> An Array containing the Validator objects to execute.
		 * @return                  <Array> Array of ValidationResultEvent objects, where the Array
		 *                            contains one ValidationResultEvent object for each validator
		 *                            that failed.
		 *                            The Array is empty if all validators succeed.
		 */
		public static function validateAll(validators:Array):Array;
		/**
		 * A String containing the decimal digits 0 through 9.
		 */
		protected static const DECIMAL_DIGITS:String = "0123456789";
		/**
		 * A string containing the upper- and lower-case letters
		 *  of the Roman alphabet  ("A" through "Z" and "a" through "z").
		 */
		protected static const ROMAN_LETTERS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	}
}
