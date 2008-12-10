package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  Dispatched when a message is received by the Consumer. * *  @eventType mx.messaging.events.MessageEvent.MESSAGE
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 

	/**
	 *  A Consumer subscribes to a destination to receive messages. *  Consumers send subscribe and unsubscribe messages which generate a MessageAckEvent *  or MessageFaultEvent depending upon whether the operation was successful or not. *  Once subscribed, a Consumer dispatches a MessageEvent for each message it receives. *  Consumers provide the ability to filter messages using a selector. *  These selectors must be understood by the destination. *  @mxml *  <p> *  The &lt;mx:Consumer&gt; tag inherits all the tag attributes of its superclass, and adds the following tag attributes: *  </p> *  <pre> *   &lt;mx:Consumer *    <b>Properties</b> *    resubscribeAttempts="<i>5</i>" *    resubscribeInterval="<i>5000</i>" *    selector="<i>No default.</i>" *    timestamp="<i>No default.</i>" *  /&gt; *  </pre>
	 */
	public class Consumer extends AbstractConsumer
	{
		/**
		 *  @private
		 */
		private var _selector : String;
		/**
		 *  @private
		 */
		private var _subtopic : String;

		/**
		 *  The selector for the Consumer. 	 *  This is an expression that is passed to the destination which uses it	 *  to filter the messages delivered to the Consumer.	 * 	 *  <p>Before a call to the <code>subscribe()</code> method, this property 	 *  can be set with no side effects. 	 *  After the Consumer has subscribed to its destination, changing this 	 *  value has the side effect of updating the Consumer's subscription to 	 *  use the new selector expression immediately.</p>	 * 	 *  <p>The remote destination must understand the value of the selector 	 *  expression.</p>
		 */
		public function get selector () : String;
		/**
		 *  @private
		 */
		public function set selector (value:String) : void;
		/**
		 *  Provides access to the subtopic for the remote destination that the MessageAgent uses.
		 */
		public function get subtopic () : String;
		/**
		 *  Setting the subtopic when the Consumer is connected and	 *  subscribed has the side effect of unsubscribing and resubscribing	 *  the Consumer.
		 */
		public function set subtopic (value:String) : void;

		/**
		 *  Constructs a Consumer.     *      *  @param messageType The alias for the message type processed by the service     *                     hosting the remote destination the Consumer will subscribe to.     *                     This parameter is deprecated and it is ignored by the     *                     constructor.     *      *  @example     *  <listing version="3.0">     *   function initConsumer():void     *   {     *       var consumer:Consumer = new Consumer();     *       consumer.destination = "NASDAQ";     *       consumer.selector = "operation IN ('Bid','Ask')";     *       consumer.addEventListener(MessageEvent.MESSAGE, messageHandler);     *       consumer.subscribe();     *   }     *     *   function messageHandler(event:MessageEvent):void     *   {     *       var msg:IMessage = event.message;     *       var info:Object = msg.body;     *       trace("-App recieved message: " + msg.toString());     *   }     *   </listing>
		 */
		public function Consumer (messageType:String = "flex.messaging.messages.AsyncMessage");
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
	}
}
