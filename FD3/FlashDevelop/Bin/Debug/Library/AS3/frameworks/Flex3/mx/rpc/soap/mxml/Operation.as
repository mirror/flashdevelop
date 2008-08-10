/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap.mxml {
	import mx.rpc.soap.Operation;
	import mx.rpc.mxml.IMXMLSupport;
	public class Operation extends Operation implements IMXMLSupport {
		/**
		 * The concurrency for this Operation.  If it has not been explicitly set the setting from the WebService
		 *  will be used.
		 */
		public function get concurrency():String;
		public function set concurrency(value:String):void;
		/**
		 * Whether this operation should show the busy cursor while it is executing.
		 *  If it has not been explicitly set the setting from the WebService
		 *  will be used.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
		/**
		 * Use superclass description.
		 *
		 * @param id                <String (default = null)> 
		 */
		public override function cancel(id:String = null):AsyncToken;
		/**
		 * Execute the method.  Any arguments passed in will be passed along as part of the method call.  If there are
		 *  no arguments passed the arguments array will be used as the source of parameters.
		 *
		 * @return                  <AsyncToken> the call object that can be used as part of the asynchronous completion token pattern, the same
		 *                            object will be available in the result/fault events.
		 */
		public override function send(... args):AsyncToken;
	}
}
