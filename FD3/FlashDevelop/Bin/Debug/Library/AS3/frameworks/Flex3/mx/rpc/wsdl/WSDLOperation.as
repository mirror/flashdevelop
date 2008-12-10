package mx.rpc.wsdl
{
	import mx.rpc.soap.SOAPConstants;
	import mx.rpc.xml.SchemaManager;

	/**
	 * A <code>WSDLOperation</code> describes both the interface for messages being * sent to and from an operation and the SOAP encoding style for operation * binding. *  * @private
	 */
	public class WSDLOperation
	{
		/**
		 * Describes the parts and encoding for the input message of this     * operation.
		 */
		public var inputMessage : WSDLMessage;
		/**
		 * Used to map prefixes to namespace URIs.
		 */
		public var namespaces : Object;
		/**
		 * Describes the parts and encoding for the output message of this     * operation.
		 */
		public var outputMessage : WSDLMessage;
		/**
		 * Represents the style attribute for an operation's SOAP binding which     * indicates whether an operation is RPC-oriented (messages containing     * parameters and return values) or document-oriented (message containing     * document(s)).     * <p>     * If a style is not specified for an operation the default will be     * determined from the parent WSDLBinding's style attribute.     * </p>
		 */
		public var style : String;
		private var _faultsMap : Object;
		private var _name : String;
		private var _soapAction : String;
		private var _soapConstants : SOAPConstants;
		private var _schemaManager : SchemaManager;
		private var _wsdlConstants : WSDLConstants;

		/**
		 * The name of this WSDL operation.
		 */
		public function get name () : String;
		/**
		 * A SchemaManager handles the XML Schema types section of a WSDL and     * is used to locate a type definition by QName.
		 */
		public function get schemaManager () : SchemaManager;
		public function set schemaManager (manager:SchemaManager) : void;
		/**
		 * Specifies the value for the SOAPAction HTTPHeader used for the HTTP     * binding of SOAP.     * <p>     * Although technically the soapAction must always be specified, a default     * value of the empty String will be returned in the event that it is     * not set.     * </p>
		 */
		public function get soapAction () : String;
		public function set soapAction (value:String) : void;
		/**
		 * The constants for the version of SOAP used to encode messages     * to and from this operation.
		 */
		public function get soapConstants () : SOAPConstants;
		public function set soapConstants (value:SOAPConstants) : void;
		/**
		 * The constants for the version of WSDL used to define this operation.
		 */
		public function get wsdlConstants () : WSDLConstants;
		public function set wsdlConstants (value:WSDLConstants) : void;

		/**
		 * Constructor.
		 */
		public function WSDLOperation (name:String);
		/**
		 * Registers the encoding and type information for a potential fault for     * this operation.     * @private
		 */
		public function addFault (fault:WSDLMessage) : void;
		/**
		 * Locates a fault by name.     * @private
		 */
		public function getFault (name:String) : WSDLMessage;
	}
}
