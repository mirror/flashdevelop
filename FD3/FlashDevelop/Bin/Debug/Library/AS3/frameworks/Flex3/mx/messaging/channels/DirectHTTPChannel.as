package mx.messaging.channels
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import mx.core.mx_internal;
	import mx.messaging.Channel;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.errors.ChannelError;
	import mx.messaging.errors.InvalidChannelError;
	import mx.messaging.errors.MessageSerializationError;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.events.HTTPStatusEvent;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import mx.core.mx_internal;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.events.HTTPStatusEvent;

	/**
	 *  @private *  The DirectHTTPChannel class is used to turn an HTTPRequestMessage object into an *  HTTP request. *  This Channel does not connect to a Flex endpoint.
	 */
	public class DirectHTTPChannel extends Channel
	{
		/**
		 * @private     * Used by DirectHTTPMessageResponder to specify a dummy clientId for AcknowledgeMessages.     * Each instance of this channel gets a new clientId.
		 */
		local var clientId : String;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 * @private     * Incremented per new instance of the channel to create clientIds.
		 */
		private static var clientCounter : uint;

		/**
		 *  Indicates if this channel is connected.
		 */
		public function get connected () : Boolean;
		/**
		 *  Indicates the protocol used by this channel.
		 */
		public function get protocol () : String;
		/**
		 *  @private     *  Returns true if the channel supports realtime behavior via server push or client poll.
		 */
		function get realtime () : Boolean;

		/**
		 *  Constructs an instance of a DirectHTTPChannel.    *  The parameters are not used.
		 */
		public function DirectHTTPChannel (id:String, uri:String = "");
		/**
		 *  @private     *  Because this channel is always "connected", we ignore any connect timeout     *  that is reported.
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  Returns the appropriate MessageResponder for the Channel.     *     *  @param agent The MessageAgent sending the message.     *      *  @param message The IMessage to send.     *      *  @return The MessageResponder to handle the send result or fault.
		 */
		protected function getMessageResponder (agent:MessageAgent, message:IMessage) : MessageResponder;
		/**
		 *  Because this channel doesn't participate in hunting we will always assume     *  that we have connected.     *     *  @private
		 */
		protected function internalConnect () : void;
		protected function internalSend (msgResp:MessageResponder) : void;
		/**
		 override
		 */
		function createURLRequest (message:IMessage) : URLRequest;
		public function setCredentials (credentials:String, agent:MessageAgent = null, charset:String = null) : void;
	}
	/**
	 *  @private *  This is an adapter for url loader that is used by the HTTPChannel.
	 */
	internal class DirectHTTPMessageResponder extends MessageResponder
	{
		/**
		 * @private
		 */
		private var clientId : String;
		/**
		 * @private
		 */
		private var lastStatus : int;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  The URLLoader associated with this responder.
		 */
		public var urlLoader : URLLoader;

		/**
		 *  Constructs a DirectHTTPMessageResponder.
		 */
		public function DirectHTTPMessageResponder (agent:MessageAgent, msg:IMessage, channel:DirectHTTPChannel, urlLoader:URLLoader);
		/**
		 *  @private
		 */
		public function errorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function securityErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function httpStatusHandler (event:HTTPStatusEvent) : void;
		/**
		 *  Handle a request timeout by closing our associated URLLoader and     *  faulting the message to the agent.
		 */
		protected function requestTimedOut () : void;
	}
}
