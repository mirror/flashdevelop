package mx.messaging.channels
{
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Responder;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.FlexClient;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectUtil;
	import mx.messaging.MessageResponder;
	import mx.messaging.messages.IMessage;

	/**
	 *  The AMFChannel class provides the AMF support for messaging. *  You can configure this Channel to poll the server at an interval *  to approximate server push. *  You can also use this Channel with polling disabled to send RPC messages *  to remote destinations to invoke their methods. * *  <p> *  The AMFChannel relies on network services native to Flash Player and AIR, *  and exposed to ActionScript by the NetConnection class. *  This channel uses NetConnection exclusively, and creates a new NetConnection *  per instance. *  </p> * *  <p> *  Channels are created within the framework using the *  <code>ServerConfig.getChannel()</code> method. Channels can be constructed *  directly and assigned to a ChannelSet if desired. *  </p> * *  <p> *  Channels represent a physical connection to a remote endpoint. *  Channels are shared across destinations by default. *  This means that a client targetting different destinations may use *  the same Channel to communicate with these destinations. *  </p> * *  <p> *  When used in polling mode, this Channel polls the server for new messages *  based on the <code>polling-interval-seconds</code> property in the configuration file, *  and this can be changed by setting the <code>pollingInterval</code> property. *  The default value is 3 seconds. *  To enable polling, the channel must be connected and the <code>polling-enabled</code> *  property in the configuration file must be set to <code>true</code>, or the *  <code>pollingEnabled</code> property of the Channel must be set to <code>true</code>. *  </p>
	 */
	public class AMFChannel extends NetConnectionChannel
	{
		/**
		 * @private     * Flag used to indicate that the channel is in the process of reconnecting     * with the session id in the url.
		 */
		protected var _reconnectingWithSessionId : Boolean;
		/**
		 *  @private     *  Flag used to control when we need to handle NetStatusEvents.     *  If the channel has shutdown due to reaching a connect timeout we need to     *  continue listening for events (such as 404s) but we've already shutdown so     *  we must ignore them.
		 */
		private var _ignoreNetStatusEvents : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Indicates whether this channel will piggyback poll requests along     *  with regular outbound messages when an outstanding poll is not in     *  progress. This allows the server to piggyback data for the client     *  along with its response to client's message.
		 */
		public function get piggybackingEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set piggybackingEnabled (value:Boolean) : void;
		/**
		 *  Indicates whether this channel is enabled to poll.
		 */
		public function get pollingEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set pollingEnabled (value:Boolean) : void;
		/**
		 *  Provides access to the polling interval for this Channel.     *  The value is in milliseconds.     *  This value determines how often this Channel requests messages from     *  the server, to approximate server push.     *     *  @throws ArgumentError If the pollingInterval is assigned a value of 0 or     *                        less.
		 */
		public function get pollingInterval () : Number;
		/**
		 *  @private
		 */
		public function set pollingInterval (value:Number) : void;
		/**
		 *  Reports whether the channel is actively polling.
		 */
		public function get polling () : Boolean;
		/**
		 *  Returns the protocol for this channel (http).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new AMFChannel instance.     *     *  @param id The id of this Channel.     *     *  @param uri The uri for this Channel.
		 */
		public function AMFChannel (id:String = null, uri:String = null);
		/**
		 *  @private     *  Processes polling related configuration settings.
		 */
		public function applySettings (settings:XML) : void;
		/**
		 *  @private     *  Overriding to be able to keep track of the fact that the Channel is in     *  the process of reconnecting with the session id, so the initial     *  NetConnection call can be discarded properly in the resultHandler.
		 */
		public function AppendToGatewayUrl (value:String) : void;
		/**
		 *  @private     *  Attempts to connect to the endpoint specified for this channel.
		 */
		protected function internalConnect () : void;
		/**
		 *  @private     *  Disconnects from the remote destination.     *  Because this channel uses a stateless HTTP connection, it sends a fire-and-forget     *  message to the server as it disconnects to allow the server to shut down any     *  session or other resources that it may be managing on behalf of this channel.
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private     *  Shuts down the underlying NetConnection for the AMFChannel.     *  The reason this override is necessary is because the NetConnection may dispatch     *  a NetStatusEvent after it has been closed and if we're not registered to listen for     *  that event the Player will throw an RTE.     *  The only time this can occur when the channel has been shut down due to a connect     *  timeout but an error (i.e. 404) response from the server returns later.
		 */
		protected function shutdownNetConnection () : void;
		/**
		 *  @private     *  Called on the status event of the associated NetConnection when there is a     *  problem with the connection for this channel.
		 */
		protected function statusHandler (event:NetStatusEvent) : void;
		/**
		 *  @private     *  Used by result and fault handlers to update the url of the underlying     *  NetConnection with session id.
		 */
		protected function handleReconnectWithSessionId () : void;
		/**
		 *  @private     *  Called in response to the server ping to check connectivity.     *  An error indicates that although the endpoint uri is reachable the Channel     *  is still not able to connect.
		 */
		protected function faultHandler (msg:ErrorMessage) : void;
		/**
		 *  @private     *  This method will be called if the ping message sent to test connectivity     *  to the server during the connection attempt succeeds.
		 */
		protected function resultHandler (msg:IMessage) : void;
	}
	/**
	 *  Helper class for sending a fire-and-forget disconnect message.
	 */
	internal class AMFFireAndForgetResponder extends MessageResponder
	{
		public function AMFFireAndForgetResponder (message:IMessage);
	}
}
