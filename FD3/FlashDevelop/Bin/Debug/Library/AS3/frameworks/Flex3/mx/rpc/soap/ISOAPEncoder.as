/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	import mx.rpc.xml.IXMLEncoder;
	public interface ISOAPEncoder extends IXMLEncoder {
		/**
		 * Determines whether the encoder should ignore whitespace when
		 *  constructing an XML representation of a SOAP request.
		 *  The default should be true and thus whitespace not preserved.
		 *  If an XML Schema type definition specifies a whiteSpace
		 *  restriction set to preserve then ignoreWhitespace must
		 *  first be set to false. Conversely, if a type whiteSpace
		 *  restriction is set to replace or collapse then
		 *  that setting will be honored even if ignoreWhitespace is set to false.
		 */
		public function get ignoreWhitespace():Boolean;
		public function set ignoreWhitespace(value:Boolean):void;
		/**
		 * A WSDLOperation defines the SOAP binding styles and specifies how to
		 *  encode a SOAP request.
		 */
		public function get wsdlOperation():WSDLOperation;
		public function set wsdlOperation(value:WSDLOperation):void;
		/**
		 * Creates a SOAP-encoded request to an operation from the given input
		 *  parameters and headers.
		 *
		 * @param args              <* (default = null)> 
		 * @param headers           <Array (default = null)> 
		 */
		public function encodeRequest(args:* = null, headers:Array = null):XML;
	}
}
