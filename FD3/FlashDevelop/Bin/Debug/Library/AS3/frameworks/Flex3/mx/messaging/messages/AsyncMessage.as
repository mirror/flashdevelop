package mx.messaging.messages
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import mx.utils.RPCUIDUtil;

	/**
	 *  AsyncMessage is the base class for all asynchronous messages.
	 */
	public class AsyncMessage extends AbstractMessage implements ISmallMessage
	{
		/**
		 *  Messages sent by a MessageAgent with a defined <code>subtopic</code>	 *  property indicate their target subtopic in this header.
		 */
		public static const SUBTOPIC_HEADER : String = "DSSubtopic";
		private static const CORRELATION_ID_FLAG : uint = 1;
		private static const CORRELATION_ID_BYTES_FLAG : uint = 2;
		/**
		 * @private
		 */
		private var _correlationId : String;
		/**
		 * @private
		 */
		private var correlationIdBytes : ByteArray;

		/**
		 *  Provides access to the correlation id of the message.     *  Used for acknowledgement and for segmentation of messages.     *  The <code>correlationId</code> contains the <code>messageId</code> of the     *  previous message that this message refers to.     *     *  @see mx.messaging.messages.AbstractMessage#messageId
		 */
		public function get correlationId () : String;
		/**
		 * @private
		 */
		public function set correlationId (value:String) : void;

		/**
		 *  Constructs an instance of an AsyncMessage with an empty body and header.     *  In addition to this default behavior, the body and the headers for the     *  message may also be passed to the constructor as a convenience.     *  An example of this invocation approach for the body is:     *  <code>var msg:AsyncMessage = new AsyncMessage("Body text");</code>     *  An example that provides both the body and headers is:     *  <code>var msg:AsyncMessage = new AsyncMessage("Body text", {"customerHeader":"customValue"});</code>     *      *  @param body The optional body to assign to the message.     *      *  @param headers The optional headers to assign to the message.
		 */
		public function AsyncMessage (body:Object = null, headers:Object = null);
		/**
		 * @private
		 */
		public function getSmallMessage () : IMessage;
		/**
		 * @private
		 */
		public function readExternal (input:IDataInput) : void;
		/**
		 * @private
		 */
		public function writeExternal (output:IDataOutput) : void;
		/**
		 *  @private
		 */
		protected function addDebugAttributes (attributes:Object) : void;
	}
}
