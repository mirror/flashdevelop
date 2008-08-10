/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.events {
	import mx.rpc.AsyncToken;
	import mx.messaging.messages.IMessage;
	public class ResultEvent extends AbstractEvent {
		/**
		 * In certain circumstances, headers may also be returned with a fault to
		 *  provide further context to the failure.
		 */
		public function get headers():Object;
		public function set headers(value:Object):void;
		/**
		 * Result that the RPC call returns.
		 */
		public function get result():Object;
		/**
		 * Creates a new ResultEvent.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior associated with the event can be prevented.
		 * @param result            <Object (default = null)> Object that holds the actual result of the call.
		 * @param token             <AsyncToken (default = null)> Token that represents the call to the method. Used in the asynchronous completion token pattern.
		 * @param message           <IMessage (default = null)> Source Message of the result.
		 */
		public function ResultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, result:Object = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * Returns a string representation of the ResultEvent.
		 *
		 * @return                  <String> String representation of the ResultEvent.
		 */
		public override function toString():String;
		/**
		 * The RESULT event type.
		 */
		public static const RESULT:String = "result";
	}
}
