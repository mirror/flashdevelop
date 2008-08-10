/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.events {
	import mx.messaging.events.MessageEvent;
	import mx.rpc.AsyncToken;
	public class AbstractEvent extends MessageEvent {
		/**
		 * The token that represents the call to the method. Used in the asynchronous completion token pattern.
		 */
		public function get token():AsyncToken;
	}
}
