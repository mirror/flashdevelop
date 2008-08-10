/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class AcknowledgeMessage extends AsyncMessage {
		/**
		 * Constructs an instance of an AcknowledgeMessage with an empty body and header.
		 */
		public function AcknowledgeMessage();
		/**
		 * Header name for the error hint header.
		 *  Used to indicate that the acknowledgement is for a message that
		 *  generated an error.
		 */
		public static const ERROR_HINT_HEADER:String = "DSErrorHint";
	}
}
