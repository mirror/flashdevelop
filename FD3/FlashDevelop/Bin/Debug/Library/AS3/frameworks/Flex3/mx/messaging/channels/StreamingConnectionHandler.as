/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.channels {
	import flash.events.EventDispatcher;
	import mx.messaging.Channel;
	import mx.logging.ILogger;
	public class StreamingConnectionHandler extends EventDispatcher {
		/**
		 * The Channel that uses this class.
		 */
		protected var channel:Channel;
		/**
		 * Byte buffer used to store the current chunk from the remote endpoint.
		 *  Once a full chunk has been buffered, a message instance encoded in binary
		 *  AMF format can be read from the chunk and dispatched.
		 */
		protected var chunkBuffer:ByteArray;
		/**
		 * Counter that keeps track of how many data bytes remain to be read for the current chunk.
		 *  A sentinal value of -1 indicates an initial state (either waiting for the first chunk or
		 *  just finished parsing the previous chunk).
		 */
		protected var dataBytesToRead:int = -1;
		/**
		 * Index into the chunk buffer pointing to the first byte of chunk data.
		 */
		protected var dataOffset:int;
		/**
		 * Creates an new StreamingConnectionHandler instance.
		 *
		 * @param channel           <Channel> The Channel that uses this class.
		 * @param log               <ILogger> Reference to the logger for the associated Channel.
		 */
		public function StreamingConnectionHandler(channel:Channel, log:ILogger);
		/**
		 * Used by the streaming channels to shut down the streaming connection.
		 */
		public function closeStreamingConnection():void;
		/**
		 * Used by the streaming channels to set up the streaming connection if
		 *  necessary and issue the open request to the server.
		 */
		public function openStreamingConnection():void;
		/**
		 * Used by the streamProgressHandler to read a message. Default implementation
		 *  returns null and subclasses must overwrite this method.
		 */
		protected function readMessage():IMessage;
		/**
		 * The code for the StatusEvent dispatched by this handler when a disconnect
		 *  command is received from the server.
		 */
		public static const DISCONNECT_CODE:String = "disconnect";
	}
}
