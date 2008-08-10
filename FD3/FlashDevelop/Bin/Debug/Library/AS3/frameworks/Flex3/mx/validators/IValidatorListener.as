/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	import mx.events.ValidationResultEvent;
	public interface IValidatorListener {
		/**
		 * The text that will be displayed by a component's error tip when a
		 *  component is monitored by a Validator and validation fails.
		 */
		public function get errorString():String;
		public function set errorString(value:String):void;
		/**
		 * Used by a validator to assign a subfield.
		 */
		public function get validationSubField():String;
		public function set validationSubField(value:String):void;
		/**
		 * Handles both the valid and invalid events
		 *  from a  validator assigned to this component.
		 *
		 * @param event             <ValidationResultEvent> The event object for the validation.
		 */
		public function validationResultHandler(event:ValidationResultEvent):void;
	}
}
