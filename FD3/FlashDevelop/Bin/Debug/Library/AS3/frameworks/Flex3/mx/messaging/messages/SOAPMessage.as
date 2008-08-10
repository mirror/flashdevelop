/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class SOAPMessage extends HTTPRequestMessage {
		/**
		 * Constructs an uninitialized SOAPMessage.
		 */
		public function SOAPMessage();
		/**
		 * Provides access to the name of the remote method/operation that
		 *  will be called.
		 */
		public function getSOAPAction():String;
		/**
		 * The HTTP header that stores the SOAP action for the SOAPMessage.
		 */
		public static const SOAP_ACTION_HEADER:String = "SOAPAction";
	}
}
