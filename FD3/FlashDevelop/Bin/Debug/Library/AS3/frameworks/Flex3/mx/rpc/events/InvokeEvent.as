/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.events {
	import mx.rpc.AsyncToken;
	import mx.messaging.messages.IMessage;
	public class InvokeEvent extends AbstractEvent {
		/**
		 * Create a new InvokeEvent.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param token             <AsyncToken (default = null)> Token that represents the call to the method. Used in the asynchronous
		 *                            completion token pattern.
		 * @param message           <IMessage (default = null)> Source Message of the request.
		 */
		public function InvokeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, token:AsyncToken = null, message:IMessage = null);
		/**
		 * Returns a string representation of the InvokeEvent.
		 *
		 * @return                  <String> String representation of the InvokeEvent.
		 */
		public override function toString():String;
		/**
		 * The INVOKE event type.
		 */
		public static const INVOKE:String = "invoke";
	}
}
