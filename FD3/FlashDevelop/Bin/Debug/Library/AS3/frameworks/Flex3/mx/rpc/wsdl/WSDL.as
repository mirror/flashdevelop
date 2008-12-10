package mx.rpc.wsdl
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.Fault;
	import mx.rpc.soap.SOAPConstants;
	import mx.rpc.xml.QualifiedResourceManager;
	import mx.rpc.xml.Schema;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.SchemaManager;

	/**
	 * Manages a WSDL top-level <code>definitions</code> element. WSDL definitions * may contain imports to other WSDL definitions. Only SOAP bindings are * supported. *  * @private
	 */
	public class WSDL
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 * Manages WSDL imports.
		 */
		private var importsManager : QualifiedResourceManager;
		/**
		 * Logs warnings encountered while parsing WSDL.
		 */
		private var _log : ILogger;
		/**
		 * Maps a namespace prefix (as a <code>String</code>) to a     * <code>Namespace</code> (i.e. this helps to resolve a prefix to a URI).
		 */
		private var namespaces : Object;
		/**
		 * Provides a static cache of the constants for various versions of XSD.
		 */
		private var _schemaConstants : SchemaConstants;
		/**
		 * A map of target namespaces to XSD Schemas that describe the types      * used in this WSDL.
		 */
		private var _schemaManager : SchemaManager;
		/**
		 * Map to cache a WSDLService by service name. The cache is cleared      * when a new definitions element is set for the WSDL.
		 */
		private var serviceMap : Object;
		private var _soapConstants : SOAPConstants;
		/**
		 * WSDL target namespace.
		 */
		private var _targetNamespace : Namespace;
		/**
		 * Provides a static cache of the constants for various versions of WSDL.
		 */
		private var _wsdlConstants : WSDLConstants;
		/**
		 * The raw XML representing the WSDL definitions top level element.
		 */
		private var _xml : XML;

		public function get schemaManager () : SchemaManager;
		public function get schemaConstants () : SchemaConstants;
		public function get soapConstants () : SOAPConstants;
		public function get targetNamespace () : Namespace;
		public function get wsdlConstants () : WSDLConstants;
		/**
		 * The raw XML representing the WSDL starting from the top-level     * definitions element.
		 */
		public function get xml () : XML;

		/**
		 * Constructs a WSDL from XML. Services and their operations are     * parsed into object representations on the first call to     * <code>getService()</code>, <code>getPort()</code> or     * <code>getOperation()</code>.     *     * @param xml An XML document starting from the top-level WSDL      * <code>defintions</code> element.
		 */
		public function WSDL (xml:XML);
		/**
		 FIXME:        1. Validate that the targetNamespace matches the one defined on the           import XML        2. Also, check that the import being added does not cause a cyclic           relationship.
		 */
		public function addImport (targetNamespace:Namespace, wsdl:WSDL) : void;
		public function addSchema (schema:Schema) : void;
		public function getOperation (operationName:String, serviceName:String = null, portName:String = null) : WSDLOperation;
		/**
		 * Locate a port for a service by name. If a serviceName is provided, a     * service is first located, otherwise the first service is used by default.     * Once a service has been selected, the search then considers the port.     * If a portName is not provided, the first port is used by default.
		 */
		public function getPort (serviceName:String = null, portName:String = null) : WSDLPort;
		/**
		 * Search for WSDL service and port by name. If a serviceName is not     * provided the first service found will be selected by default.
		 */
		public function getService (serviceName:String = null, portName:String = null) : WSDLService;
		public function getTypes (targetNamespace:Namespace) : XML;
		/**
		 * Search for a requested service in the definitions XML, including all     * WSDL imports. This is the usual entry point to start parsing the WSDL as     * only one service and one of its port will be used at any time.     * <p>     * If the service name is not specified, the first service is used by     * default. If a service is located it is parsed and then the search     * continues for the requested port, which is in turn parsed, and so forth.     * </p>
		 */
		private function parseService (serviceName:String = null, portName:String = null) : WSDLService;
		/**
		 * Search for a requested port in the given service XML. If a port     * name was not specified, the first port is used by default.
		 */
		private function parsePort (service:WSDLService, serviceXML:XML, portName:String = null) : WSDLPort;
		/**
		 * Search for a binding by QName. If a URI is not specified, the     * targetNamespace is assumed. FIXME: We may need to consider whether     * formElementDefault is set to qualified or not.
		 */
		private function parseBinding (bindingQName:QName) : WSDLBinding;
		/**
		 * Search for a portType by QName. If a URI is not specified, the     * targetNamespace is assumed.
		 */
		private function parsePortType (portTypeQName:QName, portType:WSDLPortType) : Boolean;
		/**
		 * Search for a message by QName. If a URI is not specified, the     * targetNamespace is assumed.
		 */
		private function parseMessage (message:WSDLMessage, messageQName:QName, operationName:String, mode:int) : Boolean;
		/**
		 * Returns a WSDL message part based on the name and looks for either an     * element QName or type QName to determine which definition describes     * this message part.
		 */
		private function parseMessagePart (partXML:XML) : WSDLMessagePart;
		/**
		 * Looks for the SOAP encoding extensions based on the type of WSDL     * operation message. SOAP encoding is required for SOAP Body, Header     * (header and headerfault) and Fault extensions.
		 */
		private function parseHeader (operationName:String, headerXML:XML) : WSDLMessage;
		/**
		 * Looks for the SOAP encoding extensions based on the type of WSDL     * operation message. SOAP encoding is required for SOAP Body, Header     * (header and headerfault) and Fault extensions.
		 */
		private function parseEncodingExtension (extensionXML:XML, isHeader:Boolean = false, isFault:Boolean = false) : WSDLEncoding;
		/**
		 * A Document-Literal operation may make use of "wrapped" style. If so,     * then the message parts should be replaced by the the individual wrapped     * parts so that the SOAP encoders correctly bind ActionScript input params     * to message params, and SOAP decoders correctly bind output params     * to predictable ActionScript constructs. Essentially the wrappers should     * be an encoding detail that is invisible to the Flex developer.
		 */
		private function parseDocumentOperation (operation:WSDLOperation) : void;
		/**
		 * Returns a WSDL message part based on the name and looks for either an     * element QName or type QName to determine which definition describes     * this message part.
		 */
		private function parseWrappedMessagePart (elementXML:XML) : WSDLMessagePart;
		/**
		 * Determines the WSDL and SOAP versions from the definitions and creates     * a map of top level prefixes to namespaces.
		 */
		private function processNamespaces () : void;
		private function processSchemas () : void;
	}
}
