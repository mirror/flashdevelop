/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.events {
	import mx.rpc.AsyncToken;
	import mx.messaging.messages.IMessage;
	public class HeaderEvent extends AbstractEvent {
		/**
		 * Header that the RPC call returned in the response.
		 */
		public function get header():Object;
		/**
		 * Creates a new HeaderEvent.
		 *
		 * @param type              <String> Object that holds the header of the call.
		 * @param bubbles           <Boolean (default = false)> AsyncToken that represents the call to the method. Used in the asynchronous completion token pattern.
		 * @param cancelable        <Boolean (default = true)> Source Message of the header.
		 * @param header            <Object (default = null)> 
		 * @param token             <AsyncToken (default = null)> 
		 * @param message           <IMessage (default = null)> 
		 */
		public function HeaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, header:Object = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * @param header            <Object> 
		 * @param token             <AsyncToken> 
		 * @param message           <IMessage> 
		 */
		public static function createEvent(header:Object, token:AsyncToken, message:IMessage):HeaderEvent;
		/**
		 * Returns a string representation of the HeaderEvent.
		 *
		 * @return                  <String> String representation of the HeaderEvent.
		 */
		public override function toString():String;
		/**
		 * The HEADER event type.
		 */
		public static const HEADER:String = "header";
	}
}
