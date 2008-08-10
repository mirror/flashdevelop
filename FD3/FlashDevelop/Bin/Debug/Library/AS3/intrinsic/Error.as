/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public dynamic  class Error {
		/**
		 * Contains the reference number associated with the specific error message. For a custom Error object,
		 *  this number is the value from the id parameter supplied in the constructor.
		 */
		public function get errorID():int;
		/**
		 * Contains the message associated with the Error object. By default, the value of this property
		 *  is "Error". You can specify a message property when you create an
		 *  Error object by passing the error string to the Error constructor function.
		 */
		public var message:String;
		/**
		 * Contains the name of the Error object. By default, the value of this property is "Error".
		 */
		public var name:String;
		/**
		 * Creates a new Error object. If message is specified, its value is assigned
		 *  to the object's Error.message property.
		 *
		 * @param message           <String (default = "")> A string associated with the Error object; this parameter
		 *                            is optional.
		 * @param id                <int (default = 0)> A reference number to associate with the specific error message.
		 */
		public function Error(message:String = "", id:int = 0);
		/**
		 * Returns the call stack for an error as a string at the time of the error's construction (for the debugger version
		 *  of Flash Player and the AIR Debug Launcher (ADL) only; returns null if not using the debugger version
		 *  of Flash Player or the ADL.
		 *
		 * @return                  <String> A string representation of the call stack. Null if not using the debugger player.
		 */
		public function getStackTrace():String;
		/**
		 * Returns the string "Error" by default or the value contained in the Error.message property,
		 *  if defined.
		 *
		 * @return                  <String> The error message.
		 */
		public override function toString():String;
	}
}
