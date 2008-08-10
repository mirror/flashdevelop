/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import mx.collections.ArrayCollection;
	import mx.messaging.messages.IMessage;
	public class MultiTopicConsumer extends AbstractConsumer {
		/**
		 * Stores an Array of SubscriptionInfo objects.  Each subscription
		 *  contains a subtopic and a selector each of which can be null.
		 *  A subscription with a non-null subtopic restricts the subscription
		 *  to messages delivered with only that subtopic.
		 *  If a subtopic is null, it uses the selector with no subtopic.
		 *  If the selector and the subtopic is null, the subscription receives
		 *  any messages targeted at the destination with no subtopic.
		 *  The subtopic can contain a wildcard specification.
		 */
		public function get subscriptions():ArrayCollection;
		public function set subscriptions(value:ArrayCollection):void;
		/**
		 * Constructs a MultiTopicConsumer.
		 */
		public function MultiTopicConsumer();
		/**
		 * This is a convenience method for adding a new subscription.  It just creates
		 *  a new SubscriptionInfo object and adds it to the subscriptions property.
		 *  To call this method, you provide the
		 *  subtopic and selector string for the new subscription.  If the subtopic is null,
		 *  the subscription applies to messages which do not have a subtopic set in the
		 *  producer.  If the selector string is null, all messages sent which match the
		 *  subtopic string are received by this consumer.
		 *
		 * @param subtopic          <String (default = null)> 
		 * @param selector          <String (default = null)> 
		 */
		public function addSubscription(subtopic:String = null, selector:String = null):void;
		/**
		 */
		protected override function buildSubscribeMessage():CommandMessage;
		/**
		 * @param preserveDurable   <Boolean> 
		 */
		protected override function buildUnsubscribeMessage(preserveDurable:Boolean):CommandMessage;
		/**
		 * @param message           <IMessage> 
		 * @param waitForClientId   <Boolean (default = true)> 
		 */
		protected override function internalSend(message:IMessage, waitForClientId:Boolean = true):void;
		/**
		 * This method removes the subscription specified by the subtopic and selector.
		 *
		 * @param subtopic          <String (default = null)> 
		 * @param selector          <String (default = null)> 
		 */
		public function removeSubscription(subtopic:String = null, selector:String = null):void;
		/**
		 * @param value             <Boolean> 
		 */
		protected override function setSubscribed(value:Boolean):void;
	}
}
