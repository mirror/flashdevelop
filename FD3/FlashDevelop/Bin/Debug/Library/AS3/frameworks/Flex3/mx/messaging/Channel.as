package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.collections.ArrayCollection;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.config.LoaderConfig;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.InvalidChannelError;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.URLUtil;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.Channel;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.events.PropertyChangeEvent;

	/**
	 *  Dispatched after the channel has connected to its endpoint. * *  @eventType mx.messaging.events.ChannelEvent.CONNECT
	 */
	[Event(name="channelConnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after the channel has disconnected from its endpoint. * *  @eventType mx.messaging.events.ChannelEvent.DISCONNECT
	 */
	[Event(name="channelDisconnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after the channel has faulted. *  *  @eventType mx.messaging.events.ChannelFaultEvent.FAULT
	 */
	[Event(name="channelFault", type="mx.messaging.events.ChannelFaultEvent")] 
	/**
	 *  Dispatched when a channel receives a message from its endpoint. *  *  @eventType mx.messaging.events.MessageEvent.MESSAGE
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 
	/**
	 *  Dispatched when a property of the channel changes. *  *  @eventType mx.events.PropertyChangeEvent.PROPERTY_CHANGE
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  The Channel class is the base message channel class that all channels in the messaging *  system must extend. * *  <p>Channels are specific protocol-based conduits for messages sent between  *  MessageAgents and remote destinations. *  Preconfigured channels are obtained within the framework using the *  <code>ServerConfig.getChannel()</code> method. *  You can create a Channel directly using the <code>new</code> operator and *  add it to a ChannelSet directly.</p> *  *  <p> *  Channels represent a physical connection to a remote endpoint. *  Channels are shared across destinations by default. *  This means that a client targetting different destinations may use *  the same Channel to communicate with these destinations. *  </p> * *  <p><b>Note:</b> This class is for advanced use only. *  Use this class for creating custom channels like the existing RTMPChannel, *  AMFChannel, and HTTPChannel.</p>
	 */
	public class Channel extends EventDispatcher implements IMXMLObject
	{
		/**
		 *  @private	 *  Used to prevent multiple logouts.
		 */
		local var authenticating : Boolean;
		/**
		 *  @private     *  The credentials string that is passed via a CommandMessage to the server when the     *  Channel connects. Channels inherit the credentials of connected ChannelSets that     *  inherit their credentials from connected MessageAgents.      *  <code>MessageAgent.setCredentials(username, password)</code> is generally used     *  to set credentials.
		 */
		protected var credentials : String;
		/**
		 * @private     * A channel specific override to determine whether small messages should     * be used. If set to false, small messages will not be used even if they     * are supported by an endpoint.
		 */
		public var enableSmallMessages : Boolean;
		/**
		 *  @private	 *  Provides access to a logger for this channel.
		 */
		protected var _log : ILogger;
		/**
		 *  @private     *  Flag indicating whether the Channel is in the process of connecting.
		 */
		protected var _connecting : Boolean;
		/**
		 *  @private     *  Timer to track connect timeouts.
		 */
		private var _connectTimer : Timer;
		/**
		 *  @private	 *  Current index into failover URIs during a failover attempt.	 *  When not failing over, this variable is reset to a sentinal	 *  value of -1.
		 */
		private var _failoverIndex : int;
		/**
		 * @private     * Flag indicating whether the endpoint has been calculated from the uri.
		 */
		private var _isEndpointCalculated : Boolean;
		/**
		 * @private     * The messaging version implies which features are enabled on this client     * channel. Channel endpoints exchange this information through headers on     * the ping CommandMessage exchanged during the connection handshake.
		 */
		protected var messagingVersion : Number;
		/**
		 *  @private     *  Flag indicating whether this Channel owns the wait guard for managing initial connect attempts.
		 */
		private var _ownsWaitGuard : Boolean;
		/**
		 *  @private	 *  Primary URI; the initial URI for this channel.
		 */
		private var _primaryURI : String;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private	 *  Indicates whether this channel should be connected to its endpoint.	 *  This flag is used to control when fail over should be attempted.
		 */
		private var _shouldBeConnected : Boolean;
		/**
		 *  @private
		 */
		private var _channelSets : Array;
		/**
		 *  @private
		 */
		private var _connected : Boolean;
		/**
		 *  @private
		 */
		private var _connectTimeout : int;
		/**
		 *  @private
		 */
		private var _endpoint : String;
		/**
		 *  @private
		 */
		protected var _loginAfterDisconnect : Boolean;
		/**
		 * @private
		 */
		protected var _recordMessageTimes : Boolean;
		/**
		 * @private
		 */
		protected var _recordMessageSizes : Boolean;
		/**
		 *  @private
		 */
		private var _reconnecting : Boolean;
		/**
		 *  @private
		 */
		private var _failoverURIs : Array;
		/**
		 *  @private
		 */
		private var _id : String;
		private var _authenticated : Boolean;
		/**
		 *  @private
		 */
		private var _requestTimeout : int;
		/**
		 *  @private
		 */
		private var _uri : String;
		/**
		 * @private
		 */
		private var _smallMessagesSupported : Boolean;
		/**
		 * @private
		 */
		public static const SMALL_MESSAGES_FEATURE : String = "small_messages";
		/**
		 *  @private     *  Creates a compile time dependency on ArrayCollection to ensure     *  it is present for response data containing collections.
		 */
		private static const dep : ArrayCollection = null;

		/**
		 *  Provides access to the ChannelSets connected to the Channel.
		 */
		public function get channelSets () : Array;
		/**
		 *  Indicates whether this channel has established a connection to the 	 *  remote destination.
		 */
		public function get connected () : Boolean;
		/**
		 *  Provides access to the connect timeout in seconds for the channel.      *  A value of 0 or below indicates that a connect attempt will never      *  be timed out on the client.     *  For channels that are configured to failover, this value is the total     *  time to wait for a connection to be established.     *  It is not reset for each failover URI that the channel may attempt      *  to connect to.
		 */
		public function get connectTimeout () : int;
		/**
		 *  @private
		 */
		public function set connectTimeout (value:int) : void;
		/**
		 *  Provides access to the endpoint for this channel.	 *  This value is calculated based on the value of the <code>uri</code>	 *  property.
		 */
		public function get endpoint () : String;
		function get loginAfterDisconnect () : Boolean;
		/**
		 * Channel property determines the level of performance information injection - whether     * we inject timestamps or not.
		 */
		public function get recordMessageTimes () : Boolean;
		/**
		 * Channel property determines the level of performance information injection - whether     * we inject message sizes or not.
		 */
		public function get recordMessageSizes () : Boolean;
		/**
		 *  Indicates whether this channel is in the process of reconnecting to an     *  alternate endpoint.
		 */
		public function get reconnecting () : Boolean;
		/**
		 *  Provides access to the set of endpoint URIs that this channel can	 *  attempt to failover to if the endpoint is clustered.
		 */
		public function get failoverURIs () : Array;
		/**
		 *  @private
		 */
		public function set failoverURIs (value:Array) : void;
		/**
		 *  Provides access to the id of this channel.
		 */
		public function get id () : String;
		public function set id (value:String) : void;
		/**
		 *  Indicates if this channel is authenticated.
		 */
		public function get authenticated () : Boolean;
		/**
		 *  Provides access to the protocol that the channel uses.     *     *  <p><b>Note:</b> Subclasses of Channel must override this method and return      *  a string that represents their supported protocol.     *  Examples of supported protocol strings are "rtmp", "http" or "https".     * </p>
		 */
		public function get protocol () : String;
		/**
		 *  @private     *  Returns true if the channel supports realtime behavior via server push or client poll.
		 */
		function get realtime () : Boolean;
		/**
		 *  Provides access to the default request timeout in seconds for the      *  channel. A value of 0 or below indicates that outbound requests will      *  never be timed out on the client.     *  <p>Request timeouts are most useful for RPC style messaging that      *  requires a response from the remote destination.</p>
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;
		/**
		 *  Provides access to the URI used to create the whole endpoint URI for this channel. 	 *  The URI can be a partial path, in which case the full endpoint URI is computed as necessary.
		 */
		public function get uri () : String;
		public function set uri (value:String) : void;
		/**
		 * @private	 * This alternate property for an endpoint URL is provided to match the	 * endpoint configuration attribute &quot;url&quot;. This property is	 * equivalent to the <code>uri</code> property.
		 */
		public function get url () : String;
		/**
		 * @private
		 */
		public function set url (value:String) : void;
		/**
		 * This flag determines whether small messages should be sent if the     * alternative is available. This value should only be true if both the     * client channel and the server endpoint have successfully advertised that     * they support this feature.     * @private
		 */
		public function get useSmallMessages () : Boolean;
		/**
		 * @private
		 */
		public function set useSmallMessages (value:Boolean) : void;
		/**
		 * @private          * Should we record any performance metrics
		 */
		public function get mpiEnabled () : Boolean;

		/**
		 *  Constructs an instance of a generic Channel that connects to the	 *  specified endpoint URI.     *	 *  <b>Note</b>: The Channel type should not be constructed directly. Instead	 *  create instances of protocol specific subclasses such as RTMPChannel or	 *  AMFChannel.     *	 *  @param id The id of this channel.	 * 	 *  @param uri The endpoint URI for this channel.
		 */
		public function Channel (id:String = null, uri:String = null);
		/**
		 * @private
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  @private
		 */
		protected function setConnected (value:Boolean) : void;
		private function setReconnecting (value:Boolean) : void;
		function setAuthenticated (value:Boolean) : void;
		/**
		 *  Subclasses should override this method to apply any settings that may be     *  necessary for an individual channel.     *  Make sure to call <code>super.applySettings()</code> to apply common settings for the channel.     *     *  @param settings XML fragment of the services-config.xml file for this channel.     *  The following fragement includes the &lt;channel&gt; tag with     *  all of its configuration settings:     *  <pre>     *  &lt;channel id="my-amf" type="mx.messaging.channels.AMFChannel"&gt;     *    &lt;endpoint uri="/dev/messagebroker/amf" type="flex.messaging.endpoints.AmfEndpoint"/&gt;     *    &lt;properties&gt;     *      &lt;polling-enabled&gt;false&lt;/polling-enabled&gt;     *    &lt;/properties&gt;     *  &lt;/channel&gt;     *  </pre>
		 */
		public function applySettings (settings:XML) : void;
		/**
		 *  Connects the ChannelSet to the Channel. If the Channel has not yet	 *  connected to its endpoint, it attempts to do so.	 *  Channel subclasses must override the <code>internalConnect()</code> 	 *  method, and call the <code>connectSuccess()</code> method once the	 *  underlying connection is established.	 * 	 *  @param channelSet The ChannelSet to connect to the Channel.
		 */
		public function connect (channelSet:ChannelSet) : void;
		/**
		 *  Disconnects the ChannelSet from the Channel. If the Channel is connected	 *  to its endpoint and it has no more connected ChannelSets it will 	 *  internally disconnect.	 *	 *  <p>Channel subclasses need to override the 	 *  <code>internalDisconnect()</code> method, and call the	 *  <code>disconnectSuccess()</code> method when the underlying connection	 *  has been terminated.</p>	 * 	 *  @param channelSet The ChannelSet to disconnect from the Channel.
		 */
		public function disconnect (channelSet:ChannelSet) : void;
		/**
		 *  Sends a CommandMessage to the server to logout if the Channel is connected.	 *  Current credentials are cleared.	 * 	 *  @param agent The MessageAgent to logout.
		 */
		public function logout (agent:MessageAgent) : void;
		/**
		 *  Sends the specified message to its target destination.	 *  Subclasses must override the <code>internalSend()</code> method to	 *  perform the actual send.     *	 *  @param agent The MessageAgent that is sending the message.	 * 	 *  @param message The Message to send.	 * 	 *  @throws mx.messaging.errors.InvalidDestinationError If neither the MessageAgent nor the	 *                                  message specify a destination.
		 */
		public function send (agent:MessageAgent, message:IMessage) : void;
		/**
		 *  Sets the credentials to the specified value. 	 *  If the credentials are non-null and the Channel is connected, this method also	 *  sends a CommandMessage to the server to login using the credentials.	 * 	 *  @param credentials The credentials string.	 *  @param agent The MessageAgent to login, that will handle the login result.     *  @param charset The character set encoding used while encoding the     *  credentials. The default is null, which implies the legacy charset of     *  ISO-Latin-1.	 *	 *  @throws flash.errors.IllegalOperationError in two situations; if credentials	 *  have already been set and an authentication is in progress with the remote	 *  detination, or if authenticated and the credentials specified don't match	 *  the currently authenticated credentials.
		 */
		public function setCredentials (credentials:String, agent:MessageAgent = null, charset:String = null) : void;
		/**
		 *  @private     *  Internal hook for ChannelSet to assign credentials when it has authenticated     *  successfully via a direct <code>login(...)</code> call to the server.
		 */
		function internalSetCredentials (credentials:String) : void;
		/**
		 *  @private     *  This is a hook for ChannelSet (not a MessageAgent) to send requests for      *  clustered endpoints for a clustered destination and provide its own      *  custom responder, rather than relying on the generic responders used by      *  Channel implemenations.     *      *  @param msgResp The message responder to use for the cluster request response.
		 */
		function sendClusterRequest (msgResp:MessageResponder) : void;
		/**
		 *  Processes a failed internal connect and dispatches the 	 *  <code>FAULT</code> event for the channel.	 *  If the Channel has <code>failoverURI</code> values, it will	 *  attempt to reconnect automatically by trying these URI values in order until 	 *  a connection is established or the available values are exhausted.	 * 	 *  @param event The ChannelFaultEvent for the failed connect.
		 */
		protected function connectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  Processes a successful internal connect and dispatches the 	 *  <code>CONNECT</code> event for the Channel.
		 */
		protected function connectSuccess () : void;
		/**
		 *  Handles a connect timeout by dispatching a ChannelFaultEvent. 	 *  Subtypes may overide this to shutdown the current connect attempt but must 	 *  call <code>super.connectTimeoutHandler(event)</code>.	 * 	 *  @param event The timer event indicating that the connect timeout has been reached.
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  Processes a successful internal disconnect and dispatches the 	 *  <code>DISCONNECT</code> event for the Channel.	 *  If the disconnect is due to a network failure and the Channel has 	 *  <code>failoverURI</code> values, it will attempt to reconnect automatically 	 *  by trying these URI values in order until a connection is established or the 	 *  available values are exhausted.	 *  	 *  @param rejected True if the disconnect should skip any	 *         failover processing that would otherwise be attempted; false	 *         if failover processing should be allowed to run.
		 */
		protected function disconnectSuccess (rejected:Boolean = false) : void;
		/**
		 *  Processes a failed internal disconnect and dispatches the	 *  <code>FAULT</code> event for the channel.	 * 	 *  @param event The ChannelFaultEvent for the failed disconnect.
		 */
		protected function disconnectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  Handles a change to the guard condition for managing initial Channel connect for the application.	 *  When this is invoked it means that this Channel is waiting to attempt to connect.	 * 	 *  @param event The PropertyChangeEvent dispatched by the FlexClient singleton.
		 */
		protected function flexClientWaitHandler (event:PropertyChangeEvent) : void;
		/**
		 *  Returns the appropriate MessageResponder for the Channel's     *  <code>send()</code> method.     *  Must be overridden.     *     *  @param agent The MessageAgent sending the message.     *      *  @param message The Message to send.     *      *  @return The MessageResponder to handle the result or fault.     *      *  @throws flash.errors.IllegalOperationError If the Channel subclass does not override     *                                this method.
		 */
		protected function getMessageResponder (agent:MessageAgent, message:IMessage) : MessageResponder;
		/**
		 *  Connects the Channel to its endpoint.     *  Must be overridden.
		 */
		protected function internalConnect () : void;
		/**
		 *  Disconnects the Channel from its endpoint.      *  Must be overridden.     *      *  @param rejected True if the disconnect was due to a connection rejection or timeout     * 					and reconnection should not be attempted automatically; otherwise false.
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  Sends the Message out over the Channel and routes the response to the     *  responder.     *  Must be overridden.     *      *  @param messageResponder The MessageResponder to handle the response.
		 */
		protected function internalSend (messageResponder:MessageResponder) : void;
		/**
		 * @private     * Utility method to examine the reported server messaging version and     * thus determine which features are available.
		 */
		protected function handleServerMessagingVersion (version:Number) : void;
		/**
		 *  @private     *  Utility method used to assign the FlexClient Id value to outbound messages.     *      *  @param message The message to set the FlexClient Id on.
		 */
		protected function setFlexClientIdOnMessage (message:IMessage) : void;
		/**
		 *  @private        *  This method calculates the endpoint value based on the current     *  <code>uri</code>.
		 */
		private function calculateEndpoint () : void;
		/**
		 *  @private     *  Initializes the request timeout for this message if the outbound message      *  defines a REQUEST_TIMEOUT_HEADER value.      *  If this header is not set and the default requestTimeout for the      *  channel is greater than 0, the channel default is used.      *  Otherwise, no request timeout is enforced on the client.     *      *  @param messageResponder The MessageResponder to handle the response and monitor the outbound     *                          request for a timeout.
		 */
		private function initializeRequestTimeout (messageResponder:MessageResponder) : void;
		/**
		 *  @private     *  Convenience method to test whether the Channel should attempt to     *  failover.     *      *  @return <code>true</code> if the Channel should try to failover;     *          otherwise <code>false</code>.
		 */
		private function shouldAttemptFailover () : Boolean;
		/**
		 *  @private     *  This method attempts to fail the Channel over to the next available URI.
		 */
		private function failover () : void;
		/**
		 *  @private     *  This method is invoked by a timer from failover() and it works around a      *  reconnect issue with NetConnection based channels by invoking      *  internalConnect() after a slight delay.
		 */
		private function reconnect (event:TimerEvent) : void;
		/**
		 *  @private     *  This method resets the channel back to its primary URI after     *  exhausting all failover URIs.
		 */
		private function resetToPrimaryURI () : void;
		/**
		 *  @private     *  Shuts down and nulls out the connect timer.
		 */
		private function shutdownConnectTimer () : void;
	}
	/**
	 *  @private *  Responder for processing channel authentication responses.
	 */
	internal class AuthenticationMessageResponder extends MessageResponder
	{
		/**
		 *  @private     *  Reference to the logger for the associated Channel.
		 */
		private var _log : ILogger;

		public function AuthenticationMessageResponder (agent:MessageAgent, message:IMessage, channel:Channel, log:ILogger);
		/**
		 *  Handles an authentication result.     *      *  @param msg The result Message.
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  Handles an authentication failure.     *      *  @param msg The failure Message.
		 */
		protected function statusHandler (msg:IMessage) : void;
	}
}
