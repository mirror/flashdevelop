package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.Log;
	import mx.messaging.channels.PollingChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when a message is received by the Consumer. * *  @eventType mx.messaging.events.MessageEvent.MESSAGE
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 

	/**
	 *  The AbstractConsumer is the base class for both the Consumer and *  MultiTopicConsumer classes.  You use those classes to receive pushed *  messages from the server.
	 */
	public class AbstractConsumer extends MessageAgent
	{
		/**
		 *  @private     *  This is the current number of resubscribe attempts that we've done.
		 */
		private var _currentAttempt : int;
		/**
		 *  @private     *  The timer used for resubscribe attempts.
		 */
		private var _resubscribeTimer : Timer;
		/**
		 *  Flag indicating whether this consumer should be subscribed or not.
		 */
		protected var _shouldBeSubscribed : Boolean;
		/**
		 *  @private     *  Current subscribe message - used for resubscribe attempts.
		 */
		private var _subscribeMsg : CommandMessage;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _resubscribeAttempts : int;
		/**
		 *  @private
		 */
		private var _resubscribeInterval : int;
		/**
		 *  @private
		 */
		private var _subscribed : Boolean;
		/**
		 *  @private
		 */
		private var _timestamp : Number;

		/**
		 *  @private     *  Updates the destination for this Consumer and resubscribes if the     *  Consumer is currently subscribed.
		 */
		public function set destination (value:String) : void;
		/**
		 *  The number of resubscribe attempts that the Consumer makes in the event	 *  that the destination is unavailable or the connection to the destination fails.	 *  A value of -1 enables infinite attempts.	 *  A value of zero disables resubscribe attempts.	 *  <p>	 *  Resubscribe attempts are made at a constant rate according to the resubscribe interval	 *  value. When a resubscribe attempt is made if the underlying channel for the Consumer is not	 *  connected or attempting to connect the channel will start a connect attempt.	 *  Subsequent Consumer resubscribe attempts that occur while the underlying	 *  channel connect attempt is outstanding are effectively ignored until	 *  the outstanding channel connect attempt succeeds or fails.	 *  </p>	 *	 *  @see mx.messaging.Consumer#resubscribeInterval
		 */
		public function get resubscribeAttempts () : int;
		/**
		 *  @private
		 */
		public function set resubscribeAttempts (value:int) : void;
		/**
		 *  The number of milliseconds between resubscribe attempts.	 *  If a Consumer doesn't receive an acknowledgement for a subscription	 *  request, it will wait the specified number of milliseconds before	 *  attempting to resubscribe.	 *  Setting the value to zero disables resubscriptions.	 *  <p>	 *  Resubscribe attempts are made at a constant rate according to this	 *  value. When a resubscribe attempt is made if the underlying channel for the Consumer is not	 *  connected or attempting to connect the channel will start a connect attempt.	 *  Subsequent Consumer resubscribe attempts that occur while the underlying	 *  channel connect attempt is outstanding are effectively ignored until	 *  the outstanding channel connect attempt succeeds or fails.	 *  </p>	 *	 *  @see mx.messaging.Consumer#resubscribeInterval	 *	 *  @throws ArgumentError If the assigned value is negative.
		 */
		public function get resubscribeInterval () : int;
		/**
		 *  @private
		 */
		public function set resubscribeInterval (value:int) : void;
		/**
		 *  Indicates whether the Consumer is currently subscribed. The <code>propertyChange</code>	 *  event is dispatched when this property changes.
		 */
		public function get subscribed () : Boolean;
		/**
		 *  Contains the timestamp of the most recent message this Consumer	 *  has received.	 *  This value is passed to the destination in a <code>receive()</code> call	 *  to request that it deliver messages for the Consumer from the timestamp	 *  forward.	 *  All messages with a timestamp value greater than the	 *  <code>timestamp</code> value will be returned during a poll operation.	 *  Setting this value to -1 will retrieve all cached messages from the	 *  destination.
		 */
		public function get timestamp () : Number;
		/**
		 *  @private
		 */
		public function set timestamp (value:Number) : void;

		/**
		 *  Constructs a Consumer.     *     *     *  @example     *  <listing version="3.0">     *   function initConsumer():void     *   {     *       var consumer:Consumer = new Consumer();     *       consumer.destination = "NASDAQ";     *       consumer.selector = "operation IN ('Bid','Ask')";     *       consumer.addEventListener(MessageEvent.MESSAGE, messageHandler);     *       consumer.subscribe();     *   }     *     *   function messageHandler(event:MessageEvent):void     *   {     *       var msg:IMessage = event.message;     *       var info:Object = msg.body;     *       trace("-App recieved message: " + msg.toString());     *   }     *   </listing>
		 */
		public function AbstractConsumer ();
		/**
		 *  @private     *  If our clientId has changed we may need to unsubscribe() using the     *  current clientId and then resubscribe using the new clientId.     *  // TODO - remove this?     *     *  @param value The clientId value.
		 */
		function setClientId (value:String) : void;
		/**
		 *  @private
		 */
		protected function setSubscribed (value:Boolean) : void;
		/**
		 *  @private     *  Custom processing for subscribe, unsubscribe and poll message     *  acknowledgments.     *     *  @param ackMsg The AcknowledgeMessage.     *     *  @param msg The original subscribe, unsubscribe or poll message.
		 */
		public function acknowledge (ackMsg:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 *  Disconnects the Consumer from its remote destination.	 *  This method should be invoked on a Consumer that is no longer	 *  needed by an application after unsubscribing.	 *  This method does not wait for outstanding network operations to complete	 *  and does not send an unsubscribe message to the server.	 *  After invoking disconnect(), the Consumer will report that it is in an	 *  disconnected, unsubscribed state because it will not receive any more	 *  messages until it has reconnected and resubscribed.	 *  Disconnecting stops automatic resubscription attempts if they are running.
		 */
		public function disconnect () : void;
		/**
		 *  @private     *  The Consumer supresses ErrorMessage processing if the error is     *  retryable and it is configured to resubscribe.     *     *  @param errMsg The ErrorMessage describing the fault.     *     *  @param msg The original message (generally a subscribe).
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
		/**
		 *  @private     *  Custom processing to warn the user if the consumer is connected over     *  a non-real channel.     *     *  @param event The ChannelEvent.
		 */
		public function channelConnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private     *  Custom processing to start up a resubscribe timer if our channel is     *  disconnected when we should be subscribed.     *     *  @param event The ChannelEvent.
		 */
		public function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private	 *  Custom processing to start up a resubscribe timer if our channel faults	 *  when we should be subscribed.	 *	 *  @param event The ChannelFaultEvent.
		 */
		public function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  Requests any messages that are queued for this Consumer on the server.	 *  This method should only be used for Consumers that subscribe over non-realtime,	 *  non-polling channels.	 *  This method is a no-op if the Consumer is not subscribed.	 *	 *  @param timestamp This argument is deprecated and is ignored.
		 */
		public function receive (timestamp:Number = 0) : void;
		/**
		 *  Subscribes to the remote destination.	 *	 *  @param clientId The client id to subscribe with. Use null for non-durable Consumers. If the subscription is durable, a consistent	 *                  value must be supplied every time the Consumer subscribes in order	 *                  to reconnect to the correct durable subscription in the remote destination.	 *	 *  @throws mx.messaging.errors.InvalidDestinationError If no destination is set.
		 */
		public function subscribe (clientId:String = null) : void;
		/**
		 *  Unsubscribes from the remote destination. In the case of durable JMS     *  subscriptions, this will destroy the durable subscription on the JMS server.     *     *  @param preserveDurable - when true, durable JMS subscriptions are not destroyed	 * 		allowing consumers to later resubscribe and receive missed messages
		 */
		public function unsubscribe (preserveDurable:Boolean = false) : void;
		/**
		 *  @private	 *  Consumers subscribe for messages from a destination and this is the handler	 *  method that is invoked when a message for this Consumer is pushed or polled	 *  from the server.	 *	 *  @param event The MessageEvent.
		 */
		function messageHandler (event:MessageEvent) : void;
		/**
		 *  Returns a subscribe message.	 *  This method should be overridden by subclasses if they need custom	 *  subscribe messages.	 *	 *  @return The subscribe CommandMessage.
		 */
		protected function buildSubscribeMessage () : CommandMessage;
		/**
		 *  Returns an unsubscribe message.	 *  This method should be overridden by subclasses if they need custom	 *  unsubscribe messages.	 *	 *  @param preserveDurable - when true, durable JMS subscriptions are not destroyed	 * 			allowing consumers to later resubscribe and receive missed messages	 *	 *  @return The unsubscribe CommandMessage.
		 */
		protected function buildUnsubscribeMessage (preserveDurable:Boolean) : CommandMessage;
		/**
		 *  @private     *  Attempt to resubscribe.     *  This can be called directly or from a Timer's event handler.     *     *  @param event The timer event for resubscribe attempts.
		 */
		protected function resubscribe (event:TimerEvent) : void;
		/**
		 *  @private     *  This method will start a timer which attempts to resubscribe     *  periodically.
		 */
		protected function startResubscribeTimer () : void;
		/**
		 * @private     * Stops a resubscribe timer if one is running.
		 */
		protected function stopResubscribeTimer () : void;
	}
}
