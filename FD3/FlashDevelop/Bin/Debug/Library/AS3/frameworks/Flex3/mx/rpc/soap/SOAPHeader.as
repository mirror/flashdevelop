/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	public class SOAPHeader {
		/**
		 * The content to send for the header value.
		 *  If you provide an XML or flash.xml.XMLNode instance for the header, it is
		 *  used directly as pre-encoded content and appended as a child to the soap:header element.
		 *  Otherwise, you can provide the value as a String or Number, etc. and the underlying SOAP encoder
		 *  attempts to encode the value correctly based on the QName provided in the SOAPHeader
		 *  (with the last resort being xsd:anyType if a type definition is not present).
		 */
		public var content:Object;
		/**
		 * Specifies whether the header must be understood by the endpoint. If
		 *  the header is handled but must be understood the endpoint should
		 *  return a SOAP fault.
		 */
		public var mustUnderstand:Boolean;
		/**
		 * The qualified name of the SOAP header.
		 */
		public var qname:QName;
		/**
		 * Specifies the URI for the role that this header is intended in a
		 *  potential chain of endpoints processing a SOAP request. If defined,
		 *  this value is used to specify the actor for the SOAP
		 *  header.
		 */
		public var role:String;
		/**
		 * Constructs a new SOAPHeader. The qualified name and content for the
		 *  SOAP header are required.
		 *
		 * @param qname             <QName> 
		 * @param content           <Object> 
		 */
		public function SOAPHeader(qname:QName, content:Object);
	}
}
