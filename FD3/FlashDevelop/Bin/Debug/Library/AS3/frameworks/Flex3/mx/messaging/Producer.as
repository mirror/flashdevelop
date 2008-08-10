/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import mx.messaging.messages.IMessage;
	public class Producer extends AbstractProducer {
		/**
		 * Provides access to the subtopic for the remote destination that the MessageAgent uses.
		 */
		public function get subtopic():String;
		public function set subtopic(value:String):void;
		/**
		 * Constructs a Producer.
		 */
		public function Producer();
		/**
		 * @param message           <IMessage> 
		 * @param waitForClientId   <Boolean (default = true)> 
		 */
		protected override function internalSend(message:IMessage, waitForClientId:Boolean = true):void;
	}
}
