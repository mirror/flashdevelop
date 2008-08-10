/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import flash.events.EventDispatcher;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.IMessage;
	public class ChannelSet extends EventDispatcher {
		/**
		 * Indicates whether the ChannelSet has an underlying Channel that successfully
		 *  authenticated with its endpoint.
		 */
		public function get authenticated():Boolean;
		/**
		 * The ids of the Channels used by the ChannelSet.
		 */
		public function get channelIds():Array;
		/**
		 * Provides access to the Channels in the ChannelSet.
		 *  This property may be used to assign a set of channels at once or channels
		 *  may be added directly to the ChannelSet via addChannel() individually.
		 *  If this ChannelSet is configured automatically the individual
		 *  channels are created lazily and added to this property as needed.
		 */
		public function get channels():Array;
		public function set channels(value:Array):void;
		/**
		 * Indicates whether the ChannelSet targets a clustered destination.
		 *  If true, upon a successful connection the ChannelSet will query the
		 *  destination for all clustered endpoints for its Channels and will assign
		 *  failoverURIs to them.
		 *  Channel ids are used to assign failoverURIs to the proper Channel instances
		 *  so this requires that all Channels in the ChannelSet have non-null ids and an
		 *  Error will be thrown when this property is set to true if this is not the case.
		 *  If the ChannelSet is not using url load balancing on the client this
		 *  property should not be set to true.
		 */
		public function get clustered():Boolean;
		public function set clustered(value:Boolean):void;
		/**
		 * Indicates whether the ChannelSet is connected.
		 */
		public function get connected():Boolean;
		/**
		 * Returns the current Channel for the ChannelSet.
		 */
		public function get currentChannel():Channel;
		/**
		 * Provides access to the set of MessageAgents that use this ChannelSet.
		 */
		public function get messageAgents():Array;
		/**
		 * Constructs a ChannelSet.
		 *  If the channelIds argument is provided, the ChannelSet will
		 *  use automatically configured Channels obtained via ServerConfig.getChannel()
		 *  to reach a destination.
		 *  Attempting to manually assign Channels to a ChannelSet that uses configured
		 *  Channels is not allowed.
		 *
		 * @param channelIds        <Array (default = null)> The ids of configured Channels obtained from ServerConfig for this ChannelSet to
		 *                            use. If null, Channels must be manually added to the ChannelSet.
		 * @param clusteredWithURLLoadBalancing<Boolean (default = false)> True if the Channels in the ChannelSet are clustered
		 *                            using url load balancing.
		 */
		public function ChannelSet(channelIds:Array = null, clusteredWithURLLoadBalancing:Boolean = false);
		/**
		 * Adds a Channel to the ChannelSet. A Channel with a null id cannot be added
		 *  to the ChannelSet if the ChannelSet targets a clustered destination.
		 *
		 * @param channel           <Channel> The Channel to add.
		 */
		public function addChannel(channel:Channel):void;
		/**
		 * Handles a CONNECT ChannelEvent and redispatches the event.
		 *
		 * @param event             <ChannelEvent> The ChannelEvent.
		 */
		public function channelConnectHandler(event:ChannelEvent):void;
		/**
		 * Handles a DISCONNECT ChannelEvent and redispatches the event.
		 *
		 * @param event             <ChannelEvent> The ChannelEvent.
		 */
		public function channelDisconnectHandler(event:ChannelEvent):void;
		/**
		 * Handles a ChannelFaultEvent and redispatches the event.
		 *
		 * @param event             <ChannelFaultEvent> The ChannelFaultEvent.
		 */
		public function channelFaultHandler(event:ChannelFaultEvent):void;
		/**
		 * Connects a MessageAgent to the ChannelSet. Once connected, the agent
		 *  can use the ChannelSet to send messages.
		 *
		 * @param agent             <MessageAgent> The MessageAgent to connect.
		 */
		public function connect(agent:MessageAgent):void;
		/**
		 * Disconnects a specific MessageAgent from the ChannelSet. If this is the
		 *  last MessageAgent using the ChannelSet and the current Channel in the set is
		 *  connected, the Channel will physically disconnect from the server.
		 *
		 * @param agent             <MessageAgent> The MessageAgent to disconnect.
		 */
		public function disconnect(agent:MessageAgent):void;
		/**
		 * Disconnects all associated MessageAgents and disconnects any underlying Channel that
		 *  is connected.
		 *  Unlike disconnect(MessageAgent) which is invoked by the disconnect implementations
		 *  of specific service components, this method provides a single, convenient point to shut down
		 *  connectivity between the client and server.
		 */
		public function disconnectAll():void;
		/**
		 * Authenticates the ChannelSet with the server using the provided credentials.
		 *  Unlike other operations on Channels and the ChannelSet, this operation returns an
		 *  AsyncToken that client code may add a responder to in order to handle success or
		 *  failure directly.
		 *  If the ChannelSet is not connected to the server when this method is invoked it will
		 *  trigger a connect attempt, and if successful, send the login command to the server.
		 *  Only one login or logout operation may be pending at a time and overlapping calls will
		 *  generate an IllegalOperationError.
		 *  Invoking login when the ChannelSet is already authenticated will generate also generate
		 *  an IllegalOperationError.
		 *
		 * @param username          <String> The username.
		 * @param password          <String> The password.
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            credentials. The default is null, which implies the legacy charset of
		 *                            ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public function login(username:String, password:String, charset:String = null):AsyncToken;
		/**
		 * Logs the ChannelSet out from the server. Unlike other operations on Channels
		 *  and the ChannelSet, this operation returns an AsyncToken that client code may
		 *  add a responder to in order to handle success or failure directly.
		 *  If logout is successful any credentials that have been cached for use in
		 *  automatic reconnects are cleared for the ChannelSet and its Channels and their
		 *  authenticated state is set to false.
		 *  If the ChannelSet is not connected to the server when this method is invoked it
		 *  will trigger a connect attempt, and if successful, send a logout command to the server.
		 *
		 * @param agent             <MessageAgent (default = null)> Legacy argument. The MessageAgent that is initiating the logout.
		 */
		public function logout(agent:MessageAgent = null):AsyncToken;
		/**
		 * Removes a Channel from the ChannelSet. If the Channel to remove is
		 *  currently connected and being used by the ChannelSet, it is
		 *  disconnected as well as removed.
		 *
		 * @param channel           <Channel> The Channel to remove.
		 */
		public function removeChannel(channel:Channel):void;
		/**
		 * Sends a message from a MessageAgent over the currently connected Channel.
		 *
		 * @param agent             <MessageAgent> The MessageAgent sending the message.
		 * @param message           <IMessage> The Message to send.
		 */
		public function send(agent:MessageAgent, message:IMessage):void;
		/**
		 * Stores the credentials and passes them through to every connected channel.
		 *
		 * @param credentials       <String> The credentials for the MessageAgent.
		 * @param agent             <MessageAgent> The MessageAgent that is setting the credentials.
		 * @param charset           <String (default = null)> The character set encoding used while encoding the
		 *                            credentials. The default is null, which implies the legacy encoding of
		 *                            ISO-Latin-1.
		 */
		public function setCredentials(credentials:String, agent:MessageAgent, charset:String = null):void;
		/**
		 * Returns a String containing the ids of the Channels in the ChannelSet.
		 *
		 * @return                  <String> String representation of the ChannelSet.
		 */
		public override function toString():String;
	}
}
