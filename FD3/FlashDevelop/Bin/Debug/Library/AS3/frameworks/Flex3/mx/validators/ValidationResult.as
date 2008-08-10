/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.validators {
	public class ValidationResult {
		/**
		 * The validation error code
		 *  if the value of the isError property is true.
		 */
		public var errorCode:String;
		/**
		 * The validation error message
		 *  if the value of the isError property is true.
		 */
		public var errorMessage:String;
		/**
		 * Contains true if the field generated a validation failure.
		 */
		public var isError:Boolean;
		/**
		 * The name of the subfield that the result is associated with.
		 *  Some validators, such as CreditCardValidator and DateValidator,
		 *  validate multiple subfields at the same time.
		 */
		public var subField:String;
		/**
		 * Constructor
		 *
		 * @param isError           <Boolean> Pass true if there was a validation error.
		 * @param subField          <String (default = "")> Name of the subfield of the validated Object.
		 * @param errorCode         <String (default = "")> Validation error code.
		 * @param errorMessage      <String (default = "")> Validation error message.
		 */
		public function ValidationResult(isError:Boolean, subField:String = "", errorCode:String = "", errorMessage:String = "");
	}
}
