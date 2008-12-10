package mx.rpc.xml
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import mx.utils.ObjectUtil;

	/**
	 * The SimpleXMLEncoder class takes ActionScript Objects and encodes them to XML * using default serialization.
	 */
	public class SimpleXMLEncoder
	{
		private var myXMLDoc : XMLDocument;
		private static const NUMBER_TYPE : uint = 0;
		private static const STRING_TYPE : uint = 1;
		private static const OBJECT_TYPE : uint = 2;
		private static const DATE_TYPE : uint = 3;
		private static const BOOLEAN_TYPE : uint = 4;
		private static const XML_TYPE : uint = 5;
		private static const ARRAY_TYPE : uint = 6;
		private static const MAP_TYPE : uint = 7;
		private static const ANY_TYPE : uint = 8;
		private static const ROWSET_TYPE : uint = 11;
		private static const QBEAN_TYPE : uint = 12;
		private static const DOC_TYPE : uint = 13;
		private static const SCHEMA_TYPE : uint = 14;
		private static const FUNCTION_TYPE : uint = 15;
		private static const ELEMENT_TYPE : uint = 16;
		private static const BASE64_BINARY_TYPE : uint = 17;
		private static const HEX_BINARY_TYPE : uint = 18;
		/**
		 * @private
		 */
		private static const CLASS_INFO_OPTIONS : Object;

		/**
		 * @private
		 */
		static function encodeDate (rawDate:Date, dateType:String) : String;
		public function SimpleXMLEncoder (myXML:XMLDocument);
		/**
		 * Encodes an ActionScript object to XML using default serialization.     *      * @param obj The ActionScript object to encode.     *      * @param qname The qualified name of the child node.     *      * @param parentNode An XMLNode under which to put the encoded     * value.
		 */
		public function encodeValue (obj:Object, qname:QName, parentNode:XMLNode) : XMLNode;
		/**
		 *  @private
		 */
		private function getDataTypeFromObject (obj:Object) : uint;
	}
}
