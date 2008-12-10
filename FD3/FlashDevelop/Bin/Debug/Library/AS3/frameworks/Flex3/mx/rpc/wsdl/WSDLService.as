package mx.rpc.wsdl
{
	/**
	 * A service groups a set of related ports together for a given WSDL. *  * @private
	 */
	public class WSDLService
	{
		private var _defaultPort : WSDLPort;
		private var _name : String;
		private var _ports : Object;

		public function get defaultPort () : WSDLPort;
		/**
		 * The unique name of this service.
		 */
		public function get name () : String;
		/**
		 * Provides access to this service's map of ports.
		 */
		public function get ports () : Object;

		public function WSDLService (name:String);
		/**
		 * Registers a port with this service.
		 */
		public function addPort (port:WSDLPort) : void;
		/**
		 * Retrieves a port by name.
		 */
		public function getPort (name:String) : WSDLPort;
	}
}
