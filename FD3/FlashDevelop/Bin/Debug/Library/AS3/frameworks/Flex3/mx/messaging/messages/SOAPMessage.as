package mx.messaging.messages
{
	/**
	 *  SOAPMessages are similar to HTTPRequestMessages. However, *  they always contain a SOAP XML envelope request body *  that will always be sent using HTTP POST. *  They also allow a SOAP action to be specified.
	 */
	public class SOAPMessage extends HTTPRequestMessage
	{
		/**
		 *  The HTTP header that stores the SOAP action for the SOAPMessage.
		 */
		public static const SOAP_ACTION_HEADER : String = "SOAPAction";

		/**
		 *  Constructs an uninitialized SOAPMessage.
		 */
		public function SOAPMessage ();
		/**
		 *  Provides access to the name of the remote method/operation that     *  will be called.     *     *  @return Returns the name of the remote method/operation that      *  will be called.
		 */
		public function getSOAPAction () : String;
		/**
		 *  @private
		 */
		public function setSOAPAction (value:String) : void;
	}
}
