package mx.rpc.http
{
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import mx.core.mx_internal;
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.config.LoaderConfig;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractInvoker;
	import mx.rpc.AsyncDispatcher;
	import mx.rpc.AsyncRequest;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.rpc.xml.SimpleXMLEncoder;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;

	/**
	 *  Dispatched when an HTTPService call returns successfully. * @eventType mx.rpc.events.ResultEvent.RESULT
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 *  Dispatched when an HTTPService call fails. * @eventType mx.rpc.events.FaultEvent.FAULT
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 
	/**
	 *  The invoke event is fired when an HTTPService call is invoked so long as *  an Error is not thrown before the Channel attempts to send the message. * @eventType mx.rpc.events.InvokeEvent.INVOKE
	 */
	[Event(name="invoke", type="mx.rpc.events.InvokeEvent")] 

	/**
	 * You use the <code>&lt;mx:HTTPService&gt;</code> tag to represent an  * HTTPService object in an MXML file. When you call the HTTPService object's  * <code>send()</code> method, it makes an HTTP request to the  * specified URL, and an HTTP response is returned. Optionally, you can pass  * parameters to the specified URL. When you do not go through the server-based  * proxy service, you can use only HTTP GET or POST methods. However, when you set  * the useProxy  property to true and you use the server-based proxy service, you * can also use the HTTP HEAD, OPTIONS, TRACE, and DELETE methods. * *  <p><b>Note:</b> Due to a software limitation, HTTPService does not generate user-friendly *  error messages when using GET.</p> *  @see mx.rpc.http.mxml.HTTPService
	 */
	public class HTTPService extends AbstractInvoker
	{
		/**
		 *  The result format "e4x" specifies that the value returned is an XML instance, which can be accessed using ECMAScript for XML (E4X) expressions.
		 */
		public static const RESULT_FORMAT_E4X : String = "e4x";
		/**
		 *  The result format "flashvars" specifies that the value returned is text containing name=value pairs     *  separated by ampersands, which is parsed into an ActionScript object.
		 */
		public static const RESULT_FORMAT_FLASHVARS : String = "flashvars";
		/**
		 *  The result format "object" specifies that the value returned is XML but is parsed as a tree of ActionScript objects. This is the default.
		 */
		public static const RESULT_FORMAT_OBJECT : String = "object";
		/**
		 *  The result format "array" is similar to "object" however the value returned is always an Array such     *  that if the result returned from result format "object" is not an Array already the item will be     *  added as the first item to a new Array.
		 */
		public static const RESULT_FORMAT_ARRAY : String = "array";
		/**
		 *  The result format "text" specifies that the HTTPService result text should be an unprocessed String.
		 */
		public static const RESULT_FORMAT_TEXT : String = "text";
		/**
		 *  The result format "xml" specifies that results should be returned as an flash.xml.XMLNode instance pointing to     *  the first child of the parent flash.xml.XMLDocument.
		 */
		public static const RESULT_FORMAT_XML : String = "xml";
		/**
		 *  Indicates that the data being sent by the HTTP service is encoded as application/xml.
		 */
		public static const CONTENT_TYPE_XML : String = "application/xml";
		/**
		 *  Indicates that the data being sent by the HTTP service is encoded as application/x-www-form-urlencoded.
		 */
		public static const CONTENT_TYPE_FORM : String = "application/x-www-form-urlencoded";
		/**
		 *  Indicates that the HTTPService object uses the DefaultHTTP destination.
		 */
		public static const DEFAULT_DESTINATION_HTTP : String = "DefaultHTTP";
		/**
		 *  Indicates that the HTTPService object uses the DefaultHTTPS destination.
		 */
		public static const DEFAULT_DESTINATION_HTTPS : String = "DefaultHTTPS";
		/**
		 *  Indicates that the useProxy property was set to false but a url was not provided.
		 */
		public static const ERROR_URL_REQUIRED : String = "Client.URLRequired";
		/**
		 *  Indicates that an XML formatted result could not be parsed into an XML instance     *  or decoded into an Object.
		 */
		public static const ERROR_DECODING : String = "Client.CouldNotDecode";
		/**
		 *  Indicates that an input parameter could not be encoded as XML.
		 */
		public static const ERROR_ENCODING : String = "Client.CouldNotEncode";
		/**
		 *  @private     *  A shared direct Http channelset used for service instances that do not use the proxy.
		 */
		private static var _directChannelSet : ChannelSet;
		/**
		 *  @private     *  Logger
		 */
		private var _log : ILogger;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  Type of content for service requests.      *  The default is <code>application/x-www-form-urlencoded</code> which sends requests     *  like a normal HTTP POST with name-value pairs. <code>application/xml</code> send     *  requests as XML.
		 */
		public var contentType : String;
		/**
		 *  Custom HTTP headers to be sent to the third party endpoint. If multiple headers need to     *  be sent with the same name the value should be specified as an Array.
		 */
		public var headers : Object;
		/**
		 *  HTTP method for sending the request. Permitted values are <code>GET</code>, <code>POST</code>, <code>HEAD</code>,     *  <code>OPTIONS</code>, <code>PUT</code>, <code>TRACE</code> and <code>DELETE</code>.     *  Lowercase letters are converted to uppercase letters. The default value is <code>GET</code>.
		 */
		public var method : String;
		/**
		 *  Object of name-value pairs used as parameters to the URL. If     *  the <code>contentType</code> property is set to <code>application/xml</code>, it should be an XML document.
		 */
		public var request : Object;
		/**
		 *  @private
		 */
		private var _resultFormat : String;
		/**
		 *  @private
		 */
		local var _rootURL : String;
		/**
		 *  @private
		 */
		private var _url : String;
		/**
		 *  @private
		 */
		private var _useProxy : Boolean;
		/**
		 *  ActionScript function used to decode a service result from XML.     *  When the <code>resultFormat</code> is an object and the <code>xmlDecode</code> property is set,     *  Flex uses the XML that the HTTPService returns to create an     *  Object. If it is not defined the default XMLDecoder is used     *  to do the work.     *  <p>The function referenced by the <code>xmlDecode</code> property must     *  take a flash.xml.XMLNode object as a parameter and should return     *  an Object. It can return any type of object, but it must return     *  something. Returning <code>null</code> or <code>undefined</code> causes a fault.</p>    The following example shows an &lt;mx:HTTPService&gt; tag that specifies an xmlDecode function:<pre>   &lt;mx:HTTPService id="hs" xmlDecode="xmlDecoder" url="myURL" resultFormat="object" contentType="application/xml"&gt;        &lt;mx:request&gt;&lt;source/&gt;            &lt;obj&gt;{RequestObject}&lt;/obj&gt;        &lt;/mx:request&gt;   &lt;/mx:HTTPService&gt;</pre>    The following example shows an xmlDecoder function:<pre>function xmlDecoder (myXML){ // Simplified decoding logic. var myObj = {}; myObj.name = myXML.firstChild.nodeValue; myObj.honorific = myXML.firstChild.attributes.honorific; return myObj;}</pre>
		 */
		public var xmlDecode : Function;
		/**
		 *  ActionScript function used to encode a service request as XML.     *  When the <code>contentType</code> of a request is <code>application/xml</code> and the     *  request object passed in is an Object, Flex attempts to use     *  the function specified in the <code>xmlEncode</code> property to turn it     *  into a flash.xml.XMLNode object If the <code>xmlEncode</code> property is not set,      *  Flex uses the default     *  XMLEncoder to turn the object graph into a flash.xml.XMLNode object.     *      *  <p>The <code>xmlEncode</code> property takes an Object and should return     *  a flash.xml.XMLNode object. In this case, the XMLNode object can be a flash.xml.XML object,     *  which is a subclass of XMLNode, or the first child of the     *  flash.xml.XML object, which is what you get from an <code>&lt;mx:XML&gt;</code> tag.     *  Returning the wrong type of object causes a fault.     *  The following example shows an &lt;mx:HTTPService&gt; tag that specifies an xmlEncode function:</p>    <pre>  &lt;mx:HTTPService id="hs" xmlEncode="xmlEncoder" url="myURL" resultFormat="object" contentType="application/xml"&gt;        &lt;mx:request&gt;&lt;source/&gt;            &lt;obj&gt;{RequestObject}&lt;/obj&gt;        &lt;/mx:request&gt;   &lt;/mx:HTTPService&gt;    </pre>    The following example shows an xmlEncoder function:<pre>function xmlEncoder (myObj){  return new XML("<userencoded><attrib0>MyObj.test</attrib0>  <attrib1>MyObj.anotherTest</attrib1></userencoded>");}</pre>
		 */
		public var xmlEncode : Function;

		/**
		 *  Provides access to the ChannelSet used by the service. The     *  ChannelSet can be manually constructed and assigned, or it will be      *  dynamically created to use the configured Channels for the     *  <code>destination</code> for this service.
		 */
		public function get channelSet () : ChannelSet;
		/**
		 *  @private
		 */
		public function set channelSet (value:ChannelSet) : void;
		/**
		 *  An HTTPService destination name in the services-config.xml file. When     *  unspecified, Flex uses the <code>DefaultHTTP</code> destination.     *  If you are using the <code>url</code> property, but want requests     *  to reach the proxy over HTTPS, specify <code>DefaultHTTPS</code>.
		 */
		public function get destination () : String;
		/**
		 *  @private
		 */
		public function set destination (value:String) : void;
		/**
		 *  Provides access to the request timeout in seconds for sent messages.      *  A value less than or equal to zero prevents request timeout.
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;
		/**
		 *  Value that indicates how you want to deserialize the result     *  returned by the HTTP call. The value for this is based on the following:     *  <ul>     *  <li>Whether you are returning XML or name/value pairs.</li>     *  <li>How you want to access the results; you can access results as an object,     *    text, or XML.</li>     *  </ul>     *      *  <p>The default value is <code>object</code>. The following values are permitted:</p>     *  <ul>     *  <li><code>object</code> The value returned is XML and is parsed as a tree of ActionScript     *    objects. This is the default.</li>     *  <li><code>array</code> The value returned is XML and is parsed as a tree of ActionScript     *    objects however if the top level object is not an Array, a new Array is created and the result     *    set as the first item. If makeObjectsBindable is true then the Array      *    will be wrapped in an ArrayCollection.</li>     *  <li><code>xml</code> The value returned is XML and is returned as literal XML in an     *    ActionScript XMLnode object.</li>     *  <li><code>flashvars</code> The value returned is text containing      *    name=value pairs separated by ampersands, which     *  is parsed into an ActionScript object.</li>     *  <li><code>text</code> The value returned is text, and is left raw.</li>     *  <li><code>e4x</code> The value returned is XML and is returned as literal XML      *    in an ActionScript XML object, which can be accessed using ECMAScript for      *    XML (E4X) expressions.</li>     *  </ul>
		 */
		public function get resultFormat () : String;
		/**
		 *  @private
		 */
		public function set resultFormat (value:String) : void;
		/**
		 *  The URL that the HTTPService object should use when computing relative URLs.     *  This property is only used when going through the proxy.     *  When the <code>useProxy</code> property is set to <code>false</code>, the relative URL is computed automatically     *  based on the location of the SWF running this application.     *  If not set explicitly <code>rootURL</code> is automatically set to the URL of     *  mx.messaging.config.LoaderConfig.url.
		 */
		public function get rootURL () : String;
		/**
		 *  @private
		 */
		public function set rootURL (value:String) : void;
		/**
		 *  Location of the service. If you specify the <code>url</code> and a non-default destination,     *  your destination in the services-config.xml file must allow the specified URL.
		 */
		public function get url () : String;
		/**
		 *  @private
		 */
		public function set url (value:String) : void;
		/**
		 *  Specifies whether to use the Flex proxy service. The default value is <code>false</code>. If you     *  do not specify <code>true</code> to proxy requests though the Flex server, you must ensure that the player      *  can reach the target URL. You also cannot use destinations defined in the services-config.xml file if the     *  <code>useProxy</code> property is set to <code>false</code>.     *     *  @default false
		 */
		public function get useProxy () : Boolean;
		/**
		 *  @private
		 */
		public function set useProxy (value:Boolean) : void;

		/**
		 *  Creates a new HTTPService. If you expect the service to send using relative URLs you may     *  wish to specify the <code>rootURL</code> that will be the basis for determining the full URL (one example     *  would be <code>Application.application.url</code>).     *     * @param rootURL The URL the HTTPService should use when computing relative URLS.     *     * @param destination An HTTPService destination name in the service-config.xml file.
		 */
		public function HTTPService (rootURL:String = null, destination:String = null);
		/**
		 *  Logs the user out of the destination.      *  Logging out of a destination applies to everything connected using the same channel     *  as specified in the server configuration. For example, if you're connected over the my-rtmp channel     *  and you log out using one of your RPC components, anything that was connected over my-rtmp is logged out.
		 */
		public function logout () : void;
		/**
		 *  Executes an HTTPService request. The parameters are optional, but if specified should     *  be an Object containing name-value pairs or an XML object depending on the <code>contentType</code>.     *     *  @param parameters An Object containing name-value pairs or an     *  XML object, depending on the content type for service     *  requests.     *      *  @return An object representing the asynchronous completion token. It is the same object     *  available in the <code>result</code> or <code>fault</code> event's <code>token</code> property.
		 */
		public function send (parameters:Object = null) : AsyncToken;
		/**
		 *  Disconnects the service's network connection.     *  This method does not wait for outstanding network operations to complete.
		 */
		public function disconnect () : void;
		/**
		 *  Sets the credentials for the destination accessed by the service.     *  The credentials are applied to all services connected over the same ChannelSet.     *  Note that services that use a proxy to a remote destination     *  will need to call the <code>setRemoteCredentials()</code> method instead.     *      *  @param username the username for the destination.     *  @param password the password for the destination.     *  @param charset The character set encoding to use while encoding the     *  credentials. The default is null, which implies the legacy charset of     *  ISO-Latin-1. The only other supported charset is &quot;UTF-8&quot;.
		 */
		public function setCredentials (username:String, password:String, charset:String = null) : void;
		/**
		 *  The username and password to authenticate a user when accessing     *  the HTTP URL. These are passed as part of the HTTP Authorization     *  header from the proxy to the endpoint. If the <code>useProxy</code> property     *  is set to is false, this property is ignored.     *          *  @param remoteUsername the username to pass to the remote endpoint.     *  @param remotePassword the password to pass to the remote endpoint.     *  @param charset The character set encoding to use while encoding the     *  remote credentials. The default is null, which implies the legacy     *  charset of ISO-Latin-1. The only other supported charset is     *  &quot;UTF-8&quot;.
		 */
		public function setRemoteCredentials (remoteUsername:String, remotePassword:String, charset:String = null) : void;
		/**
		 *  @private
		 */
		function processResult (message:IMessage, token:AsyncToken) : Boolean;
		private function decodeArray (o:Object) : Object;
		private function decodeParameterString (source:String) : Object;
		private function getDirectChannelSet () : ChannelSet;
	}
}
