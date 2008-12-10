package mx.rpc.wsdl
{
	/**
	 * A portType lists a set of named operations and defines abstract interface or * "messages" used to interoperate with each operation. *  * @private
	 */
	public class WSDLPortType
	{
		private var _name : String;
		private var _operations : Object;

		/**
		 * The unique name for this portType.
		 */
		public function get name () : String;

		public function WSDLPortType (name:String);
		public function operations () : Object;
		public function addOperation (operation:WSDLOperation) : void;
		public function getOperation (name:String) : WSDLOperation;
	}
}
