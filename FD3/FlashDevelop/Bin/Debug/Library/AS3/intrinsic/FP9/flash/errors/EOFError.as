package flash.errors
{
	/// An EOFError exception is thrown when you attempt to read past the end of the available data.
	public class EOFError extends flash.errors.IOError
	{
		/// Creates a new EOFError object.
		public function EOFError(message:String);

	}

}

