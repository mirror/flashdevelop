package mx.rpc.wsdl
{
	/**
	 * A port defines an individual endpoint by specifying a single address for * a binding. *  * @private
	 */
	public class WSDLPort
	{
		private var _binding : WSDLBinding;
		private var _endpointURI : String;
		private var _name : String;
		private var _service : WSDLService;

		/**
		 * Represents the binding which defines the message format and protocol     * used to interoperate with operations for this port.
		 */
		public function get binding () : WSDLBinding;
		public function set binding (value:WSDLBinding) : void;
		/**
		 * The endpointURI is the SOAP bound address defined for this port.
		 */
		public function get endpointURI () : String;
		public function set endpointURI (value:String) : void;
		/**
		 * The unique name of this port.
		 */
		public function get name () : String;
		/**
		 * The WSDL service to which this port belongs.
		 */
		public function get service () : WSDLService;

		public function WSDLPort (name:String, service:WSDLService);
		/**
		 * @private
		 */
		public function toString () : String;
	}
}
