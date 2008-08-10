/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public class AsyncMessage extends AbstractMessage {
		/**
		 * Provides access to the correlation id of the message.
		 *  Used for acknowledgement and for segmentation of messages.
		 *  The correlationId contains the messageId of the
		 *  previous message that this message refers to.
		 */
		public function get correlationId():String;
		public function set correlationId(value:String):void;
		/**
		 * Constructs an instance of an AsyncMessage with an empty body and header.
		 *  In addition to this default behavior, the body and the headers for the
		 *  message may also be passed to the constructor as a convenience.
		 *  An example of this invocation approach for the body is:
		 *  var msg:AsyncMessage = new AsyncMessage("Body text");
		 *  An example that provides both the body and headers is:
		 *  var msg:AsyncMessage = new AsyncMessage("Body text", {"customerHeader":"customValue"});
		 *
		 * @param body              <Object (default = null)> The optional body to assign to the message.
		 * @param headers           <Object (default = null)> The optional headers to assign to the message.
		 */
		public function AsyncMessage(body:Object = null, headers:Object = null);
		/**
		 * Messages sent by a MessageAgent with a defined subtopic
		 *  property indicate their target subtopic in this header.
		 */
		public static const SUBTOPIC_HEADER:String = "DSSubtopic";
	}
}
