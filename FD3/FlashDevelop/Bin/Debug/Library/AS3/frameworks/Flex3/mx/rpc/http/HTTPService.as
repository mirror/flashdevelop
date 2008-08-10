/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.http {
	import mx.rpc.AbstractInvoker;
	import mx.messaging.ChannelSet;
	public class HTTPService extends AbstractInvoker {
		/**
		 * Provides access to the ChannelSet used by the service. The
		 *  ChannelSet can be manually constructed and assigned, or it will be
		 *  dynamically created to use the configured Channels for the
		 *  destination for this service.
		 */
		public function get channelSet():ChannelSet;
		public function set channelSet(value:ChannelSet):void;
		/**
		 * Type of content for service requests.
		 *  The default is application/x-www-form-urlencoded which sends requests
		 *  like a normal HTTP POST with name-value pairs. application/xml send
		 *  requests as XML.
		 */
		public var contentType:String = "application/x-www-form-urlencoded";
		/**
		 * An HTTPService destination name in the services-config.xml file. When
		 *  unspecified, Flex uses the DefaultHTTP destination.
		 *  If you are using the url property, but want requests
		 *  to reach the proxy over HTTPS, specify DefaultHTTPS.
		 */
		public function get destination():String;
		public function set destination(value:String):void;
		/**
		 * Custom HTTP headers to be sent to the third party endpoint. If multiple headers need to
		 *  be sent with the same name the value should be specified as an Array.
		 */
		public var headers:Object;
		/**
		 * HTTP method for sending the request. Permitted values are GET, POST, HEAD,
		 *  OPTIONS, PUT, TRACE and DELETE.
		 *  Lowercase letters are converted to uppercase letters. The default value is GET.
		 */
		public var method:String = "GET";
		/**
		 * Object of name-value pairs used as parameters to the URL. If
		 *  the contentType property is set to application/xml, it should be an XML document.
		 */
		public var request:Object;
		/**
		 * Provides access to the request timeout in seconds for sent messages.
		 *  A value less than or equal to zero prevents request timeout.
		 */
		public function get requestTimeout():int;
		public function set requestTimeout(value:int):void;
		/**
		 * Value that indicates how you want to deserialize the result
		 *  returned by the HTTP call. The value for this is based on the following:
		 *  Whether you are returning XML or name/value pairs.
		 *  How you want to access the results; you can access results as an object,
		 *  text, or XML.
		 */
		public function get resultFormat():String;
		public function set resultFormat(value:String):void;
		/**
		 * The URL that the HTTPService object should use when computing relative URLs.
		 *  This property is only used when going through the proxy.
		 *  When the useProxy property is set to false, the relative URL is computed automatically
		 *  based on the location of the SWF running this application.
		 *  If not set explicitly rootURL is automatically set to the URL of
		 *  mx.messaging.config.LoaderConfig.url.
		 */
		public function get rootURL():String;
		public function set rootURL(value:String):void;
		/**
		 * Location of the service. If you specify the url and a non-default destination,
		 *  your destination in the services-config.xml file must allow the specified URL.
		 */
		public function get url():String;
		public function set url(value:String):void;
		/**
		 * Specifies whether to use the Flex proxy service. The default value is false. If you
		 *  do not specify true to proxy requests though the Flex server, you must ensure that the player
		 *  can reach the target URL. You also cannot use destinations defined in the services-config.xml file if the
		 *  useProxy property is set to false.
		 */
		public function get useProxy():Boolean;
		public function set useProxy(value:Boolean):void;
		/**
		 * ActionScript function used to decode a service result from XML.
		 *  When the resultFormat is an object and the xmlDecode property is set,
		 *  Flex uses the XML that the HTTPService returns to create an
		 *  Object. If it is not defined the default XMLDecoder is used
		 *  to do the work.
		 */
		public var xmlDecode:Function;
		/**
		 * ActionScript function used to encode a service request as XML.
		 *  When the contentType of a request is application/xml and the
		 *  request object passed in is an Object, Flex attempts to use
		 *  the function specified in the xmlEncode property to turn it
		 *  into a flash.xml.XMLNode object If the xmlEncode property is not set,
		 *  Flex uses the default
		 *  XMLEncoder to turn the object graph into a flash.xml.XMLNode object.
		 */
		public var xmlEncode:Function;
		/**
		 * Creates a new HTTPService. If you expect the service to send using relative URLs you may
		 *  wish to specify the rootURL that will be the basis for determining the full URL (one example
		 *  would be Application.application.url).
		 *
		 * @param rootURL           <String (default = null)> 
		 * @param destination       <String (default = null)> 
		 */
		public function HTTPService(rootURL:String = null, destination:String = null);
		/**
		 * Disconnects the service's network connection.
		 *  This method does not wait for outstanding network operations to complete.
		 */
		public function disconnect():void;
		/**
		 * Logs the user out of the destination.
		 *  Logging out of a destination applies to everything connected using the same channel
		 *  as specified in the server configuration. For example, if you're connected over the my-rtmp channel
		 *  and you log out using one of your RPC components, anything that was connected over my-rtmp is logged out.
		 */
		public function logout():void;
		/**
		 * Executes an HTTPService request. The parameters are optional, but if specified should
		 *  be an Object containing name-value pairs or an XML object depending on the contentType.
		 *
		 * @param parameters        <Object (default = null)> 
		 * @return                  <AsyncToken> An object representing the asynchronous completion token. It is the same object
		 *                            available in the result or fault event's token property.
		 */
		public function send(parameters:Object = null):AsyncToken;
		/**
		 * Sets the credentials for the destination accessed by the service.
		 *  The credentials are applied to all services connected over the same ChannelSet.
		 *  Note that services that use a proxy to a remote destination
		 *  will need to call the setRemoteCredentials() method instead.
		 *
		 * @param username          <String> the username for the destination.
		 * @param password          <String> the password for the destination.
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            credentials. The default is null, which implies the legacy charset of
		 *                            ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public function setCredentials(username:String, password:String, charset:String = null):void;
		/**
		 * The username and password to authenticate a user when accessing
		 *  the HTTP URL. These are passed as part of the HTTP Authorization
		 *  header from the proxy to the endpoint. If the useProxy property
		 *  is set to is false, this property is ignored.
		 *
		 * @param remoteUsername    <String> the username to pass to the remote endpoint.
		 * @param remotePassword    <String> the password to pass to the remote endpoint.
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            remote credentials. The default is null, which implies the legacy
		 *                            charset of ISO-Latin-1. The only other supported charset is
		 *                            "UTF-8".
		 */
		public function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null):void;
		/**
		 * Indicates that the data being sent by the HTTP service is encoded as application/x-www-form-urlencoded.
		 */
		public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
		/**
		 * Indicates that the data being sent by the HTTP service is encoded as application/xml.
		 */
		public static const CONTENT_TYPE_XML:String = "application/xml";
		/**
		 * Indicates that the HTTPService object uses the DefaultHTTP destination.
		 */
		public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
		/**
		 * Indicates that the HTTPService object uses the DefaultHTTPS destination.
		 */
		public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
		/**
		 * Indicates that an XML formatted result could not be parsed into an XML instance
		 *  or decoded into an Object.
		 */
		public static const ERROR_DECODING:String = "Client.CouldNotDecode";
		/**
		 * Indicates that an input parameter could not be encoded as XML.
		 */
		public static const ERROR_ENCODING:String = "Client.CouldNotEncode";
		/**
		 * Indicates that the useProxy property was set to false but a url was not provided.
		 */
		public static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
		/**
		 * The result format "array" is similar to "object" however the value returned is always an Array such
		 *  that if the result returned from result format "object" is not an Array already the item will be
		 *  added as the first item to a new Array.
		 */
		public static const RESULT_FORMAT_ARRAY:String = "array";
		/**
		 * The result format "e4x" specifies that the value returned is an XML instance, which can be accessed using ECMAScript for XML (E4X) expressions.
		 */
		public static const RESULT_FORMAT_E4X:String = "e4x";
		/**
		 * The result format "flashvars" specifies that the value returned is text containing name=value pairs
		 *  separated by ampersands, which is parsed into an ActionScript object.
		 */
		public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
		/**
		 * The result format "object" specifies that the value returned is XML but is parsed as a tree of ActionScript objects. This is the default.
		 */
		public static const RESULT_FORMAT_OBJECT:String = "object";
		/**
		 * The result format "text" specifies that the HTTPService result text should be an unprocessed String.
		 */
		public static const RESULT_FORMAT_TEXT:String = "text";
		/**
		 * The result format "xml" specifies that results should be returned as an flash.xml.XMLNode instance pointing to
		 *  the first child of the parent flash.xml.XMLDocument.
		 */
		public static const RESULT_FORMAT_XML:String = "xml";
	}
}
