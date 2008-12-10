package mx.messaging.channels
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.utils.ByteArray;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.FlexClient;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.net.ObjectEncoding;
	import flash.utils.ByteArray;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.Channel;
	import mx.messaging.channels.StreamingConnectionHandler;
	import mx.messaging.messages.IMessage;

	/**
	 *  The StreamingAMFChannel class provides support for messaging and *  offers a different push model than the base AMFChannel. Rather than *  polling for data from the server, the streaming channel opens an internal *  HTTP connection to the server that is held open to allow the server to *  stream data down to the client with no poll overhead. * *  <p> *  Messages sent by this channel to the server are sent using a NetConnection *  which uses an HTTP connection internally for the duration of the operation. *  Once the message is sent and an acknowledgement or fault is returned the HTTP connection *  used by NetConnection is released by the channel. These client-to-server messages are *  not sent over the streaming HTTP connection that the channel holds open to receive *  server pushed data. *  </p> * *  <p> *  Although this class extends the base AMFChannel to inherit the regular AMF *  handling, it does not support polling. *  </p>
	 */
	public class StreamingAMFChannel extends AMFChannel
	{
		/**
		 * Helper class used by the channel to establish a streaming HTTP connection     * with the server.
		 */
		private var streamingConnectionHandler : StreamingConnectionHandler;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private
		 */
		public function set pollingEnabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set pollingInterval (value:Number) : void;
		/**
		 *  @private     *  Returns true since streaming channels are considered realtime.
		 */
		function get realtime () : Boolean;

		/**
		 *  Creates an new StreamingAMFChannel instance.     *     *  @param id The id of this Channel.     *     *  @param uri The uri for this Channel.
		 */
		public function StreamingAMFChannel (id:String = null, uri:String = null);
		/**
		 *  Polling is not supported by this channel.
		 */
		public function poll () : void;
		/**
		 *  @private     *  Closes the streaming connection before redispatching the fault event.     *     *  @param event The ChannelFaultEvent.
		 */
		protected function connectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  @private     *  Closes the streaming connection before disconnecting.
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private     *  This method will be called if the ping message sent to test connectivity     *  to the server during the connection attempt succeeds.     *  Before triggering connect success handling the streaming channel must set     *  up its streaming connection with the server.
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  If the streaming connection receives an open event the channel is setup     *  and gets ready for messaging.     *     *  @param event The OPEN Event.
		 */
		private function streamOpenHandler (event:Event) : void;
		/**
		 *  A complete event indicates that the streaming connection has been closed by the server.     *  This is a no-op if the channel is disconnected on the client, otherwise notifies the client     *  channel that it has disconnected.     *     *  @param event The COMPLETE Event.
		 */
		private function streamCompleteHandler (event:Event) : void;
		/**
		 *  Handle HTTP status events dispatched by the streaming connection.     *     *  @param event The HTTPStatusEvent.
		 */
		private function streamHttpStatusHandler (event:HTTPStatusEvent) : void;
		/**
		 *  Handle IO error events dispatched by the streaming connection.     *     *  @param event The IOErrorEvent.
		 */
		private function streamIoErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  Handle security error events dispatched by the streaming connection.     *     *  @param event The SecurityErrorEvent.
		 */
		private function streamSecurityErrorHandler (event:SecurityErrorEvent) : void;
		/**
		 *  Handle status events dispatched by the streaming connection.     *     *  @param event The StatusEvent.
		 */
		private function streamStatusHandler (event:StatusEvent) : void;
	}
	/**
	 *  A helper class that is used by the streaming channels to open an internal *  HTTP connection to the server that is held open to allow the server to *  stream data down to the client with no poll overhead.
	 */
	internal class StreamingAMFConnectionHandler extends StreamingConnectionHandler
	{
		/**
		 *  Creates an new StreamingAMFConnectionHandler instance.     *     *  @param channel The Channel that uses this class.     *  @param log Reference to the logger for the associated Channel.
		 */
		public function StreamingAMFConnectionHandler (channel:Channel, log:ILogger);
		/**
		 *  Used by the streamProgressHandler to read an AMF encoded message.
		 */
		protected function readMessage () : IMessage;
	}
}
