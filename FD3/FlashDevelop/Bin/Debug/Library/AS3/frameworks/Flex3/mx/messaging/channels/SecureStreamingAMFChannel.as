package mx.messaging.channels
{
	/**
	 *  The SecureStreamingAMFChannel class is identical to the StreamingAMFChannel  *  class except that it uses a secure protocol, HTTPS, to send messages to an  *  AMF endpoint.
	 */
	public class SecureStreamingAMFChannel extends StreamingAMFChannel
	{
		/**
		 *  Returns the protocol for this channel (https).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new SecureStreamingAMFChannel instance.     *	 *  @param id The id of this Channel.	 *  	 *  @param uri The uri for this Channel.
		 */
		public function SecureStreamingAMFChannel (id:String = null, uri:String = null);
	}
}
