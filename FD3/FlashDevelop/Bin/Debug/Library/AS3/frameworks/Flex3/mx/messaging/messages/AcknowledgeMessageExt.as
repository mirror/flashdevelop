package mx.messaging.messages
{
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * @private
	 */
	public class AcknowledgeMessageExt extends AcknowledgeMessage implements IExternalizable
	{
		private var _message : AcknowledgeMessage;

		/**
		 *  The unique id for the message.
		 */
		public function get messageId () : String;

		public function AcknowledgeMessageExt (message:AcknowledgeMessage = null);
		public function writeExternal (output:IDataOutput) : void;
	}
}
