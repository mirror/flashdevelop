package mx.messaging.messages
{
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * A special serialization wrapper for AsyncMessages. This wrapper is used to * enable the externalizable form of an AsyncMessage for serialization. The * wrapper must be applied just before the message is serialized as it does not * proxy any information to the wrapped message. *  * @private
	 */
	public class AsyncMessageExt extends AsyncMessage implements IExternalizable
	{
		private var _message : AsyncMessage;

		/**
		 *  The unique id for the message.
		 */
		public function get messageId () : String;

		public function AsyncMessageExt (message:AsyncMessage = null);
		public function writeExternal (output:IDataOutput) : void;
	}
}
