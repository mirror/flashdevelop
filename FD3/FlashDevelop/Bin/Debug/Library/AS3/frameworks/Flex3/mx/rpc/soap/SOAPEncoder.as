package mx.rpc.soap
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.soap.types.ICustomSOAPType;
	import mx.rpc.wsdl.WSDLConstants;
	import mx.rpc.wsdl.WSDLEncoding;
	import mx.rpc.wsdl.WSDLOperation;
	import mx.rpc.wsdl.WSDLMessage;
	import mx.rpc.wsdl.WSDLMessagePart;
	import mx.rpc.xml.Schema;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.SchemaDatatypes;
	import mx.rpc.xml.SchemaMarshaller;
	import mx.rpc.xml.XMLEncoder;

	/**
	 * A SOAPEncoder is used to create SOAP 1.1 formatted requests for a web service * operation. A WSDLOperation provides the definition of how SOAP request should * be formatted and thus must be set before a call is made to encode(). *  * TODO: Create a SOAP 1.2 specific subclass of this encoder. *  * @private
	 */
	public class SOAPEncoder extends XMLEncoder implements ISOAPEncoder
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _ignoreWhitespace : Boolean;
		private var isSOAPEncoding : Boolean;
		private var log : ILogger;
		private var _wsdlOperation : WSDLOperation;

		/**
		 * Determines whether the encoder should ignore whitespace when     * constructing an XML representation of a SOAP request.     * The default is <code>true</code> and thus whitespace is not preserved.     * If an XML Schema type definition specifies a <code>whiteSpace</code>     * restriction set to <code>preserve</code> then ignoreWhitespace must     * first be set to false. Conversely, if a type <code>whiteSpace</code>     * restriction is set to <code>replace</code> or <code>collapse</code> then     * that setting will be honored even if ignoreWhitespace is set to false.
		 */
		public function get ignoreWhitespace () : Boolean;
		public function set ignoreWhitespace (value:Boolean) : void;
		/**
		 * @private
		 */
		protected function get inputEncoding () : WSDLEncoding;
		public function get schemaConstants () : SchemaConstants;
		public function get soapConstants () : SOAPConstants;
		public function get wsdlOperation () : WSDLOperation;
		public function set wsdlOperation (value:WSDLOperation) : void;

		public function SOAPEncoder ();
		/**
		 * Creates a SOAP encodes request to an operation from the given input     * parameters and headers.
		 */
		public function encodeRequest (args:* = null, headers:Array = null) : XML;
		/**
		 * A SOAP Envelope element is the root element of a SOAP message. It     * must specify the SOAP namespace.
		 */
		protected function encodeEnvelope (args:*, headers:Array) : XML;
		/**
		 * Appends SOAP Header to the SOAP Envelope
		 */
		protected function encodeHeaders (headers:Array, envelopeXML:XML) : void;
		/**
		 * Appends a header element to top SOAP Header tag
		 */
		protected function encodeHeaderElement (header:Object, headersXML:XML) : void;
		/**
		 * Encodes the SOAP Body. Currently assumes only one operation sub-element.
		 */
		protected function encodeBody (inputParams:*, envelopeXML:XML) : void;
		/**
		 * Encodes a WSDL operation using document literal format.     * There's no need to generate an operation element so advance directly     * to encoding the message.     * <p>     * From the WSDL 1.1 specification:     * </p>     * <p>     * &quot;If <code>use</code> is <b>literal</b>, then each part references     * a concrete schema definition using either the <code>element</code> or     * <code>type</code> attribute. In the first case, the element referenced     * by the part will appear directly under the Body element (for document     * style bindings)... In the second, the type referenced by the part     * becomes the schema type of the enclosing element (Body for document     * style...).&quot;     * </p>
		 */
		protected function encodeOperationAsDocumentLiteral (inputParams:Object, bodyXML:XML) : void;
		/**
		 * Encodes a WSDL operation using RPC literal format.     * <p>     * From the WSDL 1.1 specification:     * </p>     * <p>     * &quot;If the operation style is <code>rpc</code> each part is a parameter     * or a return value and appears inside a wrapper element within the body     * (following Section 7.1 of the SOAP specification). The wrapper element     * is named identically to the operation name and its namespace is the     * value of the namespace attribute. Each message part (parameter) appears     * under the wrapper, represented by an accessor named identically to the     * corresponding parameter of the call. Parts are arranged in the same     * order as the parameters of the call.&quot;     * </p>     * <p>     * &quot;If <code>use</code> is <b>literal</b>, then each part references     * a concrete schema definition using either the <code>element</code> or     * <code>type</code> attribute. In the first case, the element referenced     * by the part will appear ... under an accessor element named after the     * message part (in rpc style). In the second, the type referenced by the     * part becomes the schema type of the enclosing element ( ... part accessor     * element for rpc style).&quot;     * </p>
		 */
		protected function encodeOperationAsRPCLiteral (inputParams:Object, bodyXML:XML) : void;
		/**
		 * Encodes a WSDL message part using RPC encoded format.     * <p>     * From the WSDL 1.1 specification:     * </p>     * <p>     * &quot;If the operation style is <code>rpc</code> each part is a parameter     * or a return value and appears inside a wrapper element within the body     * (following Section 7.1 of the SOAP specification). The wrapper element     * is named identically to the operation name and its namespace is the     * value of the namespace attribute. Each message part (parameter) appears     * under the wrapper, represented by an accessor named identically to the     * corresponding parameter of the call. Parts are arranged in the same     * order as the parameters of the call.&quot;     * </p>     * <p>     * &quot;If <code>use</code> is <b>encoded</b>, then each message part     * references an abstract type using the <code>type</code> attribute. These     * abstract types are used to produce a concrete message by applying an     * encoding specified by the <code>encodingStyle</code> attribute. The part     * names, types and value of the namespace attribute are all inputs to the     * encoding, although the namespace attribute only applies to content not     * explicitly defined by the abstract types. If the referenced encoding     * style allows variations in it's format (such as the SOAP encoding does),     * then all variations MUST be supported ("reader makes right").&quot;     * </p>
		 */
		protected function encodeOperationAsRPCEncoded (inputParams:*, bodyXML:XML) : void;
		/**
		 * Encodes an input message for a WSDL operation. The provided input     * parameters are validated against the required message parts.
		 */
		protected function encodeMessage (inputParams:*, operationXML:XML) : void;
		/**
		 * A WSDL message part may either refer to an XML Schema type (that is, a     * &lt;complexType&gt; or &lt;simpleType&gt;) directly by QName or to an element     * definition by QName depending on the SOAP use and encodingStyle     * attributes.
		 */
		protected function encodePartValue (part:WSDLMessagePart, value:*) : XMLList;
		/**
		 * Looks to see whether a pre-encoded SOAP request has been passed to the     * encoder.
		 */
		protected function preEncodedCheck (value:*) : Object;
		/**
		 * SOAP specific override to handle special wrapped-style document-literal      * parameters which can specify minOccurs and maxOccurs attributes on     * local element definitions that are, for all intents and purposes,     * really top-level element definitions representing operation parts.     * XML Schema does not normally allow minOccurs or maxOccurs on top-level     * element definitions and the SchemaProcessor is not looking out for them     * so we have to special case this situation here.
		 */
		public function encode (value:*, name:QName = null, type:QName = null, definition:XML = null) : XMLList;
		/**
		 * SOAP specific override to intercept SOAP encoded types such as base64.     * Also, SOAP encoding requires an XSI type attribute to be specified on     * encoded types.     *      * @private
		 */
		public function encodeType (type:QName, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * This override intercepts encoding a complexType with complexContent based     * on a SOAP encoded Array. This awkward approach to Array type definitions     * was popular in WSDL 1.1 rpc-encoded operations and is a special case that     * needs to be handled, but note it violates the WS-I Basic Profile 1.0.     *      * @private
		 */
		public function encodeComplexRestriction (restriction:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * This override tries to determine the XSI type for the encoded value if     * SOAP use style is set to <code>encoded</code>.     *      * @private
		 */
		protected function deriveXSIType (parent:XML, type:QName, value:*) : void;
	}
}
