package mx.messaging.messages
{
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * A special serialization wrapper for CommandMessage. This wrapper is used to * enable the externalizable form of an CommandMessage for serialization. The * wrapper must be applied just before the message is serialized as it does not * proxy any information to the wrapped message. *  * @private
	 */
	public class CommandMessageExt extends CommandMessage implements IExternalizable
	{
		private var _message : CommandMessage;

		/**
		 *  The unique id for the message.
		 */
		public function get messageId () : String;

		public function CommandMessageExt (message:CommandMessage = null);
		public function writeExternal (output:IDataOutput) : void;
	}
}
