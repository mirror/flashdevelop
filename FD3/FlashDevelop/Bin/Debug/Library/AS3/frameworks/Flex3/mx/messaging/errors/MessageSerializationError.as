/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.errors {
	import mx.messaging.messages.ErrorMessage;
	public class MessageSerializationError extends MessagingError {
		/**
		 * Provides specific information about the fault that occurred and for
		 *  which message.
		 */
		public var fault:ErrorMessage;
		/**
		 * Constructs a new instance of the MessageSerializationError
		 *  with the specified message.
		 *
		 * @param msg               <String> String that contains the message that describes the error.
		 * @param fault             <ErrorMessage> 
		 */
		public function MessageSerializationError(msg:String, fault:ErrorMessage);
	}
}
