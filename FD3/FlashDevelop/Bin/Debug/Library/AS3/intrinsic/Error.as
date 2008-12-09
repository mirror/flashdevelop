package 
{
	/// The Error class contains information about an error that occurred in a script.
	public class Error
	{
		/// Contains the message associated with the Error object.
		public var message:*;

		/// Contains the name of the Error object.
		public var name:*;

		/// Contains the reference number associated with the specific error message.
		public var errorID:int;

		/// Creates a new Error instance with the specified error message.
		public function Error(message:String, id:int=0);

		/// Returns the call stack for an error in a readable form.
		public function getStackTrace():String;

		/// Returns the error message, or the word "Error" if the message is undefined.
		public function toString():String;

	}

}

