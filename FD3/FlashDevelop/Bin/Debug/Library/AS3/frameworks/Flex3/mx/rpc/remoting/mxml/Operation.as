/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.remoting.mxml {
	import mx.rpc.remoting.Operation;
	import mx.rpc.mxml.IMXMLSupport;
	public class Operation extends Operation implements IMXMLSupport {
		/**
		 * The concurrency for this Operation.  If it has not been explicitly set the setting from the RemoteObject
		 *  will be used.
		 */
		public function get concurrency():String;
		public function set concurrency(value:String):void;
		/**
		 * Whether this operation should show the busy cursor while it is executing.
		 *  If it has not been explicitly set the setting from the RemoteObject
		 *  will be used.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
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
		 * Executes the method. Any arguments passed in are passed along as part of
		 *  the method call. If there are no arguments passed, the arguments object
		 *  is used as the source of parameters.
		 *
		 * @return                  <AsyncToken> AsyncToken Call using the asynchronous completion token pattern.
		 *                            The same object is available in the result and
		 *                            fault events from the token property.
		 */
		public override function send(... args):AsyncToken;
	}
}
