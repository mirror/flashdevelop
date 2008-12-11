package 
{
	/// A Boolean object is a data type that can have one of two values, either true or false, used for logical operations.
	public class Boolean
	{
		/// Creates a Boolean object with the specified value.
		public function Boolean(expression:Object=false);

		/// Returns the string representation ("true" or "false") of the Boolean object.
		public function toString():String;

		/// Returns true if the value of the specified Boolean object is true; false otherwise.
		public function valueOf():Boolean;

	}

}

