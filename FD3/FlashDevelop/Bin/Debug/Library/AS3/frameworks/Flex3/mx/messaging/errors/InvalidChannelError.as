package mx.messaging.errors
{
	/**
	 *  This error is thrown when a Channel can't be accessed *  or is not valid for the current destination. *  This error is thrown by the following methods/properties *  within the framework: *  <ul> *    <li><code>ServerConfig.getChannel()</code> if the channel *    can't be found based on channel id.</li> *  </ul>
	 */
	public class InvalidChannelError extends ChannelError
	{
		/**
		 *  Constructs a new instance of an InvalidChannelError with the specified message.     *     *  @param msg String that contains the message that describes this InvalidChannelError.
		 */
		public function InvalidChannelError (msg:String);
	}
}
