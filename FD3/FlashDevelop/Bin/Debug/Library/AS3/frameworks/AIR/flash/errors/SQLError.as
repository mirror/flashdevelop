/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.errors {
	public class SQLError extends Error {
		/**
		 * Details of the current error.  This provides additional specific
		 *  information about the error that occurred.
		 */
		public function get details():String;
		/**
		 * A value indicating the operation that was being attempted when the error occurred.
		 *  This value is one of the constants defined in the SQLErrorOperation class.
		 */
		public function get operation():String;
		/**
		 * Creates a SQLError instance that can be thrown or used with a
		 *  SQLErrorEvent instance's error property.
		 *
		 * @param operation         <String> Indicates the specific operation that caused
		 *                            the failure. The value is one of the constants defined in the
		 *                            SQLErrorOperation class.
		 * @param details           <String (default = "")> The details for the current error.
		 * @param message           <String (default = "")> The description of the error that
		 *                            occurred.
		 * @param id                <int (default = 0)> A reference number associated with the specific error message.
		 */
		public function SQLError(operation:String, details:String = "", message:String = "", id:int = 0);
		/**
		 * Returns the string "Error" by default or the value contained in the Error.message property,
		 *  if defined.
		 *
		 * @return                  <String> The error message.
		 */
		public function toString():String;
	}
}
