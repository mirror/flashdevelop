package mx.messaging.channels
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.Channel;
	import mx.messaging.ConsumerMessageDispatcher;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.logging.ILogger;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.PollingChannel;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.MessagePerformanceUtils;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The PollingChannel class provides the polling behavior that all polling channels in the messaging *  system require.
	 */
	public class PollingChannel extends Channel
	{
		/**
		 *  @private      *  The base polling interval to use if the server is not triggering adaptive polling     *  interval waits via its poll responses.
		 */
		local var _pollingInterval : int;
		/**
		 *  @private     *  Indicates whether we should poll but stopped for some reason.
		 */
		local var _shouldPoll : Boolean;
		/**
		 *  @private     *  This reference count allows us to determine when polling is needed and     *  when it is not.
		 */
		private var _pollingRef : int;
		/**
		 *  @private    *  Guard used to avoid issuing poll requests on top of each other. This is     *  needed when a poll request is issued manually by calling poll() method.
		 */
		local var pollOutstanding : Boolean;
		/**
		 *  @private      *  Used for polling the server at a given interval.       *  This may be null if channel implementation does not require the use of a      *  timer to poll.
		 */
		local var _timer : Timer;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _piggybackingEnabled : Boolean;
		/**
		 *  @private
		 */
		private var _pollingEnabled : Boolean;
		/**
		 * Define the default Polling Interval as 3000ms
		 */
		private static const DEFAULT_POLLING_INTERVAL : int = 3000;

		/**
		 *  @private
		 */
		protected function get internalPiggybackingEnabled () : Boolean;
		/**
		 *  @private
		 */
		protected function set internalPiggybackingEnabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		protected function get internalPollingEnabled () : Boolean;
		/**
		 *  @private
		 */
		protected function set internalPollingEnabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		function get internalPollingInterval () : Number;
		/**
		 *  @private
		 */
		function set internalPollingInterval (value:Number) : void;
		/**
		 *  @private     *  Returns true if the channel supports realtime behavior via server push or client poll.     *  Piggybacking does not qualify as real time because no data will arrive from the server     *  without a message being explicitly sent by the client.
		 */
		function get realtime () : Boolean;
		/**
		 *  @private
		 */
		function get timerRunning () : Boolean;

		/**
		 *  Creates a new PollingChannel instance with the specified id. Once a PollingChannel is     *  connected and begins polling, it will issue a poll request once every three seconds     *  by default.     * 	 *  <b>Note</b>: The PollingChannel type should not be constructed directly. Instead	 *  create instances of protocol specific subclasses such as HTTPChannel or	 *  AMFChannel that extend it.     *	 *  @param id The id of this Channel.	 *  	 *  @param uri The uri for this Channel.
		 */
		public function PollingChannel (id:String = null, uri:String = null);
		/**
		 *  Sends the specified message to its target destination.	 *  Subclasses must override the <code>internalSend()</code> method to	 *  perform the actual send.	 *  <code>PollingChannel</code> will wrap outbound messages in poll requests if a poll	 *  is not currently outstanding.     *	 *  @param agent The MessageAgent that is sending the message.	 * 	 *  @param message The Message to send.	 * 	 *  @throws mx.messaging.errors.InvalidDestinationError If neither the MessageAgent nor the	 *                                  message specify a destination.
		 */
		public function send (agent:MessageAgent, message:IMessage) : void;
		/**
		 *  @private     *  This method prevents polling from continuing when the Channel can not connect.     *      *  @param event The ChannelFaultEvent.
		 */
		protected function connectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  @private     *  If a consumer sends a subscribe message to the server, we need to     *  track that polling should occur.  In addition, we don't however, want     *  to begin polling before we actually receive the acknowledgement that     *  we have successfully subscribed.  This method is used to return a     *  special message handler that will notify us when we have a successful     *  subscribe and can safely begin polling.  This case is the reverse for     *  unsubscribe, we need to track that we successfully unsubscribed and     *  there are no more consumers attached that need polling.     *      *  In addition to handling this case, this method also returns a special     *  responder to handle the results or fault for a poll request.     *     *  @param agent MessageAgent that requested the message be sent.     *      *  @param msg Message to be sent.     *      *  @return A PollSyncMessageResponder for subscribe/unsubscriber requests or a     *          PollCommandMessageResponder for poll requests; otherwise the default     *          message responder.
		 */
		protected function getMessageResponder (agent:MessageAgent, msg:IMessage) : MessageResponder;
		/**
		 *  @private      *  Disconnects from the remote destination.
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  Enables polling based on the number of times <code>enablePolling()</code>     *  and <code>disablePolling()</code> have been invoked. If the net result is to enable     *  polling the channel will poll the server on behalf of connected MessageAgents.     *  <p>Invoked automatically based upon subscribing or unsubscribing from a remote     *  destination over a PollingChannel.</p>
		 */
		public function enablePolling () : void;
		/**
		 *  Disables polling based on the number of times <code>enablePolling()</code>     *  and <code>disablePolling()</code> have been invoked. If the net result is to disable     *  polling the channel stops polling.     *  <p>Invoked automatically based upon subscribing or unsubscribing from a remote     *  destination over a PollingChannel.</p>
		 */
		public function disablePolling () : void;
		/**
		 *  Initiates a poll operation if there are consumers subscribed to this channel,      *  and polling is enabled for this channel.     *     *  Note that this method will not start a new poll if one is currently in progress.
		 */
		public function poll () : void;
		/**
		 *  @private     *  This method allows a PollCommandMessageResponder to indicate that the      *  channel has lost its connectivity.     *      *  @param rejected Channel will be rejected and will not attempt to reconnect if      *  this flag is true
		 */
		function pollFailed (rejected:Boolean = false) : void;
		/**
		 *  @private     *  This method is invoked automatically when <code>disablePolling()</code>     *  is called and it results in a net negative number of requests to poll.     *       *  mx_internal to allow the poll responder to shut down polling if a general,     *  fatal error occurs.
		 */
		function stopPolling () : void;
		/**
		 *  @private     *  Processes polling related configuration settings.     *       *  @param settings The Channel settings.
		 */
		protected function applyPollingSettings (settings:XML) : void;
		/**
		 *  @private
		 */
		protected function getPollSyncMessageResponder (agent:MessageAgent, msg:CommandMessage) : MessageResponder;
		/**
		 *  @private
		 */
		protected function getDefaultMessageResponder (agent:MessageAgent, msg:IMessage) : MessageResponder;
		/**
		 *  @private      *  Requests the server return any messages queued since the last poll request for this FlexClient.     *     *  @param event Event dispatched by the polling Timer.
		 */
		protected function internalPoll (event:Event = null) : void;
		/**
		 *  @private     *  This method is invoked automatically when <code>enablePolling()</code>     *  is called and it results in net positive number of requests to poll.
		 */
		protected function startPolling () : void;
		/**
		 *  @private     *  Returns true if this channel requires a timer for polling.
		 */
		protected function timerRequired () : Boolean;
	}
	/**
	 *  @private *  Used internally to dispatch a batched set of messages returned in the poll *  command message.
	 */
	internal class PollCommandMessageResponder extends MessageResponder
	{
		/**
		 *  @private     *  Reference to the logger for the associated Channel.
		 */
		private var _log : ILogger;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private      *  Initializes an instance of the message responder that handles     *  multiple messages received from a poll request that a Channel makes.     *     *  @param channel PollingChannel.
		 */
		public function PollCommandMessageResponder (agent:MessageAgent, msg:IMessage, channel:PollingChannel, log:ILogger);
		/**
		 *  @private     *  Handles a poll command result from the server which is either an empty acknowledgement     *  if there were no messages to deliver or a response containing a list of messages to      *  dispatch in its body.     *      *  @param msg The result message.
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  @private     *  Handles a fault while attempting to poll.     *      *  @param msg The ErrorMessage from the remote destination.
		 */
		protected function statusHandler (msg:IMessage) : void;
	}
}
