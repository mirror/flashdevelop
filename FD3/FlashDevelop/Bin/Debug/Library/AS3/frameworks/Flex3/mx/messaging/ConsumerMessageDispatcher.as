package mx.messaging
{
	import flash.utils.Dictionary;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.events.MessageEvent;

	/**
	 *  @private *  *  Helper class that listens for MessageEvents dispatched by ChannelSets that Consumers are subscribed over. *  This class is necessary because the server maintains queues of messages to push to this Flex client on a *  per-endpoint basis but the client may create more than one Channel that connects to a single server endpoint. *  In this scenario, messages can be pushed/polled to the client over a different channel instance than the one  *  that the target Consumer subscribed over. The server isn't aware of this difference because both channels are  *  pointed at the same endpoint. Here's a diagram to illustrate. *  *  Client: *               Consumer 1           Consumer 2    Consumer 3 *                  |                       |       / *               ChannelSet 1            ChannelSet 2 *                  |                       | *               Channel 1               Channel 2  <- The endpoint URIs for these two channels are identical *                  |                       | *                  \_______________________/ *  Server:                     | *                              | *                          Endpoint (that the two channels point to) *                              | *                  FlexClientOutboundQueue (for this endpoint for this FlexClient) *                              \-- Outbound messages for the three Consumer subscriptions *  *  When the endpoint receives a poll request from Channel 1 it will return queued messages for all three subscriptions *  but back on the client when Channel 1 dispatches message events for Consumer 2 and 3's subscriptions they won't see *  them because they're directly connected to the separate Channel2/ChannelSet2. *  This helper class keeps track of Consumer subscriptions and watches all ChannelSets for message events to  *  ensure they're dispatched to the proper Consumer even when the client has been manually (miss)configured as the *  diagram illustrates. *   *  This class is a singleton that maintains a table of all subscribed Consumers and ref-counts the number of active *  subscriptions per ChannelSet to determine whether it needs to be listening for message events from a given  *  ChannelSet or not; it dispatches message events from these ChannelSets to the proper Consumer instance *  by invoking the Consumer's messageHandler() method directly.
	 */
	public class ConsumerMessageDispatcher
	{
		/**
		 *  @private	 *  The sole instance of this singleton class.
		 */
		private static var _instance : ConsumerMessageDispatcher;
		/**
		 *  Lookup table for subscribed Consumer instances; Object<Consumer clientId, Consumer>     *  This is used to dispatch pushed/polled messages to the proper Consumer instance.
		 */
		private const _consumers : Object;
		/**
		 *  Table used to prevent duplicate delivery of messages to a Consumer when multiple ChannelSets are     *  connected to the same server endpoint over a single, underlying shared Channel.
		 */
		private const _consumerDuplicateMessageBarrier : Object;

		/**
		 *  Returns the sole instance of this singleton class,	 *  creating it if it does not already exist.
		 */
		public static function getInstance () : ConsumerMessageDispatcher;
		/**
		 *  Constructor.	 *  Use getInstance() instead of "new" to create.
		 */
		public function ConsumerMessageDispatcher ();
		/**
		 *  Registers a Consumer subscription.     *  This will cause the ConsumerMessageDispatcher to start listening for MessageEvents     *  from the underlying ChannelSet used to subscribe and redispatch messages to Consumers.
		 */
		public function registerSubscription (consumer:AbstractConsumer) : void;
		/**
		 *  Unregisters a Consumer subscription.     *  The ConsumerMessageDispatcher will stop monitoring underlying channels for messages for     *  this Consumer.
		 */
		public function unregisterSubscription (consumer:AbstractConsumer) : void;
		/**
		 *  Handles message events from ChannelSets that Consumers are subscribed over.     *  We just need to redirect the event to the proper Consumer instance.
		 */
		private function messageHandler (event:MessageEvent) : void;
	}
}
