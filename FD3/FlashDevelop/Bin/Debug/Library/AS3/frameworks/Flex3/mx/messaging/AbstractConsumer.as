/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	public class AbstractConsumer extends MessageAgent {
		/**
		 * Flag indicating whether this consumer should be subscribed or not.
		 */
		protected var _shouldBeSubscribed:Boolean;
		/**
		 * The number of resubscribe attempts that the Consumer makes in the event
		 *  that the destination is unavailable or the connection to the destination fails.
		 *  A value of -1 enables infinite attempts.
		 *  A value of zero disables resubscribe attempts.
		 */
		public function get resubscribeAttempts():int;
		public function set resubscribeAttempts(value:int):void;
		/**
		 * The number of milliseconds between resubscribe attempts.
		 *  If a Consumer doesn't receive an acknowledgement for a subscription
		 *  request, it will wait the specified number of milliseconds before
		 *  attempting to resubscribe.
		 *  Setting the value to zero disables resubscriptions.
		 */
		public function get resubscribeInterval():int;
		public function set resubscribeInterval(value:int):void;
		/**
		 * Indicates whether the Consumer is currently subscribed. The propertyChange
		 *  event is dispatched when this property changes.
		 */
		public function get subscribed():Boolean;
		/**
		 * Contains the timestamp of the most recent message this Consumer
		 *  has received.
		 *  This value is passed to the destination in a receive() call
		 *  to request that it deliver messages for the Consumer from the timestamp
		 *  forward.
		 *  All messages with a timestamp value greater than the
		 *  timestamp value will be returned during a poll operation.
		 *  Setting this value to -1 will retrieve all cached messages from the
		 *  destination.
		 */
		public function get timestamp():Number;
		public function set timestamp(value:Number):void;
		/**
		 * Constructs a Consumer.
		 */
		public function AbstractConsumer();
		/**
		 * Returns a subscribe message.
		 *  This method should be overridden by subclasses if they need custom
		 *  subscribe messages.
		 *
		 * @return                  <CommandMessage> The subscribe CommandMessage.
		 */
		protected function buildSubscribeMessage():CommandMessage;
		/**
		 * Returns an unsubscribe message.
		 *  This method should be overridden by subclasses if they need custom
		 *  unsubscribe messages.
		 *
		 * @param preserveDurable   <Boolean> - when true, durable JMS subscriptions are not destroyed
		 *                            allowing consumers to later resubscribe and receive missed messages
		 * @return                  <CommandMessage> The unsubscribe CommandMessage.
		 */
		protected function buildUnsubscribeMessage(preserveDurable:Boolean):CommandMessage;
		/**
		 * Disconnects the Consumer from its remote destination.
		 *  This method should be invoked on a Consumer that is no longer
		 *  needed by an application after unsubscribing.
		 *  This method does not wait for outstanding network operations to complete
		 *  and does not send an unsubscribe message to the server.
		 *  After invoking disconnect(), the Consumer will report that it is in an
		 *  disconnected, unsubscribed state because it will not receive any more
		 *  messages until it has reconnected and resubscribed.
		 *  Disconnecting stops automatic resubscription attempts if they are running.
		 */
		public override function disconnect():void;
		/**
		 * Requests any messages that are queued for this Consumer on the server.
		 *  This method should only be used for Consumers that subscribe over non-realtime,
		 *  non-polling channels.
		 *  This method is a no-op if the Consumer is not subscribed.
		 *
		 * @param timestamp         <Number (default = 0)> This argument is deprecated and is ignored.
		 */
		public function receive(timestamp:Number = 0):void;
		/**
		 * Subscribes to the remote destination.
		 *
		 * @param clientId          <String (default = null)> The client id to subscribe with. Use null for non-durable Consumers. If the subscription is durable, a consistent
		 *                            value must be supplied every time the Consumer subscribes in order
		 *                            to reconnect to the correct durable subscription in the remote destination.
		 */
		public function subscribe(clientId:String = null):void;
		/**
		 * Unsubscribes from the remote destination. In the case of durable JMS
		 *  subscriptions, this will destroy the durable subscription on the JMS server.
		 *
		 * @param preserveDurable   <Boolean (default = false)> - when true, durable JMS subscriptions are not destroyed
		 *                            allowing consumers to later resubscribe and receive missed messages
		 */
		public function unsubscribe(preserveDurable:Boolean = false):void;
	}
}
