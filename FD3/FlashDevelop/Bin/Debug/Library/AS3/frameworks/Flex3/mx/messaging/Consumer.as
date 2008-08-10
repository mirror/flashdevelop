/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import mx.messaging.messages.IMessage;
	public class Consumer extends AbstractConsumer {
		/**
		 * The selector for the Consumer.
		 *  This is an expression that is passed to the destination which uses it
		 *  to filter the messages delivered to the Consumer.
		 */
		public function get selector():String;
		public function set selector(value:String):void;
		/**
		 * Provides access to the subtopic for the remote destination that the MessageAgent uses.
		 */
		public function get subtopic():String;
		public function set subtopic(value:String):void;
		/**
		 * Constructs a Consumer.
		 *
		 * @param messageType       <String (default = "flex.messaging.messages.AsyncMessage")> The alias for the message type processed by the service
		 *                            hosting the remote destination the Consumer will subscribe to.
		 *                            This parameter is deprecated and it is ignored by the
		 *                            constructor.
		 */
		public function Consumer(messageType:String = "flex.messaging.messages.AsyncMessage");
		/**
		 * @param message           <IMessage> 
		 * @param waitForClientId   <Boolean (default = true)> 
		 */
		protected override function internalSend(message:IMessage, waitForClientId:Boolean = true):void;
	}
}
