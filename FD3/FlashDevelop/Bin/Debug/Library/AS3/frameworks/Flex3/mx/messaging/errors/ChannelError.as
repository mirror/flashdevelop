package mx.messaging.errors
{
	/**
	 *  This is the base class for any channel related errors. *  It allows for less granular catch code.
	 */
	public class ChannelError extends MessagingError
	{
		/**
		 *  Constructs a new instance of a ChannelError with the	 *  specified message.	 *	 *  @param msg String that contains the message that describes the error.
		 */
		public function ChannelError (msg:String);
	}
}
