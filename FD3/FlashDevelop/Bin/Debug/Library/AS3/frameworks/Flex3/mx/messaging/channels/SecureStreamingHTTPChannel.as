package mx.messaging.channels
{
	/**
	 *  The SecureStreamingHTTPChannel class is identical to the StreamingHTTPChannel *  class except that it uses a secure protocol, HTTPS, to send messages to an  *  HTTP endpoint.
	 */
	public class SecureStreamingHTTPChannel extends StreamingHTTPChannel
	{
		/**
		 *  Returns the protocol for this channel (https).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new SecureStreamingHTTPChannel instance.     *	 *  @param id The id of this Channel.	 *  	 *  @param uri The uri for this Channel.
		 */
		public function SecureStreamingHTTPChannel (id:String = null, uri:String = null);
	}
}
