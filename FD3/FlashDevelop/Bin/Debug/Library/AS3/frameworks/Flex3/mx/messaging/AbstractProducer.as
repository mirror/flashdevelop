/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import mx.messaging.messages.IMessage;
	public class AbstractProducer extends MessageAgent {
		/**
		 * If true the Producer automatically connects to its destination the
		 *  first time the send() method is called.
		 *  If false then the connect() method must be called explicitly to
		 *  establish a connection to the destination.
		 *  By default this property is true, but applications that need to operate
		 *  in an offline mode may set this to false to prevent the send() method
		 *  from connecting implicitly.
		 */
		public function get autoConnect():Boolean;
		public function set autoConnect(value:Boolean):void;
		/**
		 * The default headers to apply to messages sent by the Producer.
		 *  Any default headers that do not exist in the message will be created.
		 *  If the message already contains a matching header, the value in the
		 *  message takes precedence and the default header value is ignored.
		 */
		public function get defaultHeaders():Object;
		public function set defaultHeaders(value:Object):void;
		/**
		 * The number of reconnect attempts that the Producer makes in the event
		 *  that the destination is unavailable or the connection to the destination closes.
		 *  A value of -1 enables infinite attempts.
		 *  A value of zero disables reconnect attempts.
		 */
		public function get reconnectAttempts():int;
		public function set reconnectAttempts(value:int):void;
		/**
		 * The number of milliseconds between reconnect attempts.
		 *  If a Producer does not receive an acknowledgement for a connect
		 *  attempt, it will wait the specified number of milliseconds before
		 *  making a subsequent reconnect attempt.
		 *  Setting the value to zero disables reconnect attempts.
		 */
		public function get reconnectInterval():int;
		public function set reconnectInterval(value:int):void;
		/**
		 * Connects the Producer to its target destination.
		 *  When a connection is established the connected property will
		 *  change to true and this property is bindable and generates
		 *  PropertyChangeEvent events.
		 *  The underlying CLIENT_PING_OPERATION CommandMessage that is sent will result
		 *  in an acknowledge or fault event depending upon its success.
		 */
		public function connect():void;
		/**
		 * Disconnects the Producer from its remote destination.
		 *  This method does not wait for outstanding network operations to complete.
		 *  After invoking the disconnect() method, the Producer reports that it is not
		 *  connected and it will not receive any outstanding message acknowledgements or faults.
		 *  Disconnecting stops automatic reconnect attempts if they are running.
		 */
		public override function disconnect():void;
		/**
		 * Sends the specified message to its destination.
		 *  If the producer is being used for publish/subscribe messaging, only messages of type AsyncMessage
		 *  should be sent unless a custom message type is being used and the
		 *  message destination on the server has been configured to process the
		 *  custom message type.
		 *
		 * @param message           <IMessage> The message to send.
		 */
		public function send(message:IMessage):void;
	}
}
