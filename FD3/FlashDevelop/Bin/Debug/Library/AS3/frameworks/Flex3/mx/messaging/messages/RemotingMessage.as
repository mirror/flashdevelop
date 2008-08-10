/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class RemotingMessage extends AbstractMessage {
		/**
		 * Provides access to the name of the remote method/operation that
		 *  should be called.
		 */
		public var operation:String;
		/**
		 * This property is provided for backwards compatibility. The best
		 *  practice, however, is to not expose the underlying source of a
		 *  RemoteObject destination on the client and only one source to
		 *  a destination. Some types of Remoting Services may even ignore
		 *  this property for security reasons.
		 */
		public var source:String;
		/**
		 * Constructs an uninitialized RemotingMessage.
		 */
		public function RemotingMessage();
	}
}
