package mx.messaging
{
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.FlexClient;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageAckEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.MessagePerformanceUtils;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.Base64Encoder;
	import mx.utils.UIDUtil;

	/**
	 *  Dispatched when an acknowledge message is received for a sent message. * *  @eventType mx.messaging.events.MessageAckEvent.ACKNOWLEDGE
	 */
	[Event(name="acknowledge", type="mx.messaging.events.MessageAckEvent")] 
	/**
	 *  Dispatched when a message fault occurs. *  *  @eventType mx.messaging.events.MessageFaultEvent.FAULT
	 */
	[Event(name="fault", type="mx.messaging.events.MessageFaultEvent")] 
	/**
	 *  Dispatched when the underlying Channel the MessageAgent is using connects. * *  @eventType mx.messaging.events.ChannelEvent.CONNECT
	 */
	[Event(name="channelConnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched when the underlying Channel the MessageAgent is using disconnects. * *  @eventType mx.messaging.events.ChannelEvent.DISCONNECT
	 */
	[Event(name="channelDisconnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched when the underlying Channel the MessageAgent is using faults. *  *  @eventType mx.messaging.events.ChannelFaultEvent.FAULT
	 */
	[Event(name="channelFault", type="mx.messaging.events.ChannelFaultEvent")] 
	/**
	 *  Dispatched when the <code>connected</code> property of the MessageAgent changes. *  Also dispatched when the <code>subscribed</code> of a Consumer changes. *  @see mx.messaging.Consumer *  @eventType mx.events.PropertyChangeEvent.PROPERTY_CHANGE
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  The MessageAgent class provides the basic low-level functionality common to *  message handling for a destination. * *  <p><b>Note:</b> For advanced use only. *  Use this class for creating custom message agents like the existing Producer *  and Consumer classes.</p> * *  @mxml *  <p> *  All message agent classes, including the Producer and Consumer classes, extend *  MessageAgent and inherit the following tag attributes: *  </p> *  <pre> *   &lt;mx:<i>tagname</i><br> *    <b>Properties</b> *    channelSet="<i>No default.</i>"   *    clientId="<i>No default.</i>" *    connected="<i>false</i>" *    destination="<i>No default.</i>" *    requestTimeout="<i>-1</i>" *    subtopic="<i>No default.</i>" *  * *   <b>Events</b> *    acknowledge="<i>No default.</i>" *    channelConnect="<i>No default.</i>" *    channelDisconnect="<i>No default.</i>" *    channelFault="<i>No default.</i>" *    fault="<i>No default.</i>" *    propertyChange="<i>No default.</i>"   *  /&gt; *  </pre>
	 */
	public class MessageAgent extends EventDispatcher implements IMXMLObject
	{
		/**
		 *  @private     *  Indicates that the MessageAgent is used an automatically configured ChannelSet     *  obtained from ServerConfig.
		 */
		static const AUTO_CONFIGURED_CHANNELSET : int = 0;
		/**
		 *  @private     *  Indicates that the MessageAgent is using a manually assigned ChannelSet.
		 */
		static const MANUALLY_ASSIGNED_CHANNELSET : int = 1;
		/**
		 *  @private     *  The type of MessageAgent.     *  This variable is used for logging and MUST be assigned by subclasses.
		 */
		protected var _agentType : String;
		/**
		 *  @private     *  The Base64 encoded credentials that will be passed through to     *  the ChannelSet.
		 */
		protected var _credentials : String;
		/**
		 *  @private     *  The character set encoding used to create the credentials String.
		 */
		protected var _credentialsCharset : String;
		/**
		 *  @private     *  Indicates whether the agent is explicitly disconnected.     *  This allows agents to supress processing of acks/faults that return     *  after the client has issued an explicit disconnect().
		 */
		protected var _disconnectBarrier : Boolean;
		/**
		 *  @private     *  This helps in the runtime configuration setup by delaying the connect     *  event until the configuration has been setup. See acknowledge().
		 */
		private var _pendingConnectEvent : ChannelEvent;
		/**
		 *  @private     *  The Base64 encoded credentials that are passed through to a      *  3rd party.
		 */
		private var _remoteCredentials : String;
		/**
		 *  @private     *  The character set encoding used to create the remoteCredentials String.
		 */
		private var _remoteCredentialsCharset : String;
		/**
		 *  @private     *  Indicates that the remoteCredentials value has changed and should     *  be sent to the server.
		 */
		private var _sendRemoteCredentials : Boolean;
		/**
		 *  @private     *  The logger MUST be assigned by subclasses, for example     *  Consumer and Producer.
		 */
		protected var _log : ILogger;
		/**
		 *  @private     *  A queue to store pending outbound messages while waiting for a server response     *  that contains a server-generated clientId.     *  Serializing messages from a MessageAgent to the server is essential until we     *  receive a response containing a server-generated clientId; otherwise the server     *  will treat each message as if it was sent by a different, "new" MessageAgent instance.
		 */
		private var _clientIdWaitQueue : Array;
		/**
		 *  @private     * Flag being set to true denotes that we should skip remaining fault     * processing logic because the fault has already been handled.       * Currently used during an automatic resend of a faulted message if the fault     * was due to a server session timeout and is authentication/authorization related.
		 */
		protected var _ignoreFault : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _authenticated : Boolean;
		/**
		 *  @private
		 */
		private var _channelSet : ChannelSet;
		/**
		 *  @private
		 */
		private var _clientId : String;
		/**
		 *  @private
		 */
		private var _connected : Boolean;
		/**
		 *  @private
		 */
		private var _destination : String;
		/**
		 *  @private
		 */
		private var _id : String;
		/**
		 *  @private
		 */
		private var _requestTimeout : int;
		/**
		 *  @private
		 */
		private var _channelSetMode : int;
		/**
		 *  @private     *  Indicates whether the agent has requested configuration from the server.
		 */
		local var configRequested : Boolean;
		/**
		 * @private
		 */
		private var _needsConfig : Boolean;

		/**
		 *  Indicates if this MessageAgent is using an authenticated connection to      *  its destination.
		 */
		public function get authenticated () : Boolean;
		/**
		 *  Provides access to the ChannelSet used by the MessageAgent. The     *  ChannelSet can be manually constructed and assigned, or it will be      *  dynamically initialized to use the configured Channels for the     *  destination for this MessageAgent.
		 */
		public function get channelSet () : ChannelSet;
		/**
		 *  @private
		 */
		public function set channelSet (value:ChannelSet) : void;
		/**
		 *  Provides access to the client id for the MessageAgent.     *  MessageAgents are assigned their client id by the remote destination     *  and this value is used to route messages from the remote destination to     *  the proper MessageAgent.
		 */
		public function get clientId () : String;
		/**
		 *  Indicates whether this MessageAgent is currently connected to its     *  destination via its ChannelSet. The <code>propertyChange</code> event is dispatched when     *  this property changes.
		 */
		public function get connected () : Boolean;
		/**
		 *  Provides access to the destination for the MessageAgent.      *  Changing the destination will disconnect the MessageAgent if it is     *  currently connected.     *     *  @throws mx.messaging.errors.InvalidDestinationError If the destination is null or      *                                  zero-length.
		 */
		public function get destination () : String;
		/**
		 *  @private
		 */
		public function set destination (value:String) : void;
		/**
		 *  @private     *  The id of this agent.
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  Provides access to the request timeout in seconds for sent messages.     *  If an acknowledgement, response or fault is not received from the      *  remote destination before the timeout is reached the message is faulted on the client.     *  A value less than or equal to zero prevents request timeout.
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;
		function get channelSetMode () : int;
		/**
		 *  Indicates if this MessageAgent needs to request configuration from the      *  server.
		 */
		function get needsConfig () : Boolean;
		/**
		 *  @private
		 */
		function set needsConfig (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function MessageAgent ();
		/**
		 *  @private
		 */
		function setAuthenticated (value:Boolean, creds:String) : void;
		/**
		 *  @private     *  This method is called by ChannelSet.connect(agent) to set up the bidirectional     *  relationship between the MessageAgent and the ChannelSet.     *  It also handles the case of customer code calling channelSet.connect(agent)     *  directly rather than assigning the ChannelSet to the MessageAgent's channelSet      *  property.
		 */
		function internalSetChannelSet (value:ChannelSet) : void;
		/**
		 *  @private     *  This method is used to assign a server-generated client id to the MessageAgent     *  in the common scenario.     *  It may also be used by the framework to sync up cooperating MessageAgents under     *  a single client id value so that they appear as a single MessageAgent to the server.     *  Assigning a client id value will flush any messages that have been queued while we     *  were waiting for a server-generated client id value to be returned.     *  Queued messages are sent to the server in order.
		 */
		function setClientId (value:String) : void;
		/**
		 *  @private
		 */
		protected function setConnected (value:Boolean) : void;
		/**
		 *  Invoked by a MessageResponder upon receiving a result for a sent     *  message. Subclasses may override this method if they need to perform     *  custom acknowledgement processing, but must invoke     *  <code>super.acknowledge()</code> as well. This method dispatches a      *  MessageAckEvent.     *      *  @param ackMsg The AcknowledgMessage returned.     *      *  @param msg The original sent message.
		 */
		public function acknowledge (ackMsg:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 *  Disconnects the MessageAgent's network connection.     *  This method does not wait for outstanding network operations to complete.
		 */
		public function disconnect () : void;
		/**
		 *  Invoked by a MessageResponder upon receiving a fault for a sent message.     *  Subclasses may override this method if they need to perform custom fault     *  processing, but must invoke <code>super.fault()</code> as well. This     *  method dispatchs a MessageFaultEvent.     *     *  @param errMsg The ErrorMessage.     *      *  @param msg The original sent message that caused this fault.
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
		/**
		 * This function should be overriden by sublasses to implement re-authorization due to      * server session time-out behavior specific to them.  In general it should     * follow disconnect, connect, re-send message pattern     *      *  @param msg The message that caused the fault and should be resent once we have     *  disconnected/connected causing re-authentication.
		 */
		protected function reAuthorize (msg:IMessage) : void;
		/**
		 *  Handles a CONNECT ChannelEvent. Subclasses that need to perform custom     *  processing should override this method, and invoke      *  <code>super.channelConnectHandler()</code>.     *      *  @param event The ChannelEvent.
		 */
		public function channelConnectHandler (event:ChannelEvent) : void;
		/**
		 *  Handles a DISCONNECT ChannelEvent. Subclasses that need to perform     *  custom processing should override this method, and invoke     *  <code>super.channelDisconnectHandler()</code>.     *      *  @param event The ChannelEvent.
		 */
		public function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  Handles a ChannelFaultEvent. Subclasses that need to perform custom     *  processing should override this method, and invoke     *  <code>super.channelFaultHandler()</code>.     *      *  @param The ChannelFaultEvent
		 */
		public function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  Called after the implementing object has been created     *  and all properties specified on the tag have been assigned.     *     *  @param document MXML document that created this object.     *     *  @param id id used by the document to refer to this object.     *  If the object is a deep property on the document, id is null.
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  Logs the MessageAgent out from its remote destination.      *  Logging out of a destination applies to everything connected using the same ChannelSet     *  as specified in the server configuration. For example, if several DataService components     *  are connected over an RTMP channel and <code>logout()</code> is invoked on one of them,      *  all other client components that are connected using the same ChannelSet are also logged out.
		 */
		public function logout () : void;
		/**
		 *  Sets the credentials that the MessageAgent uses to authenticate to      *  destinations.     *  The credentials are applied to all services connected over the same ChannelSet.      *      *  @param username The username.     *  @param password The password.     *  @param charset The character set encoding to use while encoding the     *  credentials. The default is null, which implies the legacy charset of     *  ISO-Latin-1. The only other supported charset is &quot;UTF-8&quot;.     *     *  @throws flash.errors.IllegalOperationError in two situations; if credentials     *  have already been set and an authentication is in progress with the remote     *  detination, or if authenticated and the credentials specified don't match     *  the currently authenticated credentials.
		 */
		public function setCredentials (username:String, password:String, charset:String = null) : void;
		/**
		 *  Sets the remote credentials that will be passed through to the remote destination     *  for authenticating to secondary systems.     *      *  @param username The username.     *  @param password The password.     *  @param charset The character set encoding to use while encoding the     *  remote credentials. The default is null, which implies the legacy     *  charset of ISO-Latin-1. The only other currently supported option is     *  &quot;UTF-8&quot;.
		 */
		public function setRemoteCredentials (username:String, password:String, charset:String = null) : void;
		/**
		 * Returns true if there are any pending requests for the passed in message.    * This method should be overriden by subclasses    *     * @param msg The message for which the existence of pending requests is checked.    *    * @return Returns <code>true</code> if there are any pending requests for the     * passed in message.
		 */
		public function hasPendingRequestForMessage (msg:IMessage) : Boolean;
		/**
		 *  @private     *  Internal hook for ChannelSet to assign credentials when it has authenticated     *  successfully via a direct <code>login(...)</code> call to the server or logged     *  out directly.
		 */
		function internalSetCredentials (credentials:String) : void;
		/**
		 *  @private
		 */
		protected function assertCredentials (value:String) : void;
		/**
		 *  @private     *  Utility method to flush any pending queued messages to send once we have     *  received a clientId from the remote destination.
		 */
		protected function flushClientIdWaitQueue () : void;
		/**
		 *  Sends a Message from the MessageAgent to its destination using the     *  agent's ChannelSet. MessageAgent subclasses must use this method to     *  send their messages.     *      *  @param message The message to send.     *      *  @param waitForClientId If true the message may be queued until a clientId has been     *                         assigned to the agent. In general this is the desired behavior.     *                         For special behavior (automatic reconnect and resubscribe) the     *                         agent may pass false to override the default queuing behavior.     *      *  @throws mx.messaging.errors.InvalidDestinationError If no destination is set.
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
		/**
		 *  Used to automatically initialize the <code>channelSet</code> property for the     *  MessageAgent before it connects for the first time.      *  Subtypes may override to perform custom initialization.     *      *  @param message The message that needs to be sent.
		 */
		protected function initChannelSet (message:IMessage) : void;
	}
}
