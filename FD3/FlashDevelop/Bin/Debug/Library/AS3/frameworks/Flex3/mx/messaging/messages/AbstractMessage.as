/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class AbstractMessage implements IMessage {
		/**
		 * The body of a message contains the specific data that needs to be
		 *  delivered to the remote destination.
		 */
		public function get body():Object;
		public function set body(value:Object):void;
		/**
		 * The clientId indicates which MessageAgent sent the message.
		 */
		public function get clientId():String;
		public function set clientId(value:String):void;
		/**
		 * The message destination.
		 */
		public function get destination():String;
		public function set destination(value:String):void;
		/**
		 * The headers of a message are an associative array where the key is the
		 *  header name and the value is the header value.
		 *  This property provides access to the specialized meta information for the
		 *  specific message instance.
		 *  Core header names begin with a 'DS' prefix. Custom header names should start
		 *  with a unique prefix to avoid name collisions.
		 */
		public function get headers():Object;
		public function set headers(value:Object):void;
		/**
		 * The unique id for the message.
		 */
		public function get messageId():String;
		public function set messageId(value:String):void;
		/**
		 * Provides access to the time stamp for the message.
		 *  A time stamp is the date and time that the message was sent.
		 *  The time stamp is used for tracking the message through the system,
		 *  ensuring quality of service levels and providing a mechanism for
		 *  message expiration.
		 */
		public function get timestamp():Number;
		public function set timestamp(value:Number):void;
		/**
		 * The time to live value of a message indicates how long the message
		 *  should be considered valid and deliverable.
		 *  This value works in conjunction with the timestamp value.
		 *  Time to live is the number of milliseconds that this message remains
		 *  valid starting from the specified timestamp value.
		 *  For example, if the timestamp value is 04/05/05 1:30:45 PST
		 *  and the timeToLive value is 5000, then this message will
		 *  expire at 04/05/05 1:30:50 PST.
		 *  Once a message expires it will not be delivered to any other clients.
		 */
		public function get timeToLive():Number;
		public function set timeToLive(value:Number):void;
		/**
		 * Constructs an instance of an AbstractMessage with an empty body and header.
		 *  This message type should not be instantiated or used directly.
		 */
		public function AbstractMessage();
		/**
		 * Returns a string representation of the message.
		 *
		 * @return                  <String> String representation of the message.
		 */
		public function toString():String;
		/**
		 * Messages pushed from the server may arrive in a batch, with messages in the
		 *  batch potentially targeted to different Consumer instances.
		 *  Each message will contain this header identifying the Consumer instance that
		 *  will receive the message.
		 */
		public static const DESTINATION_CLIENT_ID_HEADER:String = "DSDstClientId";
		/**
		 * Messages are tagged with the endpoint id for the Channel they are sent over.
		 *  Channels set this value automatically when they send a message.
		 */
		public static const ENDPOINT_HEADER:String = "DSEndpoint";
		/**
		 * This header is used to transport the global FlexClient Id value in outbound
		 *  messages once it has been assigned by the server.
		 */
		public static const FLEX_CLIENT_ID_HEADER:String = "DSId";
		/**
		 * Messages that need to set remote credentials for a destination
		 *  may also need to report the character-set encoding that was used to
		 *  create the credentials String using this header.
		 */
		public static const REMOTE_CREDENTIALS_CHARSET_HEADER:String = "DSRemoteCredentialsCharset";
		/**
		 * Messages that need to set remote credentials for a destination
		 *  carry the Base64 encoded credentials in this header.
		 */
		public static const REMOTE_CREDENTIALS_HEADER:String = "DSRemoteCredentials";
		/**
		 * Messages sent with a defined request timeout use this header.
		 *  The request timeout value is set on outbound messages by services or
		 *  channels and the value controls how long the corresponding MessageResponder
		 *  will wait for an acknowledgement, result or fault response for the message
		 *  before timing out the request.
		 */
		public static const REQUEST_TIMEOUT_HEADER:String = "DSRequestTimeout";
	}
}
