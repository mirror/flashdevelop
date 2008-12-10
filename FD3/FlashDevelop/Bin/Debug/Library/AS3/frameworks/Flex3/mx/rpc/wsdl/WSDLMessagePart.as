package mx.rpc.wsdl
{
	/**
	 * Parts are a flexible mechanism for describing the content of a message. *  * @private
	 */
	public class WSDLMessagePart
	{
		public var type : QName;
		public var element : QName;
		public var definition : XML;
		public var optional : Boolean;
		private var _name : QName;

		/**
		 * The unique name of this message part.
		 */
		public function get name () : QName;

		public function WSDLMessagePart (name:QName, element:QName = null, type:QName = null);
	}
}
