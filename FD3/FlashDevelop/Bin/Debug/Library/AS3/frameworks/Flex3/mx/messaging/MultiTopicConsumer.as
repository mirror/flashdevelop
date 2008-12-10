package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	import mx.events.CollectionEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  Dispatched when a message is received by the Consumer. * *  @eventType mx.messaging.events.MessageEvent.MESSAGE
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 

	/**
	 *  Like a Consumer, a MultiTopicConsumer subscribes to a destination with a single *  clientId and delivers messages to a single event handler.  Unlike a Consumer *  it lets you register subscriptions for a list of subtopics and selector expressions *  at the same time from a single message handler.  Where Consumer has subtopic and selector properties, *  this component has an addSubscription(subtopic, selector) method you use to  *  add a new subscription to the existing set of subscriptions.  Alternatively, you can *  populate the subscriptions property with a list of SubscriptionInfo instances that *  define the subscriptions for this destination. *  <p> *  Like the regular Consumer, the MultiTopicConsumer sends subscribe and unsubscribe  *  messages which generate a MessageAckEvent or MessageFaultEvent depending upon whether the  *  operation was successful or not. *  Once subscribed, a MultiTopicConsumer dispatches a MessageEvent for each message it receives.</p> *  @mxml *  <p> *  The &lt;mx:MultiTopicConsumer&gt; tag has these properties: *  </p> *  <pre> *   &lt;mx:Consumer *    <b>Properties</b> *    subscriptions="<i>"an empty ArrayCollection of SubscriptionInfo objects</i>" *    resubscribeAttempts="<i>5</i>" *    resubscribeInterval="<i>5000</i>" *    timestamp="<i>No default.</i>" *  /&gt; *  </pre>
	 */
	public class MultiTopicConsumer extends AbstractConsumer
	{
		/**
		 *  @private
		 */
		private var _subscriptions : ArrayCollection;
		/**
		 * This is a map where the keys are string names of the form subtopic + separator + selector     * registered with the boolean true.  When we generate a subscription message and     * send it to the server, we add/remove those subscriptions from this list.  Thus this     * list tracks the subscriptions we have sent to the server.
		 */
		private var _currentSubscriptions : Object;
		/**
		 * Used when the subscriptions property changes so we batch all changes made in one     * frame into a single multi-subscription message
		 */
		private var _subchangeTimer : Timer;

		/**
		 *  Stores an Array of SubscriptionInfo objects.  Each subscription     *  contains a subtopic and a selector each of which can be null.     *  A subscription with a non-null subtopic restricts the subscription     *  to messages delivered with only that subtopic.     *  If a subtopic is null, it uses the selector with no subtopic.     *  If the selector and the subtopic is null, the subscription receives     *  any messages targeted at the destination with no subtopic.     *  The subtopic can contain a wildcard specification.     *      *  <p>Before a call to the <code>subscribe()</code> method, this property      *  can be set with no side effects.      *  After the MultiTopicConsumer has subscribed to its destination, changing this      *  value has the side effect of updating the MultiTopicConsumer's subscription to      *  include any new subscriptions and remove any subscriptions you deleted from     *  the ArrayCollection.</p>     *      *  <p>The remote destination must understand the value of the selector      *  expression.</p>
		 */
		public function get subscriptions () : ArrayCollection;
		/**
		 * Provide a new subscriptions array collection.  This should be an ArrayCollection     * containing SubscriptionInfo instances which define message topics and selectors     * you want received by this consumer.
		 */
		public function set subscriptions (value:ArrayCollection) : void;

		/**
		 *  Constructs a MultiTopicConsumer.     *      *      *  @example     *  <listing version="3.0">     *   function initConsumer():void     *   {     *       var consumer:Consumer = new MultiTopicConsumer();     *       consumer.destination = "NASDAQ";     *       consumer.addEventListener(MessageEvent.MESSAGE, messageHandler);     *       consumer.addSubscription("myStock1", "operation IN ('BID', 'Ask')");     *       consumer.addSubscription("myStock2", "operation IN ('BID', 'Ask')");     *       consumer.subscribe();     *   }     *     *   function messageHandler(event:MessageEvent):void     *   {     *       var msg:IMessage = event.message;     *       var info:Object = msg.body;     *       trace("-App recieved message: " + msg.toString());     *   }     *   </listing>
		 */
		public function MultiTopicConsumer ();
		/**
		 * This is a convenience method for adding a new subscription.  It just creates     * a new SubscriptionInfo object and adds it to the subscriptions property.     * To call this method, you provide the     * subtopic and selector string for the new subscription.  If the subtopic is null,     * the subscription applies to messages which do not have a subtopic set in the     * producer.  If the selector string is null, all messages sent which match the     * subtopic string are received by this consumer.       *     * @param subtopic The subtopic for the new subscription.     *     * @param selector The selector for the new subscription.
		 */
		public function addSubscription (subtopic:String = null, selector:String = null) : void;
		/**
		 * This method removes the subscription specified by the subtopic     * and selector.     *     * @param subtopic The subtopic for the subscription.     *     * @param selector The selector for the subscription.
		 */
		public function removeSubscription (subtopic:String = null, selector:String = null) : void;
		/**
		 * Returns a subscribe message.     *     * @return The subscribe CommandMessage.
		 */
		protected function buildSubscribeMessage () : CommandMessage;
		/**
		 * Returns an unsubscribe mesage.     *     * @param preserveDurable When true, durable JMS subscriptions are     * not destroyed, allowing consumers to later resubscribe and     * receive missed messages.     *     * @return The unsubscribe CommandMessage.
		 */
		protected function buildUnsubscribeMessage (preserveDurable:Boolean) : CommandMessage;
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
		/**
		 * @private
		 */
		protected function setSubscribed (value:Boolean) : void;
		private function getCurrentSubscriptions () : Object;
		private function subscriptionsChangeHandler (event:CollectionEvent) : void;
		private function doResubscribe (event:TimerEvent) : void;
	}
}
