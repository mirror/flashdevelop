package mx.collections.errors
{
	/**
	 *  This error is thrown when a Sort class is not configured properly; *  for example, if the find criteria are invalid.
	 */
	public class SortError extends Error
	{
		/**
		 *  Constructor.	 *	 *  @param message A message providing information about the error cause.
		 */
		public function SortError (message:String);
	}
}
