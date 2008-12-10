package mx.rpc.soap
{
	import flash.events.Event;
	import flash.xml.XMLNode;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.logging.ILogger;
	import mx.messaging.ChannelSet;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.SOAPMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.HeaderEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.AbstractWebService;
	import mx.rpc.wsdl.WSDLOperation;
	import mx.rpc.xml.SchemaConstants;
	import mx.utils.ObjectProxy;
	import mx.utils.XMLUtil;
	import mx.rpc.AsyncToken;

	/**
	 * Dispatched when an Operation invocation returns with SOAP headers in the * response. A HeaderEvent is dispatched for each SOAP header. * @eventType mx.rpc.events.HeaderEvent.HEADER
	 */
	[Event(name="header", type="mx.rpc.events.HeaderEvent")] 

	/**
	 * An Operation used specifically by WebServices. An Operation is an individual * method on a service. An Operation can be called either by invoking the * function of the same name on the service or by accessing the Operation as a * property on the service and calling the <code>send()</code> method.
	 */
	public class Operation extends AbstractOperation
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _httpHeaders : Object;
		private var _xmlSpecialCharsFilter : Function;
		/**
		 * @private
		 */
		local var handleAxisSession : Boolean;
		private var _endpointURI : String;
		private var _forcePartArrays : Boolean;
		private var _headerFormat : String;
		private var _headers : Array;
		private var _resultFormat : String;
		private var _makeObjectsBindableSet : Boolean;
		private var _multiplePartsFormat : String;
		private var _decoder : ISOAPDecoder;
		private var _encoder : ISOAPEncoder;
		private var _ignoreWhitespace : Boolean;
		private var log : ILogger;
		private var pendingInvocations : Array;
		private var startTime : Date;
		private var timeout : int;
		private var webService : AbstractWebService;
		/**
		 * @private
		 */
		protected var _wsdlOperation : mx.rpc.wsdl.WSDLOperation;

		/**
		 * The ISOAPDecoder implementation used by this Operation to decode a SOAP     * encoded response into ActionScript.     *      * @private
		 */
		public function get decoder () : ISOAPDecoder;
		/**
		 * @private
		 */
		public function set decoder (value:ISOAPDecoder) : void;
		/**
		 * The ISOAPEncoder implementation used by this Operation to encode     * ActionScript input arguments as a SOAP encoded request.     *      * @private
		 */
		public function get encoder () : ISOAPEncoder;
		/**
		 * @private
		 */
		public function set encoder (value:ISOAPEncoder) : void;
		/**
		 * The location of the WebService for this Operation. Normally, the WSDL     * specifies the location of the services, but you can set this property to     * override that location for the individual Operation.
		 */
		public function get endpointURI () : String;
		public function set endpointURI (uri:String) : void;
		/**
		 * Determines whether or not a single or empty return value for an output     * message part that is defined as an array should be returned as an array     * containing one (or zero, respectively) elements. This is applicable for     * document/literal "wrapped" web services, where one or more of the elements     * that represent individual message parts in the "wrapper" sequence could     * have the maxOccurs attribute set with a value greater than 1. This is a     * hint that the corresponding part should be treated as an array even if     * the response contains zero or one values for that part. Setting     * forcePartArrays to true will always create an array for parts defined in     * this manner, regardless of the number of values returned. Leaving     * forcePartArrays as false will only create arrays if two or more elements     * are returned.
		 */
		public function get forcePartArrays () : Boolean;
		public function set forcePartArrays (value:Boolean) : void;
		/**
		 * Determines how the SOAP encoded headers are decoded. A value of     * <code>object</code> specifies that each header XML node will be decoded     * into a SOAPHeader object, and its <code>content</code> property will be     * an object structure as specified in the WSDL document. A value of     * <code>xml</code> specifies that the XML will be left as XMLNodes. A     * value of <code>e4x</code> specifies that the XML will be accessible     * using ECMAScript for XML (E4X) expressions.
		 */
		public function get headerFormat () : String;
		public function set headerFormat (hf:String) : void;
		/**
		 * Accessor to an Array of SOAPHeaders that are to be sent on     * each invocation of the operation.
		 */
		public function get headers () : Array;
		/**
		 * Custom HTTP headers to be sent to the SOAP endpoint. If multiple     * headers need to be sent with the same name the value should be specified     * as an Array.
		 */
		public function get httpHeaders () : Object;
		public function set httpHeaders (value:Object) : void;
		/**
		 * Determines whether whitespace is ignored when processing XML for a SOAP     * encoded request or response. The default is <code>true</code>     * and thus whitespace is not preserved. If an XML Schema type definition     * specifies a <code>whiteSpace</code> restriction set to     * <code>preserve</code> then ignoreWhitespace must first be set to false.     * Conversely, if a type <code>whiteSpace</code> restriction is set to     * <code>replace</code> or <code>collapse</code> then that setting will     * be honored even if ignoreWhitespace is set to false.
		 */
		public function get ignoreWhitespace () : Boolean;
		public function set ignoreWhitespace (value:Boolean) : void;
		/**
		 * When this value is true, anonymous objects returned are forced to     * bindable objects.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (value:Boolean) : void;
		/**
		 * Determines the type of the default result object for calls to web services     * that define multiple parts in the output message. A value of "object"     * specifies that the lastResult object will be an Object with named properties     * corresponding to the individual output parts. A value of "array" would     * make the lastResult an array, where part values are pushed in the order     * they occur in the body of the SOAP message. The default value for document-     * literal operations is "object". The default for rpc operations is "array".     * The multiplePartsFormat property is applicable only when     * resultFormat is "object" and ignored otherwise.
		 */
		public function get multiplePartsFormat () : String;
		public function set multiplePartsFormat (value:String) : void;
		/**
		 * The request of the Operation is an object structure or an XML structure.     * If you specify XML, the XML is sent as is. If you pass an object, it is     * encoded into a SOAP XML structure.
		 */
		public function get request () : Object;
		public function set request (r:Object) : void;
		/**
		 * Determines how the Operation result is decoded. A value of     * <code>object</code> specifies that the XML will be decoded into an     * object structure as specified in the WSDL document. A value of     * <code>xml</code> specifies that the XML will be left as XMLNodes. A     * value of <code>e4x</code> specifies that the XML will be accessible     * using ECMAScript for XML (E4X) expressions.
		 */
		public function get resultFormat () : String;
		public function set resultFormat (rf:String) : void;
		/**
		 * The headers that were returned as part of the last execution of this     * operation. They match up with the <code>lastResult</code> property and     * are the same as the collection of headers that are dispatched     * individually as HeaderEvents.
		 */
		public function get resultHeaders () : Array;
		public function get xmlSpecialCharsFilter () : Function;
		public function set xmlSpecialCharsFilter (func:Function) : void;
		/**
		 * @private
		 */
		function get wsdlOperation () : WSDLOperation;
		/**
		 * @private
		 */
		function set wsdlOperation (value:WSDLOperation) : void;

		/**
		 * Creates a new Operation. This is usually done directly by the MXML     * compiler or automatically by the WebService when an unknown operation     * has been accessed. It is not recommended that a developer use this     * constructor directly.     *     * @param webService The web service upon which this Operation is invoked.     *     * @param name The name of this Operation.
		 */
		public function Operation (webService:AbstractService = null, name:String = null);
		/**
		 * Adds a header that is applied only to this Operation. The header can be     * provided in a pre-encoded form as an XML instance, or as a SOAPHeader     * instance which leaves the encoding up to the internal SOAP encoder.     * @param header The SOAP header to add to this Operation.
		 */
		public function addHeader (header:Object) : void;
		/**
		 * Adds a header that is applied only to this Operation.     * @param qnameLocal the localname for the header QName     * @param qnameNamespace the namespace for header QName     * @param headerName Name of the header.     * @param headerValue Value of the header.
		 */
		public function addSimpleHeader (qnameLocal:String, qnameNamespace:String, headerName:String, headerValue:String) : void;
		/**
		 * @inheritDoc
		 */
		public function cancel (id:String = null) : AsyncToken;
		/**
		 * Clears the headers for this individual Operation.
		 */
		public function clearHeaders () : void;
		/**
		 * Returns a header if a match is found based on QName localName and URI.     * @param qname QName of the SOAPHeader.     * @param headerName Name of a header in the SOAPHeader content (Optional)     * @return Returns the SOAPHeader.
		 */
		public function getHeader (qname:QName, headerName:String = null) : SOAPHeader;
		/**
		 * Removes the header with the given QName from all operations.     * @param qname QName of the SOAPHeader.     * @param headerName Name of a header in the SOAPHeader content (Optional)
		 */
		public function removeHeader (qname:QName, headerName:String = null) : void;
		/**
		 * @private
		 */
		public function send (...args:Array) : AsyncToken;
		/**
		 * @private
		 */
		function hasPendingInvocations () : Boolean;
		/**
		 * @private
		 */
		function invokeAllPending () : void;
		/**
		 * We now SOAP encode the pending call and send the request.     *      * @private
		 */
		function invokePendingCall (pc:OperationPendingCall) : void;
		/**
		 * We intercept faults as the SOAP response content may still been present     * in the message body.     *     * @private
		 */
		function processFault (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * We decode the SOAP encoded response and update the result and response     * headers (if any).     *      * @private
		 */
		function processResult (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * @private
		 */
		function processSOAP (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * Checks SOAP response headers and enforces any mustUnderstand attributes     * by checking that a listener exists for the "header" event. If we're     * honoring Axis sessions then we also look out for for the sessionID     * header and add it to the Operation's corresponding service for     * subsequent invocations. Finally, the header is dispatched as a     * HeaderEvent. If no problems are encountered the method simply returns     * true.     *      * @private
		 */
		protected function processHeaders (responseHeaders:Array, token:AsyncToken, message:IMessage) : Boolean;
		/**
		 * @private
		 */
		function setService (value:AbstractService) : void;
		/**
		 * @private
		 */
		protected function createFaultEvent (faultCode:String = null, faultString:String = null, faultDetail:String = null) : FaultEvent;
	}
	/**
	 * @private
	 */
	internal class OperationPendingCall
	{
		public var args : *;
		public var headers : Array;
		public var token : AsyncToken;

		public function OperationPendingCall (args:*, headers:Array, token:AsyncToken);
	}
}
