package mx.logging.errors
{
include "../../core/Version.as"
	/**
	 *  This error is thrown when a category specified for a logger
 *  contains invalid characters or is malformed.
 *  This error is thrown by the following method:
 *  <ul>
 *    <li><code>Log.getLogger()</code> if a category specified
 *    is malformed.</li>
 *  </ul>
	 */
	public class InvalidCategoryError extends Error
	{
		/**
		 *  Constructor.
	 *
	 *  @param message The message that describes this error.
		 */
		public function InvalidCategoryError (message:String);

		/**
		 *  Returns the messge as a String.
	 *  
	 *  @return The message.
	 *
		 */
		public function toString () : String;
	}
}
