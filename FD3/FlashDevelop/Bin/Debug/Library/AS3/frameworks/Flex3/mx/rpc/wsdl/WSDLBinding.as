/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.wsdl {
	public class WSDLBinding {
		/**
		 * The unique name of this binding.
		 */
		public function get name():String;
		/**
		 * The portType for this binding which provides the interface definitions
		 *  for the operations of this binding.
		 */
		public function get portType():WSDLPortType;
		public function set portType(value:WSDLPortType):void;
		/**
		 * Represents a SOAP binding style attribute which is the default for any
		 *  operation defined under this binding. The style indicates whether an
		 *  operation is RPC-oriented (messages containing parameters and return
		 *  values) or document-oriented (message containing document(s)).
		 */
		public function get style():String;
		public function set style(value:String):void;
		/**
		 * Represents a SOAP binding transport attribute which indicates the
		 *  URI of the transport used to send SOAP encoded messages.
		 *  The default URI is http://schemas.xmlsoap.org/soap/http/ which signifies
		 *  SOAP over HTTP (and is currently the only transport supported).
		 */
		public function get transport():String;
		public function set transport(value:String):void;
	}
}
