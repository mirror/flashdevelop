package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.channels.NetConnectionChannel;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.NoChannelAvailableError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.Base64Encoder;
	import mx.core.mx_internal;
	import mx.messaging.ChannelSet;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.logging.Log;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.rpc.AsyncToken;

	/**
	 *  Dispatched after a Channel in the ChannelSet has connected to its endpoint. * *  @eventType mx.messaging.events.ChannelEvent.CONNECT
	 */
	[Event(name="channelConnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after a Channel in the ChannelSet has disconnected from its  *  endpoint. * *  @eventType mx.messaging.events.ChannelEvent.DISCONNECT
	 */
	[Event(name="channelDisconnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after a Channel in the ChannelSet has faulted. *  *  @eventType mx.messaging.events.ChannelFaultEvent.FAULT
	 */
	[Event(name="channelFault", type="mx.messaging.events.ChannelFaultEvent")] 
	/**
	 * The result event is dispatched when a login or logout call successfully returns. * @eventType mx.rpc.events.ResultEvent.RESULT
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 * The fault event is dispatched when a login or logout call fails. * @eventType mx.rpc.events.FaultEvent.FAULT
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 
	/**
	 *  Dispatched when a property of the ChannelSet changes. *  *  @eventType mx.events.PropertyChangeEvent.PROPERTY_CHANGE
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  The ChannelSet is a set of Channels that are used to send messages to a *  target destination. The ChannelSet improves the quality of service on the  *  client by hunting through its Channels to send messages in the face of *  network failures or individual Channel problems.
	 */
	public class ChannelSet extends EventDispatcher
	{
		/**
		 *  @private     *  Helper MessageAgent used for direct authentication.
		 */
		private var _authAgent : AuthenticationAgent;
		/**
		 *  @private     *  Flag indicating whether the ChannelSet is in the process of connecting     *  over the current Channel.
		 */
		private var _connecting : Boolean;
		/**
		 *  @private     *  Stored credentials to be set on the member channels.
		 */
		private var _credentials : String;
		/**
		 *  @private     *  The character-set encoding used to create the credentials String.
		 */
		private var _credentialsCharset : String;
		/**
		 *  @private     *  Current index into the _channels/_channelIds arrays.
		 */
		private var _currentChannelIndex : int;
		/**
		 *  @private     *  This flag restricts our cluster request to only happen upon initial     *  connect to the cluster.
		 */
		private var _hasRequestedClusterEndpoints : Boolean;
		/**
		 *  @private     *  Flag indicating whether the ChannelSet is in the process of hunting to a     *  new Channel; this lets us control the "reconnecting" flag on      *  CONNECT ChannelEvents that we dispatch when we hunt to a new      *  Channel that isn't internally failing over. The new Channel doesn't know we're     *  in a reconnect attempt when it makes its initial connect attempt so this lets      *  us set "reconnecting" to true on the CONNECT event if it succeeds.
		 */
		private var _hunting : Boolean;
		/**
		 *  @private     *  A dictionary of pending messages used to filter out duplicate     *  messages passed to the ChannelSet to send while it is not connected.      *  This allows agents to perform message resend behavior (i.e. Consumer resubscribe     *  attempts) without worrying about duplicate messages queuing up and being sent to      *  the server once a connection is established.
		 */
		private var _pendingMessages : Dictionary;
		/**
		 *  @private     *  An array of PendingSend instances to pass into send() when a connection      *  is (re)established.
		 */
		private var _pendingSends : Array;
		/**
		 *  @private     *  A timer used to do a delayed reconnect for NetConnection channels.
		 */
		private var _reconnectTimer : Timer;
		/**
		 *  @private     *  Flag indicating whether the ChannelSet should be connected.      *  If true, the ChannelSet will attempt to hunt to the next available      *  Channel when a disconnect or fault occurs. If false, hunting is not      *  performed.
		 */
		private var _shouldBeConnected : Boolean;
		/**
		 *  @private     *  Flag indicating whether a Channel disconnect/fault should trigger hunting or not;     *  used when connected Channels are removed from the ChannelSet which should not trigger      *  hunting.
		 */
		private var _shouldHunt : Boolean;
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
		private var _channels : Array;
		/**
		 *  @private
		 */
		private var _channelIds : Array;
		/**
		 *  @private
		 */
		private var _currentChannel : Channel;
		/**
		 *  @private
		 */
		private var _channelFailoverURIs : Object;
		/**
		 *  @private
		 */
		private var _configured : Boolean;
		/**
		 *  @private
		 */
		private var _connected : Boolean;
		/**
		 *  @private
		 */
		private var _clustered : Boolean;
		/**
		 *  @private
		 */
		private var _initialDestinationId : String;
		/**
		 *  @private
		 */
		private var _messageAgents : Array;

		/**
		 *  Indicates whether the ChannelSet has an underlying Channel that successfully     *  authenticated with its endpoint.
		 */
		public function get authenticated () : Boolean;
		/**
		 *  Provides access to the Channels in the ChannelSet.     *  This property may be used to assign a set of channels at once or channels      *  may be added directly to the ChannelSet via addChannel() individually.     *  If this ChannelSet is <code>configured</code> automatically the individual     *  channels are created lazily and added to this property as needed.     *      *  @throws flash.errors.IllegalOperationError If the ChannelSet is      *             <code>configured</code>, assigning to this property is not allowed.
		 */
		public function get channels () : Array;
		/**
		 *  @private
		 */
		public function set channels (values:Array) : void;
		/**
		 *  The ids of the Channels used by the ChannelSet.
		 */
		public function get channelIds () : Array;
		/**
		 *  Returns the current Channel for the ChannelSet.
		 */
		public function get currentChannel () : Channel;
		/**
		 *  @private     *  Map of arrays of failoverURIs keyed by channel id for the Channels in this ChannelSet.      *  This property is assigned to by the ClusterMessageResponder in order to update the      *  member Channels with their failoverURIs.
		 */
		function get channelFailoverURIs () : Object;
		/**
		 *  @private
		 */
		function set channelFailoverURIs (value:Object) : void;
		/**
		 *  Indicates whether the ChannelSet is using automatically configured      *  Channels or manually assigned Channels.
		 */
		function get configured () : Boolean;
		/**
		 *  Indicates whether the ChannelSet is connected.
		 */
		public function get connected () : Boolean;
		/**
		 *  Indicates whether the ChannelSet targets a clustered destination.      *  If true, upon a successful connection the ChannelSet will query the      *  destination for all clustered endpoints for its Channels and will assign     *  failoverURIs to them.     *  Channel ids are used to assign failoverURIs to the proper Channel instances     *  so this requires that all Channels in the ChannelSet have non-null ids and an     *  Error will be thrown when this property is set to true if this is not the case.      *  If the ChannelSet is not using url load balancing on the client this      *  property should not be set to true.
		 */
		public function get clustered () : Boolean;
		/**
		 *  @private
		 */
		public function set clustered (value:Boolean) : void;
		/**
		 *  Provides access to the initial destination this ChannelSet is used to access.     *  When the clustered property is true, this value is used to request available failover URIs     *  for the configured channels for the destination.
		 */
		public function get initialDestinationId () : String;
		/**
		 *  @private
		 */
		public function set initialDestinationId (value:String) : void;
		/**
		 *  Provides access to the set of MessageAgents that use this ChannelSet.
		 */
		public function get messageAgents () : Array;

		/**
		 *  Constructs a ChannelSet.      *  If the <code>channelIds</code> argument is provided, the ChannelSet will      *  use automatically configured Channels obtained via <code>ServerConfig.getChannel()</code>      *  to reach a destination.      *  Attempting to manually assign Channels to a ChannelSet that uses configured     *  Channels is not allowed.     *       *  <p>If the <code>channelIds</code> argument is not provided or is null,      *  Channels must be manually created and added to the ChannelSet in order     *  to connect and send messages.</p>     *      *  <p>If the ChannelSet is clustered using url-load-balancing (where each server     *  declares a unique RTMP or HTTP URL and the client fails over from one URL to     *  the next), the first time that a Channel in the ChannelSet successfully connects     *  the ChannelSet will automatically make a request for all of the endpoints across      *  the cluster for all member Channels and will assign these failover URLs to each      *  respective Channel.     *  This allows Channels in the ChannelSet to failover individually, and when failover     *  options for a specific Channel are exhausted the ChannelSet will advance to the next      *  Channel in the set to attempt to reconnect.</p>     *      *  <p>Regardless of clustering, if a Channel cannot connect or looses     *  connectivity, the ChannelSet will advance to its next available Channel     *  and attempt to reconnect.     *  This allows the ChannelSet to hunt through Channels that use different      *  protocols, ports, etc., in search of one that can connect to its endpoint      *  successfully.</p>     *      *  @param channelIds The ids of configured Channels obtained from ServerConfig for this ChannelSet to     *                    use. If null, Channels must be manually added to the ChannelSet.     *      *  @param clusteredWithURLLoadBalancing True if the Channels in the ChannelSet are clustered     *                   using url load balancing.
		 */
		public function ChannelSet (channelIds:Array = null, clusteredWithURLLoadBalancing:Boolean = false);
		/**
		 *  @private
		 */
		function setAuthenticated (value:Boolean, creds:String, notifyAgents:Boolean = true) : void;
		/**
		 *  @private
		 */
		protected function setConnected (value:Boolean) : void;
		/**
		 *  Returns a String containing the ids of the Channels in the ChannelSet.     *      *  @return String representation of the ChannelSet.
		 */
		public function toString () : String;
		/**
		 *  Adds a Channel to the ChannelSet. A Channel with a null id cannot be added      *  to the ChannelSet if the ChannelSet targets a clustered destination.     *      *  @param channel The Channel to add.     *      *  @throws flash.errors.IllegalOperationError If the ChannelSet is      *             <code>configured</code>, adding a Channel is not supported.     *             This error is also thrown if the ChannelSet's <code>clustered</code> property     *             is <code>true</code> but the Channel has a null id.
		 */
		public function addChannel (channel:Channel) : void;
		/**
		 *  Removes a Channel from the ChannelSet. If the Channel to remove is      *  currently connected and being used by the ChannelSet, it is     *  disconnected as well as removed.     *      *  @param channel The Channel to remove.     *      *  @throws flash.errors.IllegalOperationError If the ChannelSet is      *             <code>configured</code>, removing a Channel is not supported.
		 */
		public function removeChannel (channel:Channel) : void;
		/**
		 *  Connects a MessageAgent to the ChannelSet. Once connected, the agent     *  can use the ChannelSet to send messages.     *      *  @param agent The MessageAgent to connect.
		 */
		public function connect (agent:MessageAgent) : void;
		/**
		 *  Disconnects a specific MessageAgent from the ChannelSet. If this is the     *  last MessageAgent using the ChannelSet and the current Channel in the set is      *  connected, the Channel will physically disconnect from the server.     *      *  @param agent The MessageAgent to disconnect.
		 */
		public function disconnect (agent:MessageAgent) : void;
		/**
		 *  Disconnects all associated MessageAgents and disconnects any underlying Channel that     *  is connected.     *  Unlike <code>disconnect(MessageAgent)</code> which is invoked by the disconnect implementations     *  of specific service components, this method provides a single, convenient point to shut down     *  connectivity between the client and server.
		 */
		public function disconnectAll () : void;
		/**
		 *  Handles a CONNECT ChannelEvent and redispatches the event.     *      *  @param event The ChannelEvent.
		 */
		public function channelConnectHandler (event:ChannelEvent) : void;
		/**
		 *  Handles a DISCONNECT ChannelEvent and redispatches the event.     *      *  @param event The ChannelEvent.
		 */
		public function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  Handles a ChannelFaultEvent and redispatches the event.     *      *  @param event The ChannelFaultEvent.
		 */
		public function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  Authenticates the ChannelSet with the server using the provided credentials.     *  Unlike other operations on Channels and the ChannelSet, this operation returns an      *  AsyncToken that client code may add a responder to in order to handle success or      *  failure directly.     *  If the ChannelSet is not connected to the server when this method is invoked it will      *  trigger a connect attempt, and if successful, send the login command to the server.     *  Only one login or logout operation may be pending at a time and overlapping calls will     *  generate an IllegalOperationError.     *  Invoking login when the ChannelSet is already authenticated will generate also generate     *  an IllegalOperationError.     *      *  @param username The username.     *  @param password The password.     *  @param charset The character set encoding to use while encoding the     *  credentials. The default is null, which implies the legacy charset of     *  ISO-Latin-1. The only other supported charset is &quot;UTF-8&quot;.     *     *  @return Returns a token that client code may add a responder to in order to handle     *  success or failure directly.     *      *  @throws flash.errors.IllegalOperationError in two situations; if the ChannelSet is     *          already authenticated, or if a login or logout operation is currently in progress.
		 */
		public function login (username:String, password:String, charset:String = null) : AsyncToken;
		/**
		 *  Logs the ChannelSet out from the server. Unlike other operations on Channels     *  and the ChannelSet, this operation returns an AsyncToken that client code may     *  add a responder to in order to handle success or failure directly.     *  If logout is successful any credentials that have been cached for use in     *  automatic reconnects are cleared for the ChannelSet and its Channels and their     *  authenticated state is set to false.     *  If the ChannelSet is not connected to the server when this method is invoked it     *  will trigger a connect attempt, and if successful, send a logout command to the server.     *     *  <p>The MessageAgent argument is present to support legacy logout behavior and client code that      *  invokes this method should not pass a MessageAgent reference. Just invoke <code>logout()</code>     *  passing no arguments.</p>     *     *  <p>This method is also invoked by service components from their <code>logout()</code>     *  methods, and these components pass a MessageAgent reference to this method when they logout.      *  The presence of this argument is the trigger to execute legacy logout behavior that differs      *  from the new behavior described above.      *  Legacy behavior only sends a logout request to the server if the client is connected     *  and authenticated.      *  If these conditions are not met the legacy behavior for this method is to do nothing other      *  than clear any credentials that have been cached for use in automatic reconnects.</p>     *       *  @param agent Legacy argument. The MessageAgent that is initiating the logout.     *       *  @return Returns a token that client code may     *  add a responder to in order to handle success or failure directly.     *      *  @throws flash.errors.IllegalOperationError if a login or logout operation is currently in progress.
		 */
		public function logout (agent:MessageAgent = null) : AsyncToken;
		/**
		 *  Sends a message from a MessageAgent over the currently connected Channel.     *      *  @param agent The MessageAgent sending the message.     *       *  @param message The Message to send.     *      *  @throws mx.messaging.errors.NoChannelAvailableError If the ChannelSet has no internal     *                                  Channels to use.
		 */
		public function send (agent:MessageAgent, message:IMessage) : void;
		/**
		 *  Stores the credentials and passes them through to every connected channel.     *     *  @param credentials The credentials for the MessageAgent.     *  @param agent The MessageAgent that is setting the credentials.     *  @param charset The character set encoding used while encoding the     *  credentials. The default is null, which implies the legacy encoding of     *  ISO-Latin-1.     *     *  @throws flash.errors.IllegalOperationError in two situations; if credentials     *  have already been set and an authentication is in progress with the remote     *  detination, or if authenticated and the credentials specified don't match     *  the currently authenticated credentials.
		 */
		public function setCredentials (credentials:String, agent:MessageAgent, charset:String = null) : void;
		/**
		 *  @private     *  Handles a successful login or logout operation for the ChannelSet.
		 */
		function authenticationSuccess (agent:AuthenticationAgent, token:AsyncToken, ackMessage:AcknowledgeMessage) : void;
		/**
		 *  @private     *  Handles a failed login or logout operation for the ChannelSet.
		 */
		function authenticationFailure (agent:AuthenticationAgent, token:AsyncToken, faultMessage:ErrorMessage) : void;
		/**
		 *  @private     *  Helper method to connect the current internal Channel.
		 */
		private function connectChannel () : void;
		/**
		 *  @private     *  Helper method to disconnect the current internal Channel.
		 */
		private function disconnectChannel () : void;
		/**
		 *  @private     *  Helper method to dispatch authentication-related RPC events.     *      *  @param event The event to dispatch.
		 */
		private function dispatchRPCEvent (event:AbstractEvent) : void;
		/**
		 *  @private     *  Redispatches message events from the currently connected Channel.     *      *  @param event The MessageEvent from the Channel.
		 */
		private function messageHandler (event:MessageEvent) : void;
		/**
		 *  @private     *  Helper method to hunt to the next available internal Channel for the     *  ChannelSet.     *      *  @return True if hunting to the next available Channel was successful; false if hunting     *          exhausted available channels and has reset to the beginning of the set.     *      *  @throws mx.messaging.errors.NoChannelAvailableError If the ChannelSet has no internal     *                                  Channels to use.
		 */
		private function hunt () : Boolean;
		/**
		 *  @private     *  This method is invoked by a timer and it works around a reconnect issue      *  with NetConnection based channels within a single frame by reconnecting after a slight delay.
		 */
		private function reconnectChannel (event:TimerEvent) : void;
		/**
		 *  @private     *  Helper method to fault pending messages.      *  The ErrorMessage is tagged with a __retryable__ header to indicate that      *  the error was due to connectivity problems on the client as opposed to      *  a server error response and the message can be retried (resent).     *      *  @param event A ChannelEvent.DISCONNECT or a ChannelFaultEvent that is the root cause     *               for faulting these pending sends.
		 */
		private function faultPendingSends (event:ChannelEvent) : void;
	}
	/**
	 *  @private *  Clustered ChannelSets need to request the clustered channel endpoints for *  the channels they contain upon a successful connect. However, Channels *  require that all outbound messages be sent by a MessageAgent that their  *  internal MessageResponder implementations can callback to upon a response *  or fault. The ChannelSet is not a MessageAgent, so in this case, it  *  circumvents the regular Channel.send() by passing its own custom responder *  to Channel.sendUsingCustomResponder(). *  *  This is the custom responder.
	 */
	internal class ClusterMessageResponder extends MessageResponder
	{
		/**
		 *  @private     *  Gives the responder access to this ChannelSet, to pass it failover URIs for     *  its channels.
		 */
		private var _channelSet : ChannelSet;

		/**
		 *  Constructor.
		 */
		public function ClusterMessageResponder (message:IMessage, channelSet:ChannelSet);
		/**
		 *  Handles a cluster message response.     *      *  @param message The response Message.
		 */
		protected function resultHandler (message:IMessage) : void;
	}
	/**
	 *  @private *  Stores a pending message to send when the ChannelSet does not have a *  connected Channel to use immediately.
	 */
	internal class PendingSend
	{
		/**
		 *  @private     *  The MessageAgent.
		 */
		public var agent : MessageAgent;
		/**
		 *  @private     *  The Message to send.
		 */
		public var message : IMessage;

		/**
		 *  @private     *  Constructor.     *      *  @param agent The MessageAgent sending the message.     *       *  @param msg The Message to send.
		 */
		public function PendingSend (agent:MessageAgent, message:IMessage);
	}
	/**
	 *  @private *  Helper class for handling and redispatching login and logout results or faults.
	 */
	internal class AuthenticationAgent extends MessageAgent
	{
		public static const LOGGED_OUT_STATE : int = 0;
		public static const LOGGING_IN_STATE : int = 1;
		public static const LOGGED_IN_STATE : int = 2;
		public static const LOGGING_OUT_STATE : int = 3;
		public static const SHUTDOWN_STATE : int = 4;
		/**
		 * Map of login/logout message Ids to associated tokens.
		 */
		private var tokens : Object;
		private var _state : int;

		/**
		 * Returns the current state for the agent.     * See the static state constants defined by this class.
		 */
		public function get state () : int;
		public function set state (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function AuthenticationAgent (channelSet:ChannelSet);
		/**
		 * Registers an outbound login/logout message and its associated token for response/fault handling.
		 */
		public function registerToken (token:AsyncToken) : void;
		/**
		 * Acknowledge message callback.
		 */
		public function acknowledge (ackMsg:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 * Fault callback.
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
	}
}
