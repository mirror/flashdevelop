/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	import mx.messaging.events.ChannelFaultEvent;
	import flash.events.TimerEvent;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.messages.IMessage;
	public class Channel extends EventDispatcher implements IMXMLObject {
		/**
		 * Indicates if this channel is authenticated.
		 */
		public function get authenticated():Boolean;
		/**
		 * Provides access to the ChannelSets connected to the Channel.
		 */
		public function get channelSets():Array;
		/**
		 * Indicates whether this channel has established a connection to the
		 *  remote destination.
		 */
		public function get connected():Boolean;
		/**
		 * Provides access to the connect timeout in seconds for the channel.
		 *  A value of 0 or below indicates that a connect attempt will never
		 *  be timed out on the client.
		 *  For channels that are configured to failover, this value is the total
		 *  time to wait for a connection to be established.
		 *  It is not reset for each failover URI that the channel may attempt
		 *  to connect to.
		 */
		public function get connectTimeout():int;
		public function set connectTimeout(value:int):void;
		/**
		 * Provides access to the endpoint for this channel.
		 *  This value is calculated based on the value of the uri
		 *  property.
		 */
		public function get endpoint():String;
		/**
		 * Provides access to the set of endpoint URIs that this channel can
		 *  attempt to failover to if the endpoint is clustered.
		 */
		public function get failoverURIs():Array;
		public function set failoverURIs(value:Array):void;
		/**
		 * Provides access to the id of this channel.
		 */
		public function get id():String;
		public function set id(value:String):void;
		/**
		 * Provides access to the protocol that the channel uses.
		 */
		public function get protocol():String;
		/**
		 * Indicates whether this channel is in the process of reconnecting to an
		 *  alternate endpoint.
		 */
		public function get reconnecting():Boolean;
		/**
		 */
		public function get recordMessageSizes():Boolean;
		/**
		 */
		public function get recordMessageTimes():Boolean;
		/**
		 * Provides access to the default request timeout in seconds for the
		 *  channel. A value of 0 or below indicates that outbound requests will
		 *  never be timed out on the client.
		 */
		public function get requestTimeout():int;
		public function set requestTimeout(value:int):void;
		/**
		 * Provides access to the URI used to create the whole endpoint URI for this channel.
		 *  The URI can be a partial path, in which case the full endpoint URI is computed as necessary.
		 */
		public function get uri():String;
		public function set uri(value:String):void;
		/**
		 * Constructs an instance of a generic Channel that connects to the
		 *  specified endpoint URI.
		 *  Note: The Channel type should not be constructed directly. Instead
		 *  create instances of protocol specific subclasses such as RTMPChannel or
		 *  AMFChannel.
		 *
		 * @param id                <String (default = null)> The id of this channel.
		 * @param uri               <String (default = null)> The endpoint URI for this channel.
		 */
		public function Channel(id:String = null, uri:String = null);
		/**
		 * Subclasses should override this method to apply any settings that may be
		 *  necessary for an individual channel.
		 *  Make sure to call super.applySettings() to apply common settings for the channel.
		 *
		 * @param settings          <XML> XML fragment of the services-config.xml file for this channel.
		 *                            The following fragement includes the <channel> tag with
		 *                            all of its configuration settings:
		 *                            <channel id="my-amf" type="mx.messaging.channels.AMFChannel">
		 *                            <endpoint uri="/dev/messagebroker/amf" type="flex.messaging.endpoints.AmfEndpoint"/>
		 *                            <properties>
		 *                            <polling-enabled>false</polling-enabled>
		 *                            </properties>
		 *                            </channel>
		 */
		public function applySettings(settings:XML):void;
		/**
		 * Connects the ChannelSet to the Channel. If the Channel has not yet
		 *  connected to its endpoint, it attempts to do so.
		 *  Channel subclasses must override the internalConnect()
		 *  method, and call the connectSuccess() method once the
		 *  underlying connection is established.
		 *
		 * @param channelSet        <ChannelSet> The ChannelSet to connect to the Channel.
		 */
		public final function connect(channelSet:ChannelSet):void;
		/**
		 * Processes a failed internal connect and dispatches the
		 *  FAULT event for the channel.
		 *  If the Channel has failoverURI values, it will
		 *  attempt to reconnect automatically by trying these URI values in order until
		 *  a connection is established or the available values are exhausted.
		 *
		 * @param event             <ChannelFaultEvent> The ChannelFaultEvent for the failed connect.
		 */
		protected function connectFailed(event:ChannelFaultEvent):void;
		/**
		 * Processes a successful internal connect and dispatches the
		 *  CONNECT event for the Channel.
		 */
		protected function connectSuccess():void;
		/**
		 * Handles a connect timeout by dispatching a ChannelFaultEvent.
		 *  Subtypes may overide this to shutdown the current connect attempt but must
		 *  call super.connectTimeoutHandler(event).
		 *
		 * @param event             <TimerEvent> The timer event indicating that the connect timeout has been reached.
		 */
		protected function connectTimeoutHandler(event:TimerEvent):void;
		/**
		 * Disconnects the ChannelSet from the Channel. If the Channel is connected
		 *  to its endpoint and it has no more connected ChannelSets it will
		 *  internally disconnect.
		 *
		 * @param channelSet        <ChannelSet> The ChannelSet to disconnect from the Channel.
		 */
		public final function disconnect(channelSet:ChannelSet):void;
		/**
		 * Processes a failed internal disconnect and dispatches the
		 *  FAULT event for the channel.
		 *
		 * @param event             <ChannelFaultEvent> The ChannelFaultEvent for the failed disconnect.
		 */
		protected function disconnectFailed(event:ChannelFaultEvent):void;
		/**
		 * Processes a successful internal disconnect and dispatches the
		 *  DISCONNECT event for the Channel.
		 *  If the disconnect is due to a network failure and the Channel has
		 *  failoverURI values, it will attempt to reconnect automatically
		 *  by trying these URI values in order until a connection is established or the
		 *  available values are exhausted.
		 *
		 * @param rejected          <Boolean (default = false)> True if the disconnect should skip any
		 *                            failover processing that would otherwise be attempted; false
		 *                            if failover processing should be allowed to run.
		 */
		protected function disconnectSuccess(rejected:Boolean = false):void;
		/**
		 * Handles a change to the guard condition for managing initial Channel connect for the application.
		 *  When this is invoked it means that this Channel is waiting to attempt to connect.
		 *
		 * @param event             <PropertyChangeEvent> The PropertyChangeEvent dispatched by the FlexClient singleton.
		 */
		protected function flexClientWaitHandler(event:PropertyChangeEvent):void;
		/**
		 * Returns the appropriate MessageResponder for the Channel's
		 *  send() method.
		 *  Must be overridden.
		 *
		 * @param agent             <MessageAgent> The MessageAgent sending the message.
		 * @param message           <IMessage> The Message to send.
		 * @return                  <MessageResponder> The MessageResponder to handle the result or fault.
		 */
		protected function getMessageResponder(agent:MessageAgent, message:IMessage):MessageResponder;
		/**
		 * Connects the Channel to its endpoint.
		 *  Must be overridden.
		 */
		protected function internalConnect():void;
		/**
		 * Disconnects the Channel from its endpoint.
		 *  Must be overridden.
		 *
		 * @param rejected          <Boolean (default = false)> True if the disconnect was due to a connection rejection or timeout
		 *                            and reconnection should not be attempted automatically; otherwise false.
		 */
		protected function internalDisconnect(rejected:Boolean = false):void;
		/**
		 * Sends the Message out over the Channel and routes the response to the
		 *  responder.
		 *  Must be overridden.
		 *
		 * @param messageResponder  <MessageResponder> The MessageResponder to handle the response.
		 */
		protected function internalSend(messageResponder:MessageResponder):void;
		/**
		 * Sends a CommandMessage to the server to logout if the Channel is connected.
		 *  Current credentials are cleared.
		 *
		 * @param agent             <MessageAgent> The MessageAgent to logout.
		 */
		public function logout(agent:MessageAgent):void;
		/**
		 * Sends the specified message to its target destination.
		 *  Subclasses must override the internalSend() method to
		 *  perform the actual send.
		 *
		 * @param agent             <MessageAgent> The MessageAgent that is sending the message.
		 * @param message           <IMessage> The Message to send.
		 */
		public function send(agent:MessageAgent, message:IMessage):void;
		/**
		 * Sets the credentials to the specified value.
		 *  If the credentials are non-null and the Channel is connected, this method also
		 *  sends a CommandMessage to the server to login using the credentials.
		 *
		 * @param credentials       <String> The credentials string.
		 * @param agent             <MessageAgent (default = null)> The MessageAgent to login, that will handle the login result.
		 * @param charset           <String (default = null)> The character set encoding used while encoding the
		 *                            credentials. The default is null, which implies the legacy charset of
		 *                            ISO-Latin-1.
		 */
		public function setCredentials(credentials:String, agent:MessageAgent = null, charset:String = null):void;
	}
}
