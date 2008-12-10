package mx.rpc.wsdl
{
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;

	/**
	 * Manages the constants for a particular version of WSDL (and its * accompanying version of SOAP). *  * The default version is WSDL 1.1. *  * @private
	 */
	public class WSDLConstants
	{
		public var definitionsQName : QName;
		public var typesQName : QName;
		public var messageQName : QName;
		public var portTypeQName : QName;
		public var bindingQName : QName;
		public var serviceQName : QName;
		public var importQName : QName;
		public var documentationQName : QName;
		public var portQName : QName;
		public var operationQName : QName;
		public var inputQName : QName;
		public var outputQName : QName;
		public var partQName : QName;
		public var faultQName : QName;
		public var wsdlArrayTypeQName : QName;
		public var soapAddressQName : QName;
		public var soapBindingQName : QName;
		public var soapOperationQName : QName;
		public var soapBodyQName : QName;
		public var soapFaultQName : QName;
		public var soapHeaderQName : QName;
		public var soapHeaderFaultQName : QName;
		/**
		 * The namespace representing the version of SOAP used by a WSDL,     * currently 1.1 is supported.     * FIXME: Need SOAP 1.2 support.
		 */
		private var _soapNS : Namespace;
		/**
		 * The namespace representing the version of WSDL, currently only 1.1 is     * supported.     * TODO: Need WSDL 2.0 support.
		 */
		private var _wsdlNS : Namespace;
		private static var constantsCache : Object;
		public static const SOAP_HTTP_URI : String = "http://schemas.xmlsoap.org/soap/http/";
		public static const MODE_IN : int = 0;
		public static const MODE_OUT : int = 1;
		public static const MODE_FAULT : int = 2;
		public static const MODE_HEADER : int = 3;
		public static const WSDL_URI : String = "http://schemas.xmlsoap.org/wsdl/";
		public static const WSDL_SOAP_URI : String = "http://schemas.xmlsoap.org/wsdl/soap/";
		public static const WSDL_SOAP12_URI : String = "http://schemas.xmlsoap.org/wsdl/soap12/";
		public static const WSDL_HTTP_URI : String = "http://schemas.xmlsoap.org/wsdl/http/";
		public static const WSDL20_URI : String = "http://www.w3.org/2006/01/wsdl";
		public static const WSDL20_SOAP_URI : String = "http://www.w3.org/2006/01/wsdl/soap";
		public static const WSDL20_SOAP12_URI : String = "http://www.w3.org/2006/01/wsdl/soap";
		public static const WSDL20_HTTP_URI : String = "http://www.w3.org/2006/01/wsdl/http";
		public static const WSDL_PREFIX : String = "wsdl";
		public static const WSDL_SOAP_PREFIX : String = "wsoap";
		public static const DEFAULT_STYLE : String = "document";
		public static const DEFAULT_WSDL_VERSION : String = "1.1";

		public function get soapURI () : String;
		public function get wsdlURI () : String;
		public function get soapNamespace () : Namespace;
		public function get wsdlNamespace () : Namespace;

		public function WSDLConstants (wsdlNS:Namespace = null, soapNS:Namespace = null);
		public static function getConstants (xml:XML) : WSDLConstants;
	}
}
