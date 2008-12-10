package mx.messaging.messages
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	/**
	 *  An AcknowledgeMessage acknowledges the receipt of a message that  *  was sent previously. *  Every message sent within the messaging system must receive an *  acknowledgement.
	 */
	public class AcknowledgeMessage extends AsyncMessage implements ISmallMessage
	{
		/**
		 *  Header name for the error hint header.     *  Used to indicate that the acknowledgement is for a message that     *  generated an error.
		 */
		public static const ERROR_HINT_HEADER : String = "DSErrorHint";

		/**
		 *  Constructs an instance of an AcknowledgeMessage with an empty body and header.
		 */
		public function AcknowledgeMessage ();
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
	}
}
