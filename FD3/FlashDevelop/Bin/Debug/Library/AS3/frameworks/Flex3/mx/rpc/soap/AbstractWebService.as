/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	import mx.rpc.AbstractService;
	public class AbstractWebService extends AbstractService {
		/**
		 * The description of the service for the currently active port.
		 */
		public function get description():String;
		public function set description(value:String):void;
		/**
		 * The destination of the service. This value should match a destination
		 *  entry in the services-config.xml file.
		 */
		public function get destination():String;
		public function set destination(value:String):void;
		/**
		 * The location of the WebService. Normally, the WSDL document specifies
		 *  the location of the services, but you can set this property to override
		 *  that location.
		 */
		public function get endpointURI():String;
		public function set endpointURI(value:String):void;
		/**
		 * Returns the array of SOAPHeaders registered for the WebService.
		 */
		public function get headers():Array;
		/**
		 * Custom HTTP headers to be sent to the SOAP endpoint. If multiple
		 *  headers need to be sent with the same name the value should be specified
		 *  as an Array.
		 */
		public function get httpHeaders():Object;
		public function set httpHeaders(value:Object):void;
		/**
		 * When this value is true, anonymous objects returned are forced to
		 *  bindable objects.
		 */
		public function get makeObjectsBindable():Boolean;
		public function set makeObjectsBindable(value:Boolean):void;
		/**
		 * Specifies the port within the WSDL document that this WebService should
		 *  use
		 */
		public function get port():String;
		public function set port(value:String):void;
		/**
		 * Specifies whether the WebService is ready to make requests.
		 */
		public function get ready():Boolean;
		/**
		 * The URL that the WebService should use when computing relative URLs. This
		 *  property is only used when going through the proxy. When the
		 *  useProxy property is set to false the relative
		 *  URL is computed automatically based on the location of the SWF running
		 *  this application. If not set explicitly rootURL is
		 *  automatically set to the URL of mx.messaging.config.LoaderConfig.url.
		 */
		public function get rootURL():String;
		public function set rootURL(value:String):void;
		/**
		 * Specifies the service within the WSDL document that this WebService
		 *  should use.
		 */
		public function get service():String;
		public function set service(value:String):void;
		/**
		 * Specifies whether to use the Flex proxy service. The default value is
		 *  false. If you do not specify true to proxy
		 *  requests though the Flex server, you must ensure that Flash Player can
		 *  reach the target URL. You also cannot use destinations defined in the
		 *  services-config.xml file if the useProxy property is set
		 *  to false.
		 */
		public function get useProxy():Boolean;
		public function set useProxy(value:Boolean):void;
		/**
		 * Custom function to be used to escape XML special characters before
		 *  encoding any simple content. Valid for all operations on the web
		 *  service unless specifically overwritten on the operation level.
		 *  If none is provided, the defaults to whatever is set by the particular
		 *  implementation of IXMLEncoder
		 */
		public function get xmlSpecialCharsFilter():Function;
		public function set xmlSpecialCharsFilter(value:Function):void;
		/**
		 * Creates a new WebService.  The destination, if specified, should match an
		 *  entry in services-config.xml.  If unspecified, the WebService uses the
		 *  DefaultHTTP destination. The rootURL is required if you
		 *  intend to use a relative URL find the WSDL document for this WebService.
		 *
		 * @param destination       <String (default = null)> 
		 * @param rootURL           <String (default = null)> 
		 */
		public function AbstractWebService(destination:String = null, rootURL:String = null);
		/**
		 * Adds a header that will be applied to all operations of this web service.
		 *  The header can be provided in a pre-encoded form as an XML instance, or
		 *  as a SOAPHeader instance which leaves the encoding up to the internal
		 *  SOAP encoder.
		 *
		 * @param header            <Object> The SOAP header to add to all operations.
		 */
		public function addHeader(header:Object):void;
		/**
		 * Add a header that will be applied to all operations of this WebService.
		 *
		 * @param qnameLocal        <String> the localname for the header QName
		 * @param qnameNamespace    <String> the namespace for header QName
		 * @param headerName        <String> the name of the header
		 * @param headerValue       <String> the value of the header
		 */
		public function addSimpleHeader(qnameLocal:String, qnameNamespace:String, headerName:String, headerValue:String):void;
		/**
		 * Clears the headers that applied to all operations.
		 */
		public function clearHeaders():void;
		/**
		 * Returns a header if a match is found based on QName localName and URI.
		 *
		 * @param qname             <QName> QName of the SOAPHeader.
		 * @param headerName        <String (default = null)> Name of a header in the SOAPHeader content (Optional)
		 */
		public function getHeader(qname:QName, headerName:String = null):SOAPHeader;
		/**
		 * Removes the header with the given QName from all operations.
		 *
		 * @param qname             <QName> QName of the SOAPHeader.
		 * @param headerName        <String (default = null)> Name of a header in the SOAPHeader content (Optional)
		 */
		public function removeHeader(qname:QName, headerName:String = null):void;
		/**
		 * The username and password to authenticate a user when accessing
		 *  the webservice.  These will be passed as part of the HTTP Authorization
		 *  header from the proxy to the endpoint. If useProxy is false this property
		 *  will be ignored.
		 *
		 * @param remoteUsername    <String> the username to pass to the remote endpoint
		 * @param remotePassword    <String> the password to pass to the remote endpoint
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            remote credentials. The default is null, which implies the legacy charset
		 *                            of ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public override function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null):void;
		/**
		 */
		public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
		/**
		 */
		public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
	}
}
