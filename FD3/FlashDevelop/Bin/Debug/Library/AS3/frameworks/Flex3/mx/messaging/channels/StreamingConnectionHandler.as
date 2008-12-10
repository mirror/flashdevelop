package mx.messaging.channels
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.ObjectEncoding;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.messaging.Channel;
	import mx.messaging.FlexClient;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  Dispatched when the StreamingConnectionHandler receives a status command from the server. * *  @eventType flash.events.StatusEvent
	 */
	[Event(name="status", type="flash.events.StatusEvent")] 

	/**
	 *  A helper class that is used by the streaming channels to open an internal *  HTTP connection to the server that is held open to allow the server to *  stream data down to the client with no poll overhead.
	 */
	public class StreamingConnectionHandler extends EventDispatcher
	{
		/**
		 *  The code for the StatusEvent dispatched by this handler when a disconnect     *  command is received from the server.
		 */
		public static const DISCONNECT_CODE : String = "disconnect";
		/**
		 *  Parameter name for the command passed in the request for a new streaming connection.
		 */
		private static const COMMAND_PARAM_NAME : String = "command";
		/**
		 *  A request to open a streaming connection passes this 'command' in the request URI to the     *  remote endpoint.
		 */
		private static const OPEN_COMMAND : String = "open";
		/**
		 *  A request to close a streaming connection passes this 'command' in the request URI to the     *  remote endpoint.
		 */
		private static const CLOSE_COMMAND : String = "close";
		/**
		 *  Parameter name for the stream id; passed with commands for an existing streaming connection.
		 */
		private static const STREAM_ID_PARAM_NAME : String = "streamId";
		/**
		 *  Parameter name for the version param passed in the request for a new streaming connection.
		 */
		private static const VERSION_PARAM_NAME : String = "version";
		/**
		 *  Indicates the stream version used for this channel's stream connection.     *  Currently just version 1. If the protocol over the wire needs to change in the future     *  this gives us a way to indicate the change.
		 */
		private static const VERSION_1 : String = "1";
		private static const CR_BYTE : int = 13;
		private static const LF_BYTE : int = 10;
		private static const NULL_BYTE : int = 0;
		private static const HEX_DIGITS : Object;
		private const HEX_VALUES : Object;
		private const INIT_STATE : int = 0;
		private static const CR_STATE : int = 1;
		private static const LF_STATE : int = 2;
		private static const SIZE_STATE : int = 3;
		private static const TEST_CHUNK_STATE : int = 4;
		private static const SKIP_STATE : int = 5;
		private static const DATA_STATE : int = 6;
		private static const RESET_BUFFER_STATE : int = 7;
		/**
		 * The Channel that uses this class.
		 */
		protected var channel : Channel;
		/**
		 *  Byte buffer used to store the current chunk from the remote endpoint.     *  Once a full chunk has been buffered, a message instance encoded in binary     *  AMF format can be read from the chunk and dispatched.
		 */
		protected var chunkBuffer : ByteArray;
		/**
		 *  Counter that keeps track of how many data bytes remain to be read for the current chunk.     *  A sentinal value of -1 indicates an initial state (either waiting for the first chunk or     *  just finished parsing the previous chunk).
		 */
		protected var dataBytesToRead : int;
		/**
		 *  Index into the chunk buffer pointing to the first byte of chunk data.
		 */
		protected var dataOffset : int;
		/**
		 *  @private     *  Reference to the logger for the associated Channel.
		 */
		protected var _log : ILogger;
		/**
		 *  @private     *  The server-assigned id for the streaming connection.
		 */
		protected var streamId : String;
		/**
		 *  Storage for the hex-format chunk size value from the byte stream.
		 */
		private var hexChunkSize : String;
		/**
		 *  Current parse state on the streaming connection.
		 */
		private var state : int;
		/**
		 *  URLStream used to open a streaming connection from the server to     *  the client over HTTP.
		 */
		private var streamingConnection : URLStream;
		/**
		 *  URLStream used to close the original streaming connection opened from     *  the server to the client over HTTP.
		 */
		private var streamingConnectionCloser : URLStream;

		/**
		 *  Creates an new StreamingConnectionHandler instance.     *	 *  @param channel The Channel that uses this class.	 *  @param log Reference to the logger for the associated Channel.
		 */
		public function StreamingConnectionHandler (channel:Channel, log:ILogger);
		/**
		 *  Used by the streaming channels to set up the streaming connection if     *  necessary and issue the open request to the server.     *     *  @param appendToURL The string to append such as session id to the endpoint     *  url while making the streaming connection request.
		 */
		public function openStreamingConnection (appendToURL:String = null) : void;
		/**
		 *  Used by the streaming channels to shut down the streaming connection.
		 */
		public function closeStreamingConnection () : void;
		/**
		 *  Used by the streamProgressHandler to read a message. Default implementation	 *  returns null and subclasses must override this method.	 *	 *  @return Returns the message that was read.
		 */
		protected function readMessage () : IMessage;
		/**
		 *  Helper method to process the chunk size value in hex read from the beginning of a chunk     *  into a decimal value that can be used to determine when all data for the chunk has been read.     *     *  @param value The hex value as a String.     *  @return The hex value converted as a decimal int.
		 */
		private function convertHexToDecimal (value:String) : int;
		/**
		 *  Handles a complete event that indicates that the streaming connection     *  has been closed by the server by re-dispatching the event for the channel.     *     *  @param event The COMPLETE Event.
		 */
		private function streamCompleteHandler (event:Event) : void;
		/**
		 *  Handles HTTP status events dispatched by the streaming connection by     *  re-dispatching the event for the channel.     *     *  @param event The HTTPStatusEvent.
		 */
		private function streamHttpStatusHandler (event:HTTPStatusEvent) : void;
		/**
		 *  Handles IO error events dispatched by the streaming connection by     *  re-dispatching the event for the channel.     *     *  @param event The IOErrorEvent.
		 */
		private function streamIoErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  The open event is dispatched when the streaming connection has been established     *  to the server, but it may still fail or be rejected so ignore this event and do     *  not advance the channel to a connected state yet.     *     *  @param event The OPEN Event.
		 */
		private function streamOpenHandler (event:Event) : void;
		/**
		 *  The arrival of data from the remote endpoint triggers progress events.     *  The format of the data stream is HTTP Transfer-Encoding chunked, and each chunk contains either an object     *  encoded in binary AMF format or a block of bytes to read off the network but skip any processing of.     *     *  @param event The ProgressEvent.
		 */
		private function streamProgressHandler (event:ProgressEvent) : void;
		/**
		 *  Handles security error events dispatched by the streaming connection by     *  re-dispatching the event for the channel.     *     *  @param event The SecurityErrorEvent.
		 */
		private function streamSecurityErrorHandler (event:SecurityErrorEvent) : void;
	}
}
