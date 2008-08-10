/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.sampler {
	public final  class StackFrame {
		/**
		 * Converts the StackFrame to a string of its properties.
		 *
		 * @return                  <String> A string containing the name property, and optionally the file
		 *                            and line properties (if a SWF file is being debugged) of the StackFrame object.
		 *                            Player Version : Flash Player 9 debugger version Update 3.
		 */
		public function toString():String;
		/**
		 * The file name of the SWF file being debugged.
		 */
		public const file:String;
		/**
		 * The line number for the function in the SWF file being debugged.
		 */
		public const line:uint;
		/**
		 * The function name in the stack frame.
		 */
		public const name:String;
	}
}
