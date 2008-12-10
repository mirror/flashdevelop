package mx.collections.errors
{
	/**
	 *  This error is thrown by a collection Cursor. *  Errors of this class are thrown by classes *  that implement the IViewCursor interface.
	 */
	public class CursorError extends Error
	{
		/**
		 *  Constructor.     *     *  @param message A message providing information about the error cause.
		 */
		public function CursorError (message:String);
	}
}
