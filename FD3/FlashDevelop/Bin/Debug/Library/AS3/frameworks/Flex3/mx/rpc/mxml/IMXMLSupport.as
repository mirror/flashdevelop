/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.mxml {
	public interface IMXMLSupport {
		/**
		 * The concurrency setting of the RPC operation or HTTPService.
		 *  One of "multiple" "last" or "single."
		 */
		public function get concurrency():String;
		public function set concurrency(value:String):void;
		/**
		 * Indicates whether the RPC operation or HTTPService
		 *  should show the busy cursor while it is executing.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
	}
}
