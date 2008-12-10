package mx.messaging.channels
{
	/**
	 *  The SecureAMFChannel class is identical to the AMFChannel class except that it uses a *  secure protocol, HTTPS, to send messages to an AMF endpoint.
	 */
	public class SecureAMFChannel extends AMFChannel
	{
		/**
		 *  Returns the protocol for this channel (https).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new SecureAMFChannel instance.     *	 *  @param id The id of this Channel.	 *  	 *  @param uri The uri for this Channel.
		 */
		public function SecureAMFChannel (id:String = null, uri:String = null);
	}
}
