package mx.messaging.channels
{
	/**
	 *  The SecureHTTPChannel class is identical to the HTTPChannel class except that it uses a *  secure protocol, HTTPS, to send messages to an HTTP endpoint.
	 */
	public class SecureHTTPChannel extends HTTPChannel
	{
		/**
		 *  Returns the protocol for this channel (https).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new SecureHTTPChannel instance.     *	 *  @param id The id of this Channel.	 *  	 *  @param uri The uri for this Channel.
		 */
		public function SecureHTTPChannel (id:String = null, uri:String = null);
	}
}
