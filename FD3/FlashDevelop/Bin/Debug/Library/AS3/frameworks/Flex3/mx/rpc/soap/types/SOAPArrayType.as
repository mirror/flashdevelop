package mx.rpc.soap.types
{
	import mx.collections.IList;
	import mx.rpc.soap.SOAPConstants;
	import mx.rpc.soap.SOAPEncoder;
	import mx.rpc.soap.SOAPDecoder;
	import mx.rpc.wsdl.WSDLConstants;
	import mx.rpc.xml.ContentProxy;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.SchemaDatatypes;
	import mx.rpc.xml.SchemaManager;
	import mx.rpc.xml.SchemaMarshaller;
	import mx.rpc.xml.SchemaProcessor;
	import mx.rpc.xml.TypeIterator;
	import mx.rpc.xml.XMLEncoder;
	import mx.rpc.xml.XMLDecoder;
	import mx.utils.object_proxy;
	import mx.utils.StringUtil;
	import mx.utils.ObjectUtil;

	/**
	 * Marshalls SOAP 1.1 encoded Arrays between XML and ActionScript. * @private
	 */
	public class SOAPArrayType implements ICustomSOAPType
	{
		private var _dimensions : Array;
		private var dimensionString : String;
		private var itemName : QName;
		private var processor : SchemaProcessor;
		private var schemaConstants : SchemaConstants;
		private var schemaManager : SchemaManager;
		private var schemaTypeName : String;
		private var schemaType : QName;
		private var soapConstants : SOAPConstants;

		private function get dimensions () : Array;

		public function SOAPArrayType ();
		/**
		 * Encode an ActionScript Array as a SOAP encoded Array in XML.     *      * TODO: Support soap array offset and item position attributes?
		 */
		public function encode (encoder:SOAPEncoder, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Decodes a SOAP encoded array assuming the XML Schema type definiton     * uses a complexType restriction base to declare the array type, e.g.     *      * <pre>     * &lt;xsd:complexType name="Example"&gt;     *   &lt;xsd:complexContent mixed="false"&gt;     *     &lt;xsd:restriction base="soapenc:Array"&gt;     *       &lt;xsd:attribute wsdl:arrayType="tns:Example[]" ref="soapenc:arrayType"      *           xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" /&gt;     *      &lt;/xsd:restriction&gt;     *   &lt;/xsd:complexContent&gt;     * &lt;/xsd:complexType&gt;     * </pre>
		 */
		public function decode (decoder:SOAPDecoder, parent:*, name:*, value:*, restriction:XML = null) : void;
		/**
		 * Recursively called to encode a set of dimensions at a particular level     * (potentially many of a jagged/nested array) of an Array.
		 */
		private function encodeArray (parent:XML, dimensions:Array, value:*) : void;
		private function decodeArray (parent:*, dimensions:Array, value:*, makeObjectsBindable:Boolean) : void;
		private function encodeArrayItem (item:XML, value:*) : void;
		private function decodeArrayItem (parent:*, value:*) : void;
		private function encodeDimensionInformation (parent:XML, dimensionString:String) : void;
		private function getSingleElementFromNode (node:XML, ...types:Array) : XML;
		private function determineWSDLArrayType (restriction:XML, wsdlConstants:WSDLConstants) : String;
		/**
		 * Parses the WSDL arrayType to determine the type of the members in a SOAP     * encoded array, the rank and dimensions of the Array, and potentially     * the size of the Array (if not unbounded).     *      * TODO: Support SOAP 1.2 syntax for Arrays.     *      * Examples:     * 1. An unbounded Array of strings:     * <xsd:attribute ref="soap-enc:arrayType" wsdl:arrayType="xsd:string[]" />     *      * 2. An Array with 5 members of type "Array of integers":     * <xsd:attribute ref="soap-enc:arrayType" wsdl:arrayType="xsd:int[][5]" />     *      * 3. An Array with 3 members of type "two-dimensional arrays of integers":     * <xsd:attribute ref="soap-enc:arrayType" wsdl:arrayType="xsd:int[,][3]" />     *      * @param wsdlArrayType The value of the wsdl:arrayType attribute that     * specifies the signature of the SOAP encoded array including the type and     * the dimensions and size information.
		 */
		private function parseWSDLArrayType (wsdlArrayType:String) : void;
		private function parseDimensions (wsdlArrayType:String, dimensionsString:String, currentDimension:Array) : void;
		/**
		 * Attempts to unwrap MXML Array properties that are wrapped in an Object     * with a single child element that is an Array itself.     *      * e.g. the following MXML:     *      * <mx:request>     *     <inputArray>     *         <item>A</item>     *         <item>B</item>     *     </inputArray>     * </mx:request>     *      * would return an Object for inputArray as {item:[A,B]} instead of     * simply the Array [A,B].
		 */
		private function unwrapMXMLArray (value:*) : *;
	}
}
