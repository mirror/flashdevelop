/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class CommandMessage extends AsyncMessage {
		/**
		 * Provides access to the operation/command for the CommandMessage.
		 *  Operations indicate how this message should be processed by the remote
		 *  destination.
		 */
		public var operation:uint;
		/**
		 * Constructs an instance of a CommandMessage with an empty body and header
		 *  and a default operation of UNKNOWN_OPERATION.
		 */
		public function CommandMessage();
		/**
		 * Provides a description of the operation specified.
		 *  This method is used in toString() operations on this
		 *  message.
		 *
		 * @param op                <uint> One of the CommandMessage operation constants.
		 * @return                  <String> Short name for the operation.
		 */
		public static function getOperationAsString(op:uint):String;
		/**
		 * Returns a string representation of the message.
		 *
		 * @return                  <String> String representation of the message.
		 */
		public override function toString():String;
		/**
		 * Header used in a MULTI_SUBSCRIBE message to specify an Array of subtopic/selector
		 *  pairs to add to the existing set of subscriptions.
		 */
		public static const ADD_SUBSCRIPTIONS:String = "DSAddSub";
		/**
		 * The server message type for authentication commands.
		 */
		public static const AUTHENTICATION_MESSAGE_REF_TYPE:String = "flex.messaging.messages.AuthenticationMessage";
		/**
		 * This operation is used to test connectivity over the current channel to
		 *  the remote endpoint.
		 */
		public static const CLIENT_PING_OPERATION:uint = 5;
		/**
		 * This operation is used by a remote destination to sync missed or cached messages
		 *  back to a client as a result of a client issued poll command.
		 */
		public static const CLIENT_SYNC_OPERATION:uint = 4;
		/**
		 * This operation is used to request a list of failover endpoint URIs
		 *  for the remote destination based on cluster membership.
		 */
		public static const CLUSTER_REQUEST_OPERATION:uint = 7;
		/**
		 * Header to specify which character set encoding was used while encoding
		 *  login credentials.
		 */
		public static const CREDENTIALS_CHARSET_HEADER:String = "DSCredentialsCharset";
		/**
		 * This operation is used to indicate that a channel has disconnected.
		 */
		public static const DISCONNECT_OPERATION:uint = 12;
		/**
		 * This operation is used to send credentials to the endpoint so that
		 *  the user can be logged in over the current channel.
		 *  The credentials need to be Base64 encoded and stored in the body
		 *  of the message.
		 */
		public static const LOGIN_OPERATION:uint = 8;
		/**
		 * This operation is used to log the user out of the current channel, and
		 *  will invalidate the server session if the channel is HTTP based.
		 */
		public static const LOGOUT_OPERATION:uint = 9;
		/**
		 * Endpoints can imply what features they support by reporting the
		 *  latest version of messaging they are capable of during the handshake of
		 *  the initial ping CommandMessage.
		 */
		public static const MESSAGING_VERSION:String = "DSMessagingVersion";
		/**
		 * Used by the MultiTopicConsumer to subscribe/unsubscribe for more
		 *  than one topic in the same message.
		 */
		public static const MULTI_SUBSCRIBE_OPERATION:uint = 11;
		/**
		 * Header to indicate that the Channel needs the configuration from the
		 *  server.
		 */
		public static const NEEDS_CONFIG_HEADER:String = "DSNeedsConfig";
		/**
		 * Header to suppress poll response processing. If a client has a long-poll
		 *  parked on the server and issues another poll, the response to this subsequent poll
		 *  should be tagged with this header in which case the response is treated as a
		 *  no-op and the next poll will not be scheduled. Without this, a subsequent poll
		 *  will put the channel and endpoint into a busy polling cycle.
		 */
		public static const NO_OP_POLL_HEADER:String = "DSNoOpPoll";
		/**
		 * This operation is used to poll a remote destination for pending,
		 *  undelivered messages.
		 */
		public static const POLL_OPERATION:uint = 2;
		/**
		 * Header to drive an idle wait time before the next client poll request.
		 */
		public static const POLL_WAIT_HEADER:String = "DSPollWait";
		/**
		 * Durable JMS subscriptions are preserved when an unsubscribe message
		 *  has this parameter set to true in its header.
		 */
		public static const PRESERVE_DURABLE_HEADER:String = "DSPreserveDurable";
		/**
		 * Like the above, but specifies the subtopic/selector array of to remove
		 */
		public static const REMOVE_SUBSCRIPTIONS:String = "DSRemSub";
		/**
		 * Subscribe commands issued by a Consumer pass the Consumer's selector
		 *  expression in this header.
		 */
		public static const SELECTOR_HEADER:String = "DSSelector";
		/**
		 * This operation is used to subscribe to a remote destination.
		 */
		public static const SUBSCRIBE_OPERATION:uint = 0;
		/**
		 * This operation is used to indicate that the client's subscription with a
		 *  remote destination has timed out.
		 */
		public static const SUBSCRIPTION_INVALIDATE_OPERATION:uint = 10;
		/**
		 * The separator string used for separating subtopic and selectors in the
		 *  add and remove subscription headers.
		 */
		public static const SUBTOPIC_SEPARATOR:String = "_;_";
		/**
		 * This is the default operation for new CommandMessage instances.
		 */
		public static const UNKNOWN_OPERATION:uint = 10000;
		/**
		 * This operation is used to unsubscribe from a remote destination.
		 */
		public static const UNSUBSCRIBE_OPERATION:uint = 1;
	}
}
