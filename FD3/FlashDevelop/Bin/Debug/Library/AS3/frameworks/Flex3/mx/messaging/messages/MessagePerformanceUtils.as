package mx.messaging.messages
{
	import mx.messaging.messages.MessagePerformanceInfo;

	/**
	 * The MessagePerformanceUtils utility class is used to retrieve various metrics about     * the sizing and timing of a message sent from a client to the server and its      * response message, as well as pushed messages from the server to the client.       * Metrics are gathered when corresponding properties on the channel used are enabled:     * &lt;record-message-times&gt; denotes capturing of timing information,     * &lt;record-message-sizes&gt; denotes capturing of sizing information.     *      * <p>You can then use methods of this utility class to retrieve various performance information     * about the message that you have just received.</p>     *      * <p>When these metrics are enabled an instance of this class should be created from      * a response, acknowledgement, or message handler via something like: </p>     * @example     * <pre>     *      var mpiutil:MessagePerformanceUtils = new MessagePerformanceUtils(event.message);     * </pre>         *
	 */
	public class MessagePerformanceUtils
	{
		/**
		 * @private          *          * Information about the original message sent out by the client
		 */
		public var mpii : MessagePerformanceInfo;
		/**
		 * @private          *          * Information about the response message sent back to the client
		 */
		public var mpio : MessagePerformanceInfo;
		/**
		 * @private          *          * If this is a pushed message, information about the original message         * that caused the push
		 */
		public var mpip : MessagePerformanceInfo;
		/**
		 * @private          *          * Header for MPI of original message sent by client
		 */
		public static const MPI_HEADER_IN : String = "DSMPII";
		/**
		 * @private          *          * Header for MPI of response message sent to the client
		 */
		public static const MPI_HEADER_OUT : String = "DSMPIO";
		/**
		 * @private          *          * Header for MPI of a message that caused a pushed message
		 */
		public static const MPI_HEADER_PUSH : String = "DSMPIP";

		/**
		 * Time between this client sending a message and receiving a response         * for it from the server         *          * @return Total time in milliseconds
		 */
		public function get totalTime () : Number;
		/**
		 * Time between server receiving the client message and either the time         * the server responded to the received message or had the pushed message ready         * to be sent to the receiving client.           *          * @return Server processing time in milliseconds
		 */
		public function get serverProcessingTime () : Number;
		/**
		 * Time between server receiving the client message and the server beginning to push         * messages out to other clients as a result of the original message.           *          * @return Server pre-push processing time in milliseconds
		 */
		public function get serverPrePushTime () : Number;
		/**
		 * Time spent in the adapter associated with the destination for this message before         * either the response to the message was ready or the message had been prepared         * to be pushed to the receiving client.           *          * @return Server adapter processing time in milliseconds
		 */
		public function get serverAdapterTime () : Number;
		/**
		 * Time spent in a module invoked from the adapter associated with the destination for this message          * but external to it, before either the response to the message was ready or the message had been          * prepared to be pushed to the receiving client.           *          * @return Server adapter-external processing time in milliseconds
		 */
		public function get serverAdapterExternalTime () : Number;
		/**
		 * @return Time that the message waited on the server after it was ready to be pushed to the client         * but had not yet been polled for.
		 */
		public function get serverPollDelay () : Number;
		/**
		 * Server processing time spent outside of the adapter associated with the destination of this message         *          * @return Non-adapter server processing time in milliseconds
		 */
		public function get serverNonAdapterTime () : Number;
		/**
		 * The network round trip time for a client message and the server response to it,         * calculated by the difference between total time and server processing time         *          * @return Network round trip time in milliseconds
		 */
		public function get networkRTT () : Number;
		/**
		 * Timestamp in milliseconds since epoch of when the server sent a response message back         * to the client         *          * @return Timestamp in milliseconds since epoch
		 */
		public function get serverSendTime () : Number;
		/**
		 * Timestamp in milliseconds since epoch of when the client received response message from         * the server         *          * @return Timestamp in milliseconds since epoch
		 */
		public function get clientReceiveTime () : Number;
		/**
		 * The size of the original client message as measured during deserialization by the server         * endpoint         *          * @return Message size in Bytes
		 */
		public function get messageSize () : int;
		/**
		 * The size of the response message sent to the client by the server as measured during serialization         * at the server endpoint         *          * @return Message size in Bytes
		 */
		public function get responseMessageSize () : int;
		/**
		 * Returns true if message was pushed to the client and is not a response to a message that         * originated on the client         *          * @return true if this message was pushed to the client and is not a response to a message that         * originated on the client
		 */
		public function get pushedMessageFlag () : Boolean;
		/**
		 * Only populated in the case of a pushed message, this is the time between the push causing client         * sending its message and the push receving client receiving it.  Note that the two clients'         * clocks must be in sync for this to be meaningful.         *          * @return Total push time in milliseconds
		 */
		public function get totalPushTime () : Number;
		/**
		 * Only populated in the case of a pushed message, this is the network time between         * the server pushing the message and the client receiving it.  Note that the server         * and client clocks must be in sync for this to be meaningful.         *          * @return One way server push time in milliseconds
		 */
		public function get pushOneWayTime () : Number;
		/**
		 * Only populated in the case of a pushed message, timestamp in milliseconds since epoch of          * when the client that caused a push message sent its message.         *          * @return Timestamp in milliseconds since epoch
		 */
		public function get originatingMessageSentTime () : Number;
		/**
		 * Only populated in the case of a pushed message, size in Bytes of the message that originally         * caused this pushed message         *          * @return Pushed causer message size in Bytes
		 */
		public function get originatingMessageSize () : Number;
		/**
		 * @private         *          * Overhead time in milliseconds for processing of the push causer message
		 */
		private function get pushedOverheadTime () : Number;

		/**
		 * Constructor         *          * Creates an MPUtils instance with information from the MPI headers         * of the passed in message         *          * @param message The message whose MPI headers will be used in retrieving         * MPI information
		 */
		public function MessagePerformanceUtils (message:Object);
		/**
		 * Method returns a summary of all information available in MPI.  A suggested use of this         * is something like,         * @example         * <listing version="3.0">         *      var mpiutil:MessagePerformanceUtils = new MessagePerformanceUtils(message);                              *      Alert.show(mpiutil.prettyPrint(), "MPI Output", Alert.NONMODAL);         * </listing>                     *          * @return String containing a summary of all information available in MPI
		 */
		public function prettyPrint () : String;
	}
}
