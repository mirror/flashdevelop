package mx.messaging.channels
{
	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.ISmallMessage;
	import mx.messaging.messages.MessagePerformanceInfo;
	import mx.messaging.messages.MessagePerformanceUtils;
	import mx.utils.StringUtil;
	import flash.utils.Timer;
	import flash.net.NetConnection;
	import flash.events.TimerEvent;
	import mx.core.mx_internal;
	import mx.messaging.channels.NetConnectionChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;

	/**
	 *  This NetConnectionChannel provides the basic NetConnection support for messaging. *  The AMFChannel and RTMPChannel both extend this class.
	 */
	public class NetConnectionChannel extends PollingChannel
	{
		/**
		 *  @private
		 */
		local var _appendToURL : String;
		/**
		 *  @private
		 */
		protected var _nc : NetConnection;

		/**
		 *  Provides access to the associated NetConnection for this Channel.
		 */
		public function get netConnection () : NetConnection;
		/**
		 * @private     * If the ObjectEncoding is set to AMF0 we can't support small messages.
		 */
		public function get useSmallMessages () : Boolean;

		/**
		 *  Creates a new NetConnectionChannel instance.     *  <p>     *  The underlying NetConnection's <code>objectEncoding</code>     *  is set to <code>ObjectEncoding.AMF3</code> by default. It can be     *  changed manually by accessing the channel's <code>netConnection</code>     *  property. The global <code>NetConnection.defaultObjectEncoding</code>     *  setting is not honored by this channel.     *  </p>     *     *  @param id The id of this Channel.     *     *  @param uri The uri for this Channel.
		 */
		public function NetConnectionChannel (id:String = null, uri:String = null);
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
		 *  @private
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function internalConnect () : void;
		/**
		 *  @private
		 */
		protected function internalSend (msgResp:MessageResponder) : void;
		/**
		 *  @private     *  Special handler for legacy AMF packet level header "AppendToGatewayUrl".     *  When we receive this header we assume the server detected that a session was     *  created but it believed the client could not accept its session cookie, so we     *  need to decorate the channel endpoint with the session id.     *     *  We do not modify the underlying endpoint property, however, as this session     *  is transient and should not apply if the channel is disconnected and re-connected     *  at some point in the future.
		 */
		public function AppendToGatewayUrl (value:String) : void;
		/**
		 *  @private     *  Called by the player when the server pushes a message.     *  Dispatches a MessageEvent to any MessageAgents that are listening.     *  Any ...rest args passed via RTMP are ignored.     *     *  @param msg The message pushed from the server.
		 */
		public function receive (msg:IMessage, ...rest:Array) : void;
		/**
		 *  @private     *  Shuts down the underlying NetConnection for the channel.
		 */
		protected function shutdownNetConnection () : void;
		/**
		 *  @private     *  Called when a status event occurs on the NetConnection.     *  Descendants must override this method.
		 */
		protected function statusHandler (event:NetStatusEvent) : void;
		/**
		 *  @private     *  If the player rejects a NetConnection request for security reasons,     *  such as a security sandbox violation, the NetConnection raises a     *  securityError event which we dispatch as a channel fault.
		 */
		protected function securityErrorHandler (event:SecurityErrorEvent) : void;
		/**
		 *  @private     *  If there is a network problem, the NetConnection raises an     *  ioError event which we dispatch as a channel fault.
		 */
		protected function ioErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  @private     *  If a problem arises in the native player code asynchronously, this     *  error event will be dispatched as a channel fault.
		 */
		protected function asyncErrorHandler (event:AsyncErrorEvent) : void;
		/**
		 *  @private     *  Utility function to dispatch a ChannelFaultEvent at an "error" level     *  based upon the passed code and ErrorEvent.
		 */
		private function defaultErrorHandler (code:String, event:ErrorEvent) : void;
	}
	/**
	 *  @private *  This class provides the responder level interface for dispatching message *  results from a remote destination. *  The NetConnectionChannel creates this handler to manage *  the results of a pending operation started when a message is sent. *  The message handler is always associated with a MessageAgent *  (the object that sent the message) and calls its <code>fault()</code>, *  <code>acknowledge()</code>, or <code>message()</code> method as appopriate.
	 */
	internal class NetConnectionMessageResponder extends MessageResponder
	{
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Initializes this instance of the message responder with the specified     *  agent.     *     *  @param agent MessageAgent that this responder should call back when a     *            message is received.     *     *  @param msg The outbound message.     *     *  @param channel The channel this responder is using.
		 */
		public function NetConnectionMessageResponder (agent:MessageAgent, msg:IMessage, channel:NetConnectionChannel);
		/**
		 *  @private     *  Called when the result of sending a message is received.     *     *  @param msg NetConnectionChannel-specific message data.
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  @private     *  Called when the current invocation fails.     *  Passes the fault information on to the associated agent that made     *  the request.     *     *  @param msg NetConnectionMessageResponder status information.
		 */
		protected function statusHandler (msg:IMessage) : void;
		/**
		 *  @private     *  Handle a request timeout by removing ourselves as a listener on the     *  NetConnection and faulting the message to the agent.
		 */
		protected function requestTimedOut () : void;
		/**
		 *  @private     *  Handles a disconnect of the underlying Channel before a response is     *  returned to the responder.     *  The sent message is faulted and flagged with the ErrorMessage.MESSAGE_DELIVERY_IN_DOUBT     *  code.     *     *  @param event The DISCONNECT event.
		 */
		protected function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private     *  Handles a fault of the underlying Channel before a response is     *  returned to the responder.     *  The sent message is faulted and flagged with the ErrorMessage.MESSAGE_DELIVERY_IN_DOUBT     *  code.     *     *  @param event The ChannelFaultEvent.
		 */
		protected function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  @private     *  Disconnects the responder from the underlying Channel.
		 */
		private function disconnect () : void;
	}
	/**
	 *  @private *  This class provides a way to synchronize polling with a subscribe or *  unsubscribe request. *  It is constructed in response to a Consumer sending either a subscribe or *  unsubscribe command message. *  If a successfull subscribe/unsubscribe is made this responder will inform the *  channel which will trigger it to start/stop polling if necessary. *
	 */
	internal class PollSyncMessageResponder extends NetConnectionMessageResponder
	{
		/**
		 *  @private     *  Constructs a PollSyncMessageResponder.     *     *  @param agent The agent to manage polling for.     *     *  @param msg The subscribe or unsubscribe message for the agent.     *     *  @param channel The underlying Channel for the responder.
		 */
		public function PollSyncMessageResponder (agent:MessageAgent, msg:IMessage, channel:NetConnectionChannel);
		/**
		 *  @private     *  This method is called by the player when the result of sending a message     *  is received.     *     *  @param msg The response to a subscribe or unsubscribe request.
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  @private     *  Handles a disconnect of the underlying Channel before a response is     *  returned to the responder and supresses resend attempts.     *     *  @param event The Channel disconnect event.
		 */
		protected function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private     *  Handles a fault of the underlying Channel before a response is     *  returned to the responder and supresses resend attempts.     *     *  @param event The Channel fault event.
		 */
		protected function channelFaultHandler (event:ChannelFaultEvent) : void;
	}
}
