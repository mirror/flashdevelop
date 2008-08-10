/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	public class Operation extends AbstractOperation {
		/**
		 * The location of the WebService for this Operation. Normally, the WSDL
		 *  specifies the location of the services, but you can set this property to
		 *  override that location for the individual Operation.
		 */
		public function get endpointURI():String;
		public function set endpointURI(value:String):void;
		/**
		 * Determines whether or not a single or empty return value for an output
		 *  message part that is defined as an array should be returned as an array
		 *  containing one (or zero, respectively) elements. This is applicable for
		 *  document/literal "wrapped" web services, where one or more of the elements
		 *  that represent individual message parts in the "wrapper" sequence could
		 *  have the maxOccurs attribute set with a value greater than 1. This is a
		 *  hint that the corresponding part should be treated as an array even if
		 *  the response contains zero or one values for that part. Setting
		 *  forcePartArrays to true will always create an array for parts defined in
		 *  this manner, regardless of the number of values returned. Leaving
		 *  forcePartArrays as false will only create arrays if two or more elements
		 *  are returned.
		 */
		public function get forcePartArrays():Boolean;
		public function set forcePartArrays(value:Boolean):void;
		/**
		 * Determines how the SOAP encoded headers are decoded. A value of
		 *  object specifies that each header XML node will be decoded
		 *  into a SOAPHeader object, and its content property will be
		 *  an object structure as specified in the WSDL document. A value of
		 *  xml specifies that the XML will be left as XMLNodes. A
		 *  value of e4x specifies that the XML will be accessible
		 *  using ECMAScript for XML (E4X) expressions.
		 */
		public function get headerFormat():String;
		public function set headerFormat(value:String):void;
		/**
		 * Accessor to an Array of SOAPHeaders that are to be sent on
		 *  each invocation of the operation.
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
		 * Determines whether whitespace is ignored when processing XML for a SOAP
		 *  encoded request or response. The default is true
		 *  and thus whitespace is not preserved. If an XML Schema type definition
		 *  specifies a whiteSpace restriction set to
		 *  preserve then ignoreWhitespace must first be set to false.
		 *  Conversely, if a type whiteSpace restriction is set to
		 *  replace or collapse then that setting will
		 *  be honored even if ignoreWhitespace is set to false.
		 */
		public function get ignoreWhitespace():Boolean;
		public function set ignoreWhitespace(value:Boolean):void;
		/**
		 * When this value is true, anonymous objects returned are forced to
		 *  bindable objects.
		 */
		public function get makeObjectsBindable():Boolean;
		public function set makeObjectsBindable(value:Boolean):void;
		/**
		 * Determines the type of the default result object for calls to web services
		 *  that define multiple parts in the output message. A value of "object"
		 *  specifies that the lastResult object will be an Object with named properties
		 *  corresponding to the individual output parts. A value of "array" would
		 *  make the lastResult an array, where part values are pushed in the order
		 *  they occur in the body of the SOAP message. The default value for document-
		 *  literal operations is "object". The default for rpc operations is "array".
		 *  The multiplePartsFormat property is applicable only when
		 *  resultFormat is "object" and ignored otherwise.
		 */
		public function get multiplePartsFormat():String;
		public function set multiplePartsFormat(value:String):void;
		/**
		 * The request of the Operation is an object structure or an XML structure.
		 *  If you specify XML, the XML is sent as is. If you pass an object, it is
		 *  encoded into a SOAP XML structure.
		 */
		public function get request():Object;
		public function set request(value:Object):void;
		/**
		 * Determines how the Operation result is decoded. A value of
		 *  object specifies that the XML will be decoded into an
		 *  object structure as specified in the WSDL document. A value of
		 *  xml specifies that the XML will be left as XMLNodes. A
		 *  value of e4x specifies that the XML will be accessible
		 *  using ECMAScript for XML (E4X) expressions.
		 */
		public function get resultFormat():String;
		public function set resultFormat(value:String):void;
		/**
		 * The headers that were returned as part of the last execution of this
		 *  operation. They match up with the lastResult property and
		 *  are the same as the collection of headers that are dispatched
		 *  individually as HeaderEvents.
		 */
		public function get resultHeaders():Array;
		/**
		 */
		public function get xmlSpecialCharsFilter():Function;
		public function set xmlSpecialCharsFilter(value:Function):void;
		/**
		 * Creates a new Operation. This is usually done directly by the MXML
		 *  compiler or automatically by the WebService when an unknown operation
		 *  has been accessed. It is not recommended that a developer use this
		 *  constructor directly.
		 *
		 * @param webService        <AbstractService (default = null)> 
		 * @param name              <String (default = null)> 
		 */
		public function Operation(webService:AbstractService = null, name:String = null);
		/**
		 * Adds a header that is applied only to this Operation. The header can be
		 *  provided in a pre-encoded form as an XML instance, or as a SOAPHeader
		 *  instance which leaves the encoding up to the internal SOAP encoder.
		 *
		 * @param header            <Object> The SOAP header to add to this Operation.
		 */
		public function addHeader(header:Object):void;
		/**
		 * Adds a header that is applied only to this Operation.
		 *
		 * @param qnameLocal        <String> the localname for the header QName
		 * @param qnameNamespace    <String> the namespace for header QName
		 * @param headerName        <String> Name of the header.
		 * @param headerValue       <String> Value of the header.
		 */
		public function addSimpleHeader(qnameLocal:String, qnameNamespace:String, headerName:String, headerValue:String):void;
		/**
		 * Cancels the last service invocation or an invokation with the specified id.
		 *  Even though the network operation may still continue, no result or fault event
		 *  is dispatched.
		 *
		 * @param id                <String (default = null)> The messageId of the invocation to cancel. Optional. If omitted, the
		 *                            last service invocation is canceled.
		 */
		public override function cancel(id:String = null):AsyncToken;
		/**
		 * Clears the headers for this individual Operation.
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
	}
}
