package mx.rpc.mxml
{
	/**
	 *  Implementing this interface means that an RPC service *  can be used in an MXML document via tags *  since it supports the interfaces specified during Flex 1.
	 */
	public interface IMXMLSupport
	{
		/**
		 *  The concurrency setting of the RPC operation or HTTPService.	 *  One of "multiple" "last" or "single."
		 */
		public function get concurrency () : String;
		/**
		 *  @private
		 */
		public function set concurrency (value:String) : void;
		/**
		 *  Indicates whether the RPC operation or HTTPService	 *  should show the busy cursor while it is executing.
		 */
		public function get showBusyCursor () : Boolean;
		/**
		 *  @private
		 */
		public function set showBusyCursor (value:Boolean) : void;

	}
}
