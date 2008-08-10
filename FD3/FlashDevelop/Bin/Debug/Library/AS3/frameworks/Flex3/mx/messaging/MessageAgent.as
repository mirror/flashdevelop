/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.ErrorMessage;
	public class MessageAgent extends EventDispatcher implements IMXMLObject {
		/**
		 * The type of MessageAgent.
		 *  This variable is used for logging and MUST be assigned by subclasses.
		 */
		protected var _agentType:String;
		/**
		 * The Base64 encoded credentials that will be passed through to
		 *  the ChannelSet.
		 */
		protected var _credentials:String;
		/**
		 * The character set encoding used to create the credentials String.
		 */
		protected var _credentialsCharset:String;
		/**
		 * Indicates whether the agent is explicitly disconnected.
		 *  This allows agents to supress processing of acks/faults that return
		 *  after the client has issued an explicit disconnect().
		 */
		protected var _disconnectBarrier:Boolean;
		/**
		 * Flag being set to true denotes that we should skip remaining fault
		 *  processing logic because the fault has already been handled.
		 *  Currently used during an automatic resend of a faulted message if the fault
		 *  was due to a server session timeout and is authentication/authorization related.
		 */
		protected var _ignoreFault:Boolean = false;
		/**
		 * The logger MUST be assigned by subclasses, for example
		 *  Consumer and Producer.
		 */
		protected var _log:ILogger;
		/**
		 * Indicates if this MessageAgent is using an authenticated connection to
		 *  its destination.
		 */
		public function get authenticated():Boolean;
		/**
		 * Provides access to the ChannelSet used by the MessageAgent. The
		 *  ChannelSet can be manually constructed and assigned, or it will be
		 *  dynamically initialized to use the configured Channels for the
		 *  destination for this MessageAgent.
		 */
		public function get channelSet():ChannelSet;
		public function set channelSet(value:ChannelSet):void;
		/**
		 * Provides access to the client id for the MessageAgent.
		 *  MessageAgents are assigned their client id by the remote destination
		 *  and this value is used to route messages from the remote destination to
		 *  the proper MessageAgent.
		 */
		public function get clientId():String;
		/**
		 * Indicates whether this MessageAgent is currently connected to its
		 *  destination via its ChannelSet. The propertyChange event is dispatched when
		 *  this property changes.
		 */
		public function get connected():Boolean;
		/**
		 * Provides access to the destination for the MessageAgent.
		 *  Changing the destination will disconnect the MessageAgent if it is
		 *  currently connected.
		 */
		public function get destination():String;
		public function set destination(value:String):void;
		/**
		 * Provides access to the request timeout in seconds for sent messages.
		 *  If an acknowledgement, response or fault is not received from the
		 *  remote destination before the timeout is reached the message is faulted on the client.
		 *  A value less than or equal to zero prevents request timeout.
		 */
		public function get requestTimeout():int;
		public function set requestTimeout(value:int):void;
		/**
		 * Constructor.
		 */
		public function MessageAgent();
		/**
		 * Invoked by a MessageResponder upon receiving a result for a sent
		 *  message. Subclasses may override this method if they need to perform
		 *  custom acknowledgement processing, but must invoke
		 *  super.acknowledge() as well. This method dispatches a
		 *  MessageAckEvent.
		 *
		 * @param ackMsg            <AcknowledgeMessage> The AcknowledgMessage returned.
		 * @param msg               <IMessage> The original sent message.
		 */
		public function acknowledge(ackMsg:AcknowledgeMessage, msg:IMessage):void;
		/**
		 * @param value             <String> 
		 */
		protected final function assertCredentials(value:String):void;
		/**
		 * Handles a CONNECT ChannelEvent. Subclasses that need to perform custom
		 *  processing should override this method, and invoke
		 *  super.channelConnectHandler().
		 *
		 * @param event             <ChannelEvent> The ChannelEvent.
		 */
		public function channelConnectHandler(event:ChannelEvent):void;
		/**
		 * Handles a DISCONNECT ChannelEvent. Subclasses that need to perform
		 *  custom processing should override this method, and invoke
		 *  super.channelDisconnectHandler().
		 *
		 * @param event             <ChannelEvent> The ChannelEvent.
		 */
		public function channelDisconnectHandler(event:ChannelEvent):void;
		/**
		 * Handles a ChannelFaultEvent. Subclasses that need to perform custom
		 *  processing should override this method, and invoke
		 *  super.channelFaultHandler().
		 *
		 * @param event             <ChannelFaultEvent> ChannelFaultEvent
		 */
		public function channelFaultHandler(event:ChannelFaultEvent):void;
		/**
		 * Disconnects the MessageAgent's network connection.
		 *  This method does not wait for outstanding network operations to complete.
		 */
		public function disconnect():void;
		/**
		 * Invoked by a MessageResponder upon receiving a fault for a sent message.
		 *  Subclasses may override this method if they need to perform custom fault
		 *  processing, but must invoke super.fault() as well. This
		 *  method dispatchs a MessageFaultEvent.
		 *
		 * @param errMsg            <ErrorMessage> The ErrorMessage.
		 * @param msg               <IMessage> The original sent message that caused this fault.
		 */
		public function fault(errMsg:ErrorMessage, msg:IMessage):void;
		/**
		 * Returns true if there are any pending requests for the passed in message.
		 *  This method should be overriden by subclasses
		 *
		 * @param msg               <IMessage> The message for which the existence of pending requests is checked.
		 */
		public function hasPendingRequestForMessage(msg:IMessage):Boolean;
		/**
		 * Used to automatically initialize the channelSet property for the
		 *  MessageAgent before it connects for the first time.
		 *  Subtypes may override to perform custom initialization.
		 *
		 * @param message           <IMessage> The message that needs to be sent.
		 */
		protected function initChannelSet(message:IMessage):void;
		/**
		 * Called after the implementing object has been created
		 *  and all properties specified on the tag have been assigned.
		 *
		 * @param document          <Object> MXML document that created this object.
		 * @param id                <String> id used by the document to refer to this object.
		 *                            If the object is a deep property on the document, id is null.
		 */
		public function initialized(document:Object, id:String):void;
		/**
		 * Sends a Message from the MessageAgent to its destination using the
		 *  agent's ChannelSet. MessageAgent subclasses must use this method to
		 *  send their messages.
		 *
		 * @param message           <IMessage> The message to send.
		 * @param waitForClientId   <Boolean (default = true)> If true the message may be queued until a clientId has been
		 *                            assigned to the agent. In general this is the desired behavior.
		 *                            For special behavior (automatic reconnect and resubscribe) the
		 *                            agent may pass false to override the default queuing behavior.
		 */
		protected function internalSend(message:IMessage, waitForClientId:Boolean = true):void;
		/**
		 * Logs the MessageAgent out from its remote destination.
		 *  Logging out of a destination applies to everything connected using the same ChannelSet
		 *  as specified in the server configuration. For example, if several DataService components
		 *  are connected over an RTMP channel and logout() is invoked on one of them,
		 *  all other client components that are connected using the same ChannelSet are also logged out.
		 */
		public function logout():void;
		/**
		 * This function should be overriden by sublasses to implement re-authorization due to
		 *  server session time-out behavior specific to them.  In general it should
		 *  follow disconnect, connect, re-send message pattern
		 *
		 * @param msg               <IMessage> The message that caused the fault and should be resent once we have
		 *                            disconnected/connected causing re-authentication.
		 */
		protected function reAuthorize(msg:IMessage):void;
		/**
		 * Sets the credentials that the MessageAgent uses to authenticate to
		 *  destinations.
		 *  The credentials are applied to all services connected over the same ChannelSet.
		 *
		 * @param username          <String> The username.
		 * @param password          <String> The password.
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            credentials. The default is null, which implies the legacy charset of
		 *                            ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public function setCredentials(username:String, password:String, charset:String = null):void;
		/**
		 * Sets the remote credentials that will be passed through to the remote destination
		 *  for authenticating to secondary systems.
		 *
		 * @param username          <String> The username.
		 * @param password          <String> The password.
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            remote credentials. The default is null, which implies the legacy
		 *                            charset of ISO-Latin-1. The only other currently supported option is
		 *                            "UTF-8".
		 */
		public function setRemoteCredentials(username:String, password:String, charset:String = null):void;
	}
}
