/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	public class AutomationError extends Error {
		/**
		 * The current error code.
		 */
		public function get code():Number;
		/**
		 * Constructor.
		 *
		 * @param msg               <String> An error message.
		 * @param code              <Number> The error code associated with the error message.
		 */
		public function AutomationError(msg:String, code:Number);
		/**
		 */
		public static const ILLEGAL_OPERATION:Number = 0x80040206;
		/**
		 */
		public static const ILLEGAL_RUNTIME_ID:Number = 0x8004020D;
		/**
		 */
		public static const OBJECT_NOT_FOUND:Number = 0x80040202;
		/**
		 */
		public static const OBJECT_NOT_UNIQUE:Number = 0x80040203;
		/**
		 */
		public static const OBJECT_NOT_VISIBLE:Number = 0x80040205;
	}
}
