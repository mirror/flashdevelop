package mx.rpc.soap
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.rpc.soap.types.ICustomSOAPType;
	import mx.rpc.soap.types.MapType;
	import mx.rpc.soap.types.QueryBeanType;
	import mx.rpc.soap.types.RowSetType;
	import mx.rpc.soap.types.SOAPArrayType;
	import mx.rpc.soap.types.ApacheDocumentType;
	import mx.rpc.soap.types.DataSetType;
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;

	/**
	 * A helper class listing all of the constants required to encode and decode * SOAP messages. *  * @private
	 */
	public class SOAPConstants
	{
		public var envelopeQName : QName;
		public var headerQName : QName;
		public var bodyQName : QName;
		public var faultQName : QName;
		public var actorQName : QName;
		public var mustUnderstandQName : QName;
		public var soapencArrayQName : QName;
		public var soapencArrayTypeQName : QName;
		public var soapencRefQName : QName;
		public var soapoffsetQName : QName;
		public var soapBase64QName : QName;
		private var _contentType : String;
		private var _envelopeNS : Namespace;
		private var _encodingNS : Namespace;
		private static var constantsCache : Object;
		private static var customTypesInitialized : Boolean;
		private static var typeMap : Object;
		public static const queryBeanQName : QName = new QName(COLD_FUSION_URI, "QueryBean");
		public static const rowSetQName : QName = new QName(APACHE_SOAP_URI, "RowSet");
		public static const mapQName : QName = new QName(APACHE_SOAP_URI, "Map");
		public static const documentQName : QName = new QName(APACHE_SOAP_URI, "Document");
		public static const msdataURI : String = "urn:schemas-microsoft-com:xml-msdata";
		public static const diffgramQName : QName = new QName("urn:schemas-microsoft-com:xml-diffgram-v1", "diffgram");
		public static const SOAP_ENVELOPE_URI : String = "http://schemas.xmlsoap.org/soap/envelope/";
		public static const SOAP12_ENVELOPE_URI : String = "http://www.w3.org/2002/12/soap-envelope";
		public static const XML_DECLARATION : String = "<?xml version=1.0 encoding=utf-8?>";
		public static const SOAP_ENCODING_URI : String = "http://schemas.xmlsoap.org/soap/encoding/";
		public static const SOAP12_ENCODING_URI : String = "http://www.w3.org/2002/12/soap-encoding";
		public static const SOAP_CONTENT_TYPE : String = "text/xml; charset=utf-8";
		public static const SOAP12_CONTENT_TYPE : String = "application/soap+xml; charset=utf-8";
		public static const RPC_STYLE : String = "rpc";
		public static const DOC_STYLE : String = "document";
		public static const WRAPPED_STYLE : String = "wrapped";
		public static const USE_ENCODED : String = "encoded";
		public static const USE_LITERAL : String = "literal";
		public static const DEFAULT_OPERATION_STYLE : String = "document";
		public static const DEFAULT_USE : String = "literal";
		public static const SOAP_ENV_PREFIX : String = "SOAP-ENV";
		public static const SOAP_ENC_PREFIX : String = "SOAP-ENC";
		public static const COLD_FUSION_URI : String = "http://rpc.xml.coldfusion";
		public static const APACHE_SOAP_URI : String = "http://xml.apache.org/xml-soap";

		public function get contentType () : String;
		public function get encodingURI () : String;
		public function get encodingNamespace () : Namespace;
		public function get envelopeURI () : String;
		public function get envelopeNamespace () : Namespace;

		public function SOAPConstants (envelopeNS:Namespace = null, encodingNS:Namespace = null);
		public function getSOAPEncodingToken (type:QName) : String;
		public static function getConstants (xml:XML = null) : SOAPConstants;
		public static function isSOAPEncodedType (type:QName) : Boolean;
		/**
		 * Looks for an ICustomSOAPType implementation for the given type.      *      * @return A new instance of the ICustomSOAPType, if registered, otherwise     * null.
		 */
		public static function getCustomSOAPType (type:QName) : ICustomSOAPType;
		/**
		 * Maps a type QName to a definition of an ISOAPType implementation.     * The definition can be a String representation of the fully qualified     * class name, an Object instance or the Class instance itself.
		 */
		public static function registerCustomSOAPType (type:QName, definition:*) : void;
		/**
		 * Removes the ICustomSOAPType from the registry for the given type.
		 */
		public static function unregisterCustomSOAPType (type:QName) : void;
		private static function getKey (type:QName) : String;
		private static function initCustomSOAPTypes () : void;
	}
}
