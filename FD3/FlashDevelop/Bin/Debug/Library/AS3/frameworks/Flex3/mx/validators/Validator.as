package mx.validators
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import mx.binding.BindingManager;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when validation succeeds.
 *
 *  @eventType mx.events.ValidationResultEvent.VALID
	 */
	[Event(name="valid", type="mx.events.ValidationResultEvent")] 

	/**
	 *  Dispatched when validation fails.
 *
 *  @eventType mx.events.ValidationResultEvent.INVALID
	 */
	[Event(name="invalid", type="mx.events.ValidationResultEvent")] 

include "../core/Version.as"
	/**
	 *  The Validator class is the base class for all Flex validators. 
 *  This class implements the ability for a validator to make a field
 *  required, which means that the user must enter a value in the field
 *  or the validation fails.
 * 
 *  @mxml
 *
 *  <p>The Validator class defines the following tag attributes, 
 *  which all of its subclasses inherit:</p>
 *
 *  <pre>
 *  &lt;mx:Validator 
 *    enabled="true|false" 
 *    listener="<i>Value of the source property</i>" 
 *    property="<i>No default</i>" 
 *    required="true|false" 
 *    requiredFieldError="This field is required." 
 *    source="<i>No default</i>" 
 *    trigger="<i>Value of the source property</i>" 
 *    triggerEvent="valueCommit" 
 *  /&gt;
 *  </pre>
 *
 *  @see mx.events.ValidationResultEvent
 *  @see mx.validators.ValidationResult
 *  @see mx.validators.RegExpValidationResult
 *
 *  @includeExample examples/SimpleValidatorExample.mxml
	 */
	public class Validator extends EventDispatcher implements IMXMLObject
	{
		/**
		 *  A string containing the upper- and lower-case letters
     *  of the Roman alphabet  ("A" through "Z" and "a" through "z").
		 */
		protected static const ROMAN_LETTERS : String;
		/**
		 *  A String containing the decimal digits 0 through 9.
		 */
		protected static const DECIMAL_DIGITS : String = "0123456789";
		/**
		 *  @private
		 */
		private var document : Object;
		/**
		 *  @private
     *  Storage for the enabled property.
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
     *  Storage for the listener property.
		 */
		private var _listener : Object;
		/**
		 *  @private
     *  Storage for the property property.
		 */
		private var _property : String;
		/**
		 *  If <code>true</code>, specifies that a missing or empty 
     *  value causes a validation error. 
     *  
     *  @default true
		 */
		public var required : Boolean;
		/**
		 *  @private
     *  Storage for the resourceManager property.
		 */
		private var _resourceManager : IResourceManager;
		/**
		 *  @private
     *  Storage for the source property.
		 */
		private var _source : Object;
		/**
		 *  An Array of Strings containing the names for the properties contained 
     *  in the <code>value</code> Object passed to the <code>validate()</code> method. 
     *  For example, CreditCardValidator sets this property to 
     *  <code>[ "cardNumber", "cardType" ]</code>. 
     *  This value means that the <code>value</code> Object 
     *  passed to the <code>validate()</code> method 
     *  should contain a <code>cardNumber</code> and a <code>cardType</code> property. 
     *
     *  <p>Subclasses of the Validator class that 
     *  validate multiple data fields (like CreditCardValidator and DateValidator)
     *  should assign this property in their constructor. </p>
		 */
		protected var subFields : Array;
		/**
		 *  @private
     *  Storage for the trigger property.
		 */
		private var _trigger : IEventDispatcher;
		/**
		 *  @private
     *  Storage for the triggerEvent property.
		 */
		private var _triggerEvent : String;
		/**
		 *  @private
     *  Storage for the requiredFieldError property.
		 */
		private var _requiredFieldError : String;
		/**
		 *  @private
		 */
		private var requiredFieldErrorOverride : String;

		/**
		 *  Contains the trigger object, if any,
     *  or the source object. Used to determine the listener object
     *  for the <code>triggerEvent</code>.
		 */
		protected function get actualTrigger () : IEventDispatcher;

		/**
		 *  Contains an Array of listener objects, if any,  
     *  or the source object. Used to determine which object
     *  to notify about the validation result.
		 */
		protected function get actualListeners () : Array;

		/**
		 *  Setting this value to <code>false</code> will stop the validator
     *  from performing validation. 
     *  When a validator is disabled, it dispatch no events, 
     *  and the <code>validate()</code> method returns null.
     *
     *  @default true
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 This behavior has been removed.
     *  <p>If Flex does not find an appropriate listener, 
     *  validation errors propagate to the Application object, causing Flex 
     *  to display an Alert box containing the validation error message.</p>
     *
     *  <p>Specifying <code>this</code> causes the validation error
     *  to propagate to the Application object, 
     *  and displays an Alert box containing the validation error message.</p>
		 */
		public function get listener () : Object;
		/**
		 *  @private
		 */
		public function set listener (value:Object) : void;

		/**
		 *  A String specifying the name of the property
     *  of the <code>source</code> object that contains 
     *  the value to validate.
     *  The property is optional, but if you specify <code>source</code>,
     *  you should set a value for this property as well.
     *  
     *  @default null
		 */
		public function get property () : String;
		/**
		 *  @private
		 */
		public function set property (value:String) : void;

		/**
		 *  @copy mx.core.UIComponent#resourceManager
		 */
		protected function get resourceManager () : IResourceManager;

		/**
		 *  Specifies the object containing the property to validate. 
     *  Set this to an instance of a component or a data model. 
     *  You use data binding syntax in MXML to specify the value.
     *  This property supports dot-delimited Strings
     *  for specifying nested properties. 
     *
     *  If you specify a value to the <code>source</code> property,
     *  then you should specify a value to the <code>property</code>
     *  property as well. 
     *  The <code>source</code> property is optional.
     *  
     *  @default null
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;

		/**
		 *  Specifies the component generating the event that triggers the validator. 
     *  If omitted, by default Flex uses the value of the <code>source</code> property.
     *  When the <code>trigger</code> dispatches a <code>triggerEvent</code>,
     *  validation executes.
		 */
		public function get trigger () : IEventDispatcher;
		/**
		 *  @private
		 */
		public function set trigger (value:IEventDispatcher) : void;

		/**
		 *  Specifies the event that triggers the validation. 
     *  If omitted, Flex uses the <code>valueCommit</code> event. 
     *  Flex dispatches the <code>valueCommit</code> event
     *  when a user completes data entry into a control.
     *  Usually this is when the user removes focus from the component, 
     *  or when a property value is changed programmatically.
     *  If you want a validator to ignore all events,
     *  set <code>triggerEvent</code> to the empty string ("").
		 */
		public function get triggerEvent () : String;
		/**
		 *  @private
		 */
		public function set triggerEvent (value:String) : void;

		/**
		 *  Error message when a value is missing and the 
     *  <code>required</code> property is <code>true</code>. 
     *  
     *  @default "This field is required."
		 */
		public function get requiredFieldError () : String;
		/**
		 *  @private
		 */
		public function set requiredFieldError (value:String) : void;

		/**
		 *  Invokes all the validators in the <code>validators</code> Array.
     *  Returns an Array containing one ValidationResultEvent object 
     *  for each validator that failed.
     *  Returns an empty Array if all validators succeed. 
     *
     *  @param validators An Array containing the Validator objects to execute. 
     *
     *  @return Array of ValidationResultEvent objects, where the Array
     *  contains one ValidationResultEvent object for each validator
     *  that failed. 
     *  The Array is empty if all validators succeed.
		 */
		public static function validateAll (validators:Array) : Array;

		/**
		 *  @private
		 */
		private static function findObjectFromString (doc:Object, value:String) : Object;

		/**
		 *  @private
		 */
		private static function trimString (str:String) : String;

		/**
		 *  Constructor.
		 */
		public function Validator ();

		/**
		 *  Called automatically by the MXML compiler when the Validator
      *  is created using an MXML tag.  
      *
      *  @param document The MXML document containing this Validator.
      *
      *  @param id Ignored.
		 */
		public function initialized (document:Object, id:String) : void;

		/**
		 *  This method is called when a Validator is constructed,
     *  and again whenever the ResourceManager dispatches
     *  a <code>"change"</code> Event to indicate
     *  that the localized resources have changed in some way.
     * 
     *  <p>This event will be dispatched when you set the ResourceManager's
     *  <code>localeChain</code> property, when a resource module
     *  has finished loading, and when you call the ResourceManager's
     *  <code>update()</code> method.</p>
     *
     *  <p>Subclasses should override this method and, after calling
     *  <code>super.resourcesChanged()</code>, do whatever is appropriate
     *  in response to having new resource values.</p>
		 */
		protected function resourcesChanged () : void;

		/**
		 *  @private
		 */
		private function addTriggerHandler () : void;

		/**
		 *  @private
		 */
		private function removeTriggerHandler () : void;

		/**
		 *  Sets up all of the listeners for the 
     *  <code>valid</code> and <code>invalid</code>
     *  events dispatched from the validator. Subclasses of the Validator class 
     *  should first call the <code>removeListenerHandler()</code> method, 
     *  and then the <code>addListenerHandler()</code> method if 
     *  the value of one of their listeners or sources changes. 
     *  The CreditCardValidator and DateValidator classes use this function internally.
		 */
		protected function addListenerHandler () : void;

		/**
		 *  Disconnects all of the listeners for the 
     *  <code>valid</code> and <code>invalid</code>
     *  events dispatched from the validator. Subclasses should first call the
     *  <code>removeListenerHandler()</code> method and then the 
     *  <code>addListenerHandler</code> method if 
     *  the value of one of their listeners or sources changes. 
     *  The CreditCardValidator and DateValidator classes use this function internally.
		 */
		protected function removeListenerHandler () : void;

		/**
		 *  Returns <code>true</code> if <code>value</code> is not null. 
     * 
     *  @param value The value to test.
     *
     *  @return <code>true</code> if <code>value</code> is not null.
		 */
		protected function isRealValue (value:Object) : Boolean;

		/**
		 *  Performs validation and optionally notifies
     *  the listeners of the result. 
     *
     *  @param value Optional value to validate.
     *  If null, then the validator uses the <code>source</code> and
     *  <code>property</code> properties to determine the value.
     *  If you specify this argument, you should also set the
     *  <code>listener</code> property to specify the target component
     *  for any validation error messages.
     *
     *  @param suppressEvents If <code>false</code>, then after validation,
     *  the validator will notify the listener of the result.
     *
     *  @return A ValidationResultEvent object
     *  containing the results of the validation. 
     *  For a successful validation, the
     *  <code>ValidationResultEvent.results</code> Array property is empty. 
     *  For a validation failure, the
     *  <code>ValidationResultEvent.results</code> Array property contains
     *  one ValidationResult object for each field checked by the validator, 
     *  both for fields that failed the validation and for fields that passed. 
     *  Examine the <code>ValidationResult.isError</code>
     *  property to determine if the field passed or failed the validation. 
     *
     *  @see mx.events.ValidationResultEvent
     *  @see mx.validators.ValidationResult
		 */
		public function validate (value:Object = null, suppressEvents:Boolean = false) : ValidationResultEvent;

		/**
		 *  Returns the Object to validate. Subclasses, such as the 
     *  CreditCardValidator and DateValidator classes, 
     *  override this method because they need
     *  to access the values from multiple subfields. 
     *
     *  @return The Object to validate.
		 */
		protected function getValueFromSource () : Object;

		/**
		 *  @private 
     *  Main internally used function to handle validation process.
		 */
		private function processValidation (value:Object, suppressEvents:Boolean) : ValidationResultEvent;

		/**
		 *  Executes the validation logic of this validator, 
     *  including validating that a missing or empty value
     *  causes a validation error as defined by
     *  the value of the <code>required</code> property.
     *
     *  <p>If you create a subclass of a validator class,
     *  you must override this method. </p>
     *
     *  @param value Value to validate.
     *
     *  @return For an invalid result, an Array of ValidationResult objects,
     *  with one ValidationResult object for each field examined
     *  by the validator that failed validation.
     *
     *  @see mx.validators.ValidationResult
		 */
		protected function doValidation (value:Object) : Array;

		/**
		 *  @private 
     *  Determines if an object is valid based on its
     *  <code>required</code> property.
     *  This is a convenience method for calling a validator from within a 
     *  custom validation function.
		 */
		private function validateRequired (value:Object) : ValidationResult;

		/**
		 *  Returns a ValidationResultEvent from the Array of error results. 
     *  Internally, this function takes the results from the 
     *  <code>doValidation()</code> method and puts it into a ValidationResultEvent object. 
     *  Subclasses, such as the RegExpValidator class, 
     *  should override this function if they output a subclass
     *  of ValidationResultEvent objects, such as the RegExpValidationResult objects, and 
     *  needs to populate the object with additional information. You never
     *  call this function directly, and you should rarely override it. 
     *
     *  @param errorResults Array of ValidationResult objects.
     * 
     *  @return The ValidationResultEvent returned by the <code>validate()</code> method.
		 */
		protected function handleResults (errorResults:Array) : ValidationResultEvent;

		/**
		 *  @private
		 */
		private function triggerHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function resourceManager_changeHandler (event:Event) : void;
	}
}
