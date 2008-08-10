/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	import flash.events.EventDispatcher;
	public class AbstractInvoker extends EventDispatcher {
		/**
		 * The result of the last invocation.
		 */
		public function get lastResult():Object;
		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable():Boolean;
		public function set makeObjectsBindable(value:Boolean):void;
		/**
		 * Cancels the last service invocation or an invokation with the specified id.
		 *  Even though the network operation may still continue, no result or fault event
		 *  is dispatched.
		 *
		 * @param id                <String (default = null)> The messageId of the invocation to cancel. Optional. If omitted, the
		 *                            last service invocation is canceled.
		 */
		public function cancel(id:String = null):AsyncToken;
		/**
		 * Sets the result property of the invoker to null.
		 *  This is useful when the result is a large object that is no longer being
		 *  used.
		 *
		 * @param fireBindingEvent  <Boolean (default = true)> fireBindingEvent Set to true if you want anything
		 *                            bound to the result to update. Otherwise, set to
		 *                            false.
		 *                            The default value is true
		 */
		public function clearResult(fireBindingEvent:Boolean = true):void;
	}
}
