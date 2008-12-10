package mx.rpc.xml
{
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;

	/**
	 * Establishes the constants for a particular version of XML Schema * Definition (XSD) and XML Schema Instance (XSI). The default namespaces are * http://www.w3.org/2001/XMLSchema and * http://www.w3.org/2001/XMLSchema-instance respectively (which correspond * to XML Schema 1.1). *  * @private
	 */
	public class SchemaConstants
	{
		public var allQName : QName;
		public var anyTypeQName : QName;
		public var annotationQName : QName;
		public var anyQName : QName;
		public var anyAttributeQName : QName;
		public var appinfoQName : QName;
		public var attributeQName : QName;
		public var attributeGroupQName : QName;
		public var choiceQName : QName;
		public var complexContentQName : QName;
		public var complexTypeQName : QName;
		public var documentationQName : QName;
		public var elementTypeQName : QName;
		public var enumerationTypeQName : QName;
		public var extensionQName : QName;
		public var fieldQName : QName;
		public var groupQName : QName;
		public var importQName : QName;
		public var includeQName : QName;
		public var keyQName : QName;
		public var keyrefQName : QName;
		public var lengthQName : QName;
		public var listQName : QName;
		public var maxInclusiveQName : QName;
		public var maxLengthQName : QName;
		public var minInclusiveQName : QName;
		public var minLengthQName : QName;
		public var nameQName : QName;
		public var patternQName : QName;
		public var redefineQName : QName;
		public var restrictionQName : QName;
		public var schemaQName : QName;
		public var selectorQName : QName;
		public var sequenceQName : QName;
		public var simpleContentQName : QName;
		public var simpleTypeQName : QName;
		public var unionQName : QName;
		public var uniqueQName : QName;
		public var nilQName : QName;
		public var typeAttrQName : QName;
		/**
		 * The namespace representing the version of XML Schema Definition (XSD).      * Currently versions 1999, 2000 and 2001 are supported.
		 */
		private var _xsdNS : Namespace;
		/**
		 * The namespace representing the version of XML Schema Instance (XSI).      * Currently versions 1999, 2000 and 2001 are supported.
		 */
		private var _xsiNS : Namespace;
		private static var constantsCache : Object;
		public static const MODE_TYPE : int = 0;
		public static const MODE_ELEMENT : int = 1;
		public static const XSD_URI_1999 : String = "http://www.w3.org/1999/XMLSchema";
		public static const XSD_URI_2000 : String = "http://www.w3.org/2000/10/XMLSchema";
		public static const XSD_URI_2001 : String = "http://www.w3.org/2001/XMLSchema";
		public static const XSI_URI_1999 : String = "http://www.w3.org/1999/XMLSchema-instance";
		public static const XSI_URI_2000 : String = "http://www.w3.org/2000/10/XMLSchema-instance";
		public static const XSI_URI_2001 : String = "http://www.w3.org/2001/XMLSchema-instance";
		public static const XML_SCHEMA_PREFIX : String = "xsd";
		public static const XML_SCHEMA_INSTANCE_PREFIX : String = "xsi";
		public static const XML_SCHEMA_URI : String = "http://www.w3.org/2001/XMLSchema";
		public static const XML_SCHEMA_INSTANCE_URI : String = "http://www.w3.org/2001/XMLSchema-instance";

		public function get xsdURI () : String;
		public function get xsdNamespace () : Namespace;
		public function get xsiURI () : String;
		public function get xsiNamespace () : Namespace;

		public function SchemaConstants (xsdNS:Namespace = null, xsiNS:Namespace = null);
		public function getXSDToken (type:QName) : String;
		public function getXSIToken (type:QName) : String;
		public function getQName (localName:String) : QName;
		public static function getConstants (xml:XML = null) : SchemaConstants;
	}
}
