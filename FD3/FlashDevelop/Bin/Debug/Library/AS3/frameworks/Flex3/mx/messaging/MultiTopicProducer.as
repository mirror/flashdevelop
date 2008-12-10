package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  A MultiTopicProducer sends messages to a destination with zero or more subtopics. *  It is like the regular Producer but it can direct the message to any consumer who *  is subscribing to any one of a number of subtopics.  If the consumer is a  *  MultiTopicConsumer and that consumer has subscribed to more than on subtopic in the *  list of subtopics used by the producer, the consumer only receives the message once. *  <p> *  The MultiTopicProducer will dispatch a MessageAckEvent or MessageFaultEvent  *  for each message they send depending upon whether the outbound message *  was sent and processed successfully or not. *  </p>
	 */
	public class MultiTopicProducer extends AbstractProducer
	{
		/**
		 *  @private
		 */
		private var _subtopics : ArrayCollection;

		/**
		 *  Provides access to the list of subtopics used in publishing any messages
		 */
		public function get subtopics () : ArrayCollection;
		/**
		 * Provide a new ArrayCollection of Strings each of which define a subtopic     * for use in publishing the message.  Any consumers subscribed to any of the     * subtopics will receive these messages.
		 */
		public function set subtopics (value:ArrayCollection) : void;

		/**
		 *  Constructs a Producer.     *      *  @example     *  <listing version="3.0">     *   function sendMessage():void     *   {     *       var producer:MultiTopicProducer = new MultiTopicProducer();     *       producer.destination = "NASDAQ";     *       var msg:AsyncMessage = new AsyncMessage();     *       msg.headers.operation = "UPDATE";     *       msg.body = {"SYMBOL":50.00};     *       // only send to subscribers to subtopic "SYMBOL" and "ALLSTOCKS"     *       msg.addSubtopic("SYMBOL");     *       msg.addSubtopic("ALLSTOCKS");     *       producer.send(msg);     *   }     *   </listing>
		 */
		public function MultiTopicProducer ();
		/**
		 * Adds a subtopic to the current list of subtopics for messages sent by this     * producer.  This is a shortcut to adding this subtopic to the subtopics     * property.     *     * @param subtopic The subtopic to add to the current list of     * subtopics sent by this producer.     *
		 */
		public function addSubtopic (subtopic:String) : void;
		/**
		 * Removes the subtopic from the subtopics property.  Throws an error if the     * subtopic is not in the list.     *     * @param subtopic The subtopic to remove from the subtopics property.
		 */
		public function removeSubtopic (subtopic:String) : void;
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
	}
}
