package flash.sampler
{
	/// The StackFrame class provides access to the properties of a data block containing a function.
	public class StackFrame
	{
		/// The function name in the stack frame.
		public static const name:String;

		/// The file name of the SWF file being debugged.
		public static const file:String;

		/// The line number for the function in the SWF file being debugged.
		public static const line:uint;

		/// Converts the StackFrame to a string of its properties.
		public function toString():String;

	}

}

