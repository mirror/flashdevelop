package mx.validators
{
	import mx.events.ValidationResultEvent;

	/**
	 *  The interface that components implement to support *  the Flex data validation mechanism.  *  The UIComponent class implements this interface. *  Therefore, any subclass of UIComponent also implements it.
	 */
	public interface IValidatorListener
	{
		/**
		 *  The text that will be displayed by a component's error tip when a     *  component is monitored by a Validator and validation fails.     *     *  <p>You can use the <code>errorString</code> property to show a      *  validation error for a component, without actually using	 *  a validator class.      *  When you write a String value to the <code>errorString</code> property,      *  Flex draws a red border around the component to indicate	 *  the validation error, and the String appears in a tooltip	 *  as the validation error message when you move  the mouse over	 *  the component, just as if a validator detected a validation error.</p>     *     *  <p>To clear the validation error, write an empty String, "",      *  to the <code>errorString</code> property.</p>     *     *  <p>Note that writing a value to the <code>errorString</code> property      *  does not trigger the valid or invalid events; it only changes the      *  border color and displays the validation error message.</p>
		 */
		public function get errorString () : String;
		/**
		 *  @private
		 */
		public function set errorString (value:String) : void;
		/**
		 *  Used by a validator to assign a subfield.
		 */
		public function get validationSubField () : String;
		/**
		 *  @private
		 */
		public function set validationSubField (value:String) : void;

		/**
		 *  Handles both the <code>valid</code> and <code>invalid</code> events	 *  from a  validator assigned to this component.  	 *	 *  <p>You typically handle the <code>valid</code> and <code>invalid</code>	 *  events dispatched by a validator by assigning event listeners	 *  to the validators. 	 *  If you want to handle validation events directly in the component	 *  that is being validated, you can override this method	 *  to handle the <code>valid</code> and <code>invalid</code> events.	 *  From within your implementation, you can use the	 *  <code>dispatchEvent()</code> method to dispatch the 	 *  <code>valid</code> and <code>invalid</code> events	 *  in the case where a validator is also listening for them.</p>	 *	 *  @param event The event object for the validation.     *     *  @see mx.events.ValidationResultEvent
		 */
		public function validationResultHandler (event:ValidationResultEvent) : void;
	}
}
