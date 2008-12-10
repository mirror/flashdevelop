package mx.messaging.errors
{
	/**
	 *  This is the base class for any messaging related error. *  It allows for less granular catch code.
	 */
	public class MessagingError extends Error
	{
		/**
		 *  Constructs a new instance of a MessagingError with the	 *  specified message.	 *	 *  @param msg String that contains the message that describes the error.
		 */
		public function MessagingError (msg:String);
		/**
		 *  Returns the string "[MessagingError]" by default, and includes the message property if defined.     *      *  @return String representation of the MessagingError.
		 */
		public function toString () : String;
	}
}
