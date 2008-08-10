/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.events {
	import mx.rpc.Fault;
	import mx.rpc.AsyncToken;
	import mx.messaging.messages.IMessage;
	import mx.messaging.events.MessageFaultEvent;
	public class FaultEvent extends AbstractEvent {
		/**
		 * The Fault object that contains the details of what caused this event.
		 */
		public function get fault():Fault;
		/**
		 * In certain circumstances, headers may also be returned with a fault to
		 *  provide further context to the failure.
		 */
		public function get headers():Object;
		public function set headers(value:Object):void;
		/**
		 * Creates a new FaultEvent. The fault is a required parameter while the call and message are optional.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior associated with the event can be prevented.
		 * @param fault             <Fault (default = null)> Object that holds details of the fault, including a faultCode and faultString.
		 * @param token             <AsyncToken (default = null)> Token representing the call to the method. Used in the asynchronous completion token pattern.
		 * @param message           <IMessage (default = null)> Source Message of the fault.
		 */
		public function FaultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, fault:Fault = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * Given a Fault, this method constructs and
		 *  returns a FaultEvent.
		 *
		 * @param fault             <Fault> Fault that contains the details of the FaultEvent.
		 * @param token             <AsyncToken (default = null)> AsyncToken [optional] associated with this fault.
		 * @param msg               <IMessage (default = null)> Message [optional] associated with this fault.
		 */
		public static function createEvent(fault:Fault, token:AsyncToken = null, msg:IMessage = null):FaultEvent;
		/**
		 * Given a MessageFaultEvent, this method constructs and
		 *  returns a FaultEvent.
		 *
		 * @param value             <MessageFaultEvent> MessageFaultEvent reference to extract the appropriate
		 *                            fault information from.
		 * @param token             <AsyncToken (default = null)> AsyncToken [optional] associated with this fault.
		 */
		public static function createEventFromMessageFault(value:MessageFaultEvent, token:AsyncToken = null):FaultEvent;
		/**
		 * Returns a string representation of the FaultEvent.
		 *
		 * @return                  <String> String representation of the FaultEvent.
		 */
		public override function toString():String;
		/**
		 * The FAULT event type.
		 */
		public static const FAULT:String = "fault";
	}
}
