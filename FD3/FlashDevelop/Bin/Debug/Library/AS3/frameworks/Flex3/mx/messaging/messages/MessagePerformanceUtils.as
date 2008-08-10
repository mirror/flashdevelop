/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class MessagePerformanceUtils {
		/**
		 * The number of milliseconds since the start of the Unix epoch,
		 *  January 1, 1970, 00:00:00 GMT, to when the client received response message from the server.
		 */
		public function get clientReceiveTime():Number;
		/**
		 * The size of the original client message, in bytes,
		 *  as measured during deserialization by the server endpoint.
		 */
		public function get messageSize():int;
		/**
		 * The duration, in milliseconds, from when a client sent a message to the server
		 *  until it received a response, excluding the server processing time.
		 *  This value is calculated as totalTime - serverProcessingTime.
		 */
		public function get networkRTT():Number;
		/**
		 * The timestamp, in milliseconds since the start of the Unix epoch on
		 *  January 1, 1970, 00:00:00 GMT, to when the client that caused a push message sent its message.
		 *  Only populated in the case of a pushed message, but not for an acknowledge message.
		 */
		public function get originatingMessageSentTime():Number;
		/**
		 * Size, in bytes, of the message that originally caused this pushed message.
		 *  Only populated in the case of a pushed message, but not for an acknowledge message.
		 */
		public function get originatingMessageSize():Number;
		/**
		 * Contains true if the message was pushed to the client
		 *  but is not a response to a message that originated on the client.
		 *  For example, when the client polls the server for a message,
		 *  pushedMessageFlag is false.
		 *  When you are using a streaming channel, pushedMessageFlag is true.
		 *  For an acknowledge message, pushedMessageFlag is false.
		 */
		public function get pushedMessageFlag():Boolean;
		/**
		 * Time, in milliseconds, from when the server pushed the message
		 *  until the client received it.
		 *  Note that this value is only relevant if the server and receiving client
		 *  have synchronized clocks.
		 *  Only populated in the case of a pushed message, but not for an acknowledge message.
		 */
		public function get pushOneWayTime():Number;
		/**
		 * The size, in bytes, of the response message sent to the client by the server
		 *  as measured during serialization at the server endpoint.
		 */
		public function get responseMessageSize():int;
		/**
		 * Time, in milliseconds, spent in a module invoked from the adapter associated
		 *  with the destination for this message, before either the response to the message
		 *  was ready or the message had been prepared to be pushed to the receiving client.
		 *  This corresponds to the time that the message was processed by the server,
		 *  excluding the time it was processed by your custom code, as defined by the value in
		 *  the serverAdapterTime property.
		 */
		public function get serverAdapterExternalTime():Number;
		/**
		 * Processing time, in milliseconds, of the message by the adapter
		 *  associated with the destination before either the response to
		 *  the message was ready or the message has been prepared to be pushed
		 *  to the receiving client.
		 *  This corresponds to the time that the message was processed by your code
		 *  on the server.
		 */
		public function get serverAdapterTime():Number;
		/**
		 * Server processing time spent outside of the adapter associated with
		 *  the destination of this message.
		 *  Calculated as serverProcessingTime - serverAdapterTime.
		 */
		public function get serverNonAdapterTime():Number;
		/**
		 * Time, in milliseconds, that this message sat on the server after it was ready
		 *  to be pushed to this client but before it was picked up by a poll request.
		 *  For an RTMP channel, this value is always 0.
		 */
		public function get serverPollDelay():Number;
		/**
		 * Time, in milliseconds, between the server receiving the client message
		 *  and the server beginning to push the message out to other clients.
		 */
		public function get serverPrePushTime():Number;
		/**
		 * Time, in milliseconds, between server receiving the client message and
		 *  either the time the server responded to the received message or has
		 *  the pushed message ready to be sent to a receiving client.
		 *  For example, for an acknowledge message, this is the time from when the server receives
		 *  a message from the producer and sends the acknowledge message back to the producer.
		 *  For a consumer that uses polling, it is the time between the arrival of
		 *  the consumer?s polling message and any message returned in response to the poll.
		 */
		public function get serverProcessingTime():Number;
		/**
		 * The number of milliseconds since the start of the Unix epoch,
		 *  January 1, 1970, 00:00:00 GMT, to when the server sent a response message back to the client.
		 */
		public function get serverSendTime():Number;
		/**
		 * Time, in milliseconds, from when the originating client sent a message
		 *  and the time that the receiving client received the pushed message.
		 *  Note that this value is only relevant if the two clients have synchronized clocks.
		 *  Only populated in the case of a pushed message, but not for an acknowledge message,
		 */
		public function get totalPushTime():Number;
		/**
		 * Time, in milliseconds, between this client sending a message and
		 *  receiving a response from the server.
		 *  This property contains 0 for an RTMP channel.
		 */
		public function get totalTime():Number;
		/**
		 * Constructor.
		 *  Creates an MessagePerformanceUtils instance with information from
		 *  the message received by the client.
		 *
		 * @param message           <Object> The message received from the server.
		 *                            This can be a message pushed from the server, or an acknowledge message received
		 *                            by the client after the client pushed a message to the server.
		 */
		public function MessagePerformanceUtils(message:Object);
		/**
		 * The prettyPrint() method returns a formatted String containing all
		 *  non-zero and non-null properties of the class.
		 *
		 * @return                  <String> String containing a summary of all available non-zero and non-null metrics.
		 */
		public function prettyPrint():String;
	}
}
