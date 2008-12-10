package mx.rpc.wsdl
{
	/**
	 * From the WSDL 1.1 specification: *  * <blockquote> * Messages consist of one or more logical parts. Each part is associated with * a type from some type system using a message-typing attribute. The set of * message-typing attributes is extensible. * </blockquote> *  * @private
	 */
	public class WSDLMessage
	{
		/**
		 * The SOAP encoding extensions for this message.
		 */
		public var encoding : WSDLEncoding;
		/**
		 * Whether this message is using .NET wrapped style for document literal     * requests.
		 */
		public var isWrapped : Boolean;
		/**
		 * The unique name of this message.
		 */
		public var name : String;
		/**
		 * An Array of message parts which describe the parameters of this     * message and the order in which they were specified. By default each of     * these parameters appear in a SOAP Envelope's Body section.
		 */
		public var parts : Array;
		/**
		 * The QName of the element wrapper if the message is to be encoded using     * .NET document-literal wrapped style.
		 */
		public var wrappedQName : QName;
		private var _partsMap : Object;
		private var _headersMap : Object;
		private var _headerFaultsMap : Object;

		public function WSDLMessage (name:String = null);
		/**
		 * Add a part to this message. The parts Array tracks the order in which     * parts were added; an internal map allows a part to be located by name.     * @see #getPart(String)
		 */
		public function addPart (part:WSDLMessagePart) : void;
		/**
		 * Locates a message part by name.
		 */
		public function getPart (name:String) : WSDLMessagePart;
		/**
		 * @private
		 */
		public function addHeader (header:WSDLMessage) : void;
		/**
		 * @private
		 */
		public function getHeader (name:String) : WSDLMessage;
		/**
		 * @private
		 */
		public function addHeaderFault (headerFault:WSDLMessage) : void;
		/**
		 * @private
		 */
		public function getHeaderFault (name:String) : WSDLMessage;
	}
}
