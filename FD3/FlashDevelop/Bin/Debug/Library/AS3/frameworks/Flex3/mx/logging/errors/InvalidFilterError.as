package mx.logging.errors
{
include "../../core/Version.as"
	/**
	 *  This error is thrown when a filter specified for a target
 *  contains invalid characters or is malformed.
 *  This error is thrown by the following methods/properties:
 *  <ul>
 *    <li><code>ILoggerTarget.filters</code> if a filter expression
 *    in this listis malformed.</li>
 *  </ul>
	 */
	public class InvalidFilterError extends Error
	{
		/**
		 *  Constructor.
	 *
	 *  @param message The message that describes this error.
		 */
		public function InvalidFilterError (message:String);

		/**
		 *  Returns the messge as a String.
	 *  
	 *  @return The message.
		 */
		public function toString () : String;
	}
}
