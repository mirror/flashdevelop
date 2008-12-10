package mx.messaging.channels
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.core.mx_internal;
	import mx.messaging.FlexClient;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.amfx.AMFXDecoder;
	import mx.messaging.channels.amfx.AMFXEncoder;
	import mx.messaging.channels.amfx.AMFXHeader;
	import mx.messaging.channels.amfx.AMFXResult;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.MessageSerializationError;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.MessagePerformanceInfo;
	import mx.messaging.messages.MessagePerformanceUtils;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.core.mx_internal;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.HTTPChannel;
	import mx.messaging.channels.amfx.AMFXDecoder;
	import mx.messaging.channels.amfx.AMFXHeader;
	import mx.messaging.channels.amfx.AMFXResult;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;

	/**
	 *  The HTTPChannel class provides the HTTP support for messaging. *  You can configure this Channel to poll the server at an interval *  to approximate server push. *  You can also use this Channel with polling disabled to send RPC messages *  to remote destinations to invoke their methods. * *  <p> *  The HTTPChannel relies on network services native to Flash Player and AIR, *  and exposed to ActionScript by the URLLoader class. *  This channel uses URLLoader exclusively, and creates a new URLLoader *  per request. *  </p> * *  <p> *  Channels are created within the framework using the *  <code>ServerConfig.getChannel()</code> method. Channels can be constructed *  directly and assigned to a ChannelSet if desired. *  </p> * *  <p> *  Channels represent a physical connection to a remote endpoint. *  Channels are shared across destinations by default. *  This means that a client targetting different destinations may use *  the same Channel to communicate with these destinations. *  </p> * *  <p> *  When used in polling mode, this Channel polls the server for new messages *  based on the <code>polling-interval-seconds</code> property in the configuration file, *  and this can be changed by setting the <code>pollingInterval</code> property. *  The default value is 3 seconds. *  To enable polling, the channel must be connected and the <code>polling-enabled</code> *  property in the configuration file must be set to <code>true</code>, or the *  <code>pollingEnabled</code> property of the Channel must be set to <code>true</code>. *  </p>
	 */
	public class HTTPChannel extends PollingChannel
	{
		/**
		 *  @private
		 */
		private var _appendToURL : String;
		/**
		 *  @private     *  The loader used to ping the server in internalConnect. We need to hang onto a reference     *  in order to time out a connect attempt.
		 */
		private var _connectLoader : ChannelRequestLoader;
		/**
		 *  @private
		 */
		private var _encoder : AMFXEncoder;
		/**
		 *  @private     *  Records the request that needs to be completed before other     *  requests can be sent.
		 */
		private var _pendingRequest : ChannelRequestLoader;
		/**
		 *  @private     *  This queue contains the messages from send requests that     *  occurred while an authentication attempt is underway.
		 */
		private var _messageQueue : Array;
		/**
		 *  @private
		 */
		private static const APPEND_TO_URL_HEADER : String = "AppendToGatewayUrl";

		/**
		 *  Reports whether the channel is actively polling.
		 */
		public function get polling () : Boolean;
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
		 *  Returns the protocol for this channel (http).
		 */
		public function get protocol () : String;
		/**
		 * @private
		 */
		function get appendToURL () : String;
		/**
		 *  @private
		 */
		function set appendToURL (value:String) : void;

		/**
		 *  Creates an new HTTPChannel instance.     *     *  @param id The id of this Channel.     *  @param uri The uri for this Channel.
		 */
		public function HTTPChannel (id:String = null, uri:String = null);
		/**
		 *  @private     *  Processes polling related configuration settings.
		 */
		public function applySettings (settings:XML) : void;
		/**
		 *  @private
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		protected function getPollSyncMessageResponder (agent:MessageAgent, msg:CommandMessage) : MessageResponder;
		/**
		 *  @private
		 */
		protected function getDefaultMessageResponder (agent:MessageAgent, msg:IMessage) : MessageResponder;
		/**
		 *  @private     *  Attempts to connect to the remote destination with the current endpoint     *  specified for this channel.     *  This will determine if a connection can be established.
		 */
		protected function internalConnect () : void;
		/**
		 *  @private     *  Disconnects from the remote destination.
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function internalSend (msgResp:MessageResponder) : void;
		/**
		 *  @private     *  Utility function to handle a connection related ErrorMessage.     *     *  @param msg The ErrorMessage returned during a connect attempt.
		 */
		function connectionError (msg:ErrorMessage) : void;
		/**
		 *  @private     *  This method will serialize the specified message into a new instance of     *  a URLRequest and return it.     *     *  @param   message Message to serialize     *  @return  URLRequest
		 */
		function createURLRequest (message:IMessage) : URLRequest;
		/**
		 * @private
		 */
		protected function internalPingComplete (msg:AsyncMessage) : void;
		/**
		 *  @private     *  Special handler for AMFX packet level header "AppendToGatewayUrl".     *  When we receive this header we assume the server detected that a session     *  was created but it believed the client could not accept its session     *  cookie, so we need to decorate the channel endpoint with the session id.     *     *  We do not modify the underlying endpoint property, however, as this     *  session is transient and should not apply if the channel is disconnected     *  and re-connected at some point in the future.
		 */
		private function AppendToGatewayUrl (value:String) : void;
		private function decodePacket (event:Event) : AMFXResult;
		/**
		 *  @private     *  Attempts to replicate the packet-level header functionality that AMFChannel     *  uses for response headers such as AppendToGatewayUrl for session id tracking.
		 */
		private function processHeaders (packet:AMFXResult) : void;
		/**
		 *  @private     *  This method indicates that we successfully connected to the endpoint.     *  Called as a result of the ping operation performed in the     *  internalConnect() method.
		 */
		private function pingCompleteHandler (event:Event) : void;
		/**
		 *  @private     *  This method dispatches the appropriate error to any message agents, and     *  is called as a result of the ping operation performed in the     *  internalConnect() method.
		 */
		private function pingErrorHandler (event:Event) : void;
		/**
		 *  @private     *  Chains sends for pending messages.
		 */
		private function requestProcessedHandler (loader:ChannelRequestLoader, event:Event) : void;
	}
	/**
	 *  @private *  This responder wraps another MessageResponder with HTTP functionality.
	 */
	internal class HTTPWrapperResponder
	{
		/**
		 *  @private
		 */
		private var _wrappedResponder : MessageResponder;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private     *  Constructs a HTTPWrappedResponder.     *     *  @param wrappedResponder The responder to wrap.
		 */
		public function HTTPWrapperResponder (wrappedResponder:MessageResponder);
		/**
		 *  @private     *  Handles a result returned from the remote destination.     *     *  @param event The completion event from the associated URLLoader.
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private     *  Handles an error for an outbound request.     *     *  @param event The error event from the associated URLLoader.
		 */
		public function errorHandler (event:Event) : void;
	}
	/**
	 *  @private *  This is an adapter for url loader that is used by the HTTPChannel.
	 */
	internal class HTTPMessageResponder extends MessageResponder
	{
		/**
		 *  @private
		 */
		private var decoder : AMFXDecoder;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  The loader associated with this responder.
		 */
		public var urlLoader : ChannelRequestLoader;

		/**
		 *  @private     *  Constructs an HTTPMessageResponder.     *     *  @param agent The associated MessageAgent.     *     *  @param msg The message to send.     *     *  @param channel The Channel to send the message over.
		 */
		public function HTTPMessageResponder (agent:MessageAgent, msg:IMessage, channel:HTTPChannel);
		/**
		 *  @private
		 */
		protected function resultHandler (response:IMessage) : void;
		/**
		 *  @private     *  Handle a request timeout by closing our associated URLLoader and     *  faulting the message to the agent.
		 */
		protected function requestTimedOut () : void;
		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function errorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function ioErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function securityErrorHandler (event:Event) : void;
	}
	/**
	 *  @private *  Wraps an URLLoader and manages dispatching its events to the proper handlers.
	 */
	internal class ChannelRequestLoader
	{
		/**
		 *  @private     *  The wrapped URLLoader.
		 */
		private var _urlLoader : URLLoader;
		/**
		 *  @private
		 */
		public var errorCallback : Function;
		/**
		 *  @private
		 */
		public var ioErrorCallback : Function;
		/**
		 *  @private
		 */
		public var securityErrorCallback : Function;
		/**
		 *  @private
		 */
		public var completeCallback : Function;
		/**
		 *  @private
		 */
		public var requestProcessedCallback : Function;

		/**
		 *  @private     *  Constructs a ChannelRequestLoader.
		 */
		public function ChannelRequestLoader ();
		/**
		 *  @private
		 */
		public function load (request:URLRequest) : void;
		/**
		 *  @private
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		public function setErrorCallbacks (callback:Function) : void;
		/**
		 *  @private
		 */
		private function callRequestProcessedCallback (event:Event) : void;
		/**
		 *  @private
		 */
		private function callEventCallback (callback:Function, event:Event) : void;
		/**
		 *  @private
		 */
		private function errorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function ioErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function securityErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function completeHandler (event:Event) : void;
	}
	/**
	 *  @private *  This class provides a way to synchronize polling with a subscribe or *  unsubscribe request.  It is constructed in response to a consumer sending *  either a subscribe or unsubscribe command message.  If a successfull *  subscribe/unsubscribe is made this responder will inform the channel *  appropriately. * *  See the PollSyncMessageResponder in NetConnectionChannel - the prototype.
	 */
	internal class PollSyncHTTPMessageResponder extends HTTPMessageResponder
	{
		/**
		 *  @private     *  Constructs a PollSyncHTTPMessageResponder.     *     *  @param agent The associated MessageAgent.     *     *  @param msg The subscribe or unsubscribe message.     *     *  @param channel The Channel used to send the message.
		 */
		public function PollSyncHTTPMessageResponder (agent:MessageAgent, msg:IMessage, channel:HTTPChannel);
		/**
		 *  @private
		 */
		protected function resultHandler (response:IMessage) : void;
	}
	/**
	 *  Helper class for sending a fire-and-forget disconnect message.
	 */
	internal class HTTPFireAndForgetResponder extends MessageResponder
	{
		public function HTTPFireAndForgetResponder (message:IMessage);
	}
}
