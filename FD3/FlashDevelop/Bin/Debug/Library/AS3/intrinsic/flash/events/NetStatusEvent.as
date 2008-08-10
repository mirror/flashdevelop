/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class NetStatusEvent extends Event {
		/**
		 * An object with properties that describe the object's status or error condition.
		 */
		public function get info():Object;
		public function set info(value:Object):void;
		/**
		 * Creates an Event object that contains information about netStatus events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of status event: NetStatusEvent.NET_STATUS.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param info              <Object (default = null)> An object containing properties that describe the object's status. Event listeners can access this object through the info property.
		 */
		public function NetStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null);
		/**
		 * Creates a copy of the NetStatusEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new NetStatusEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the NetStatusEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the NetStatusEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a netStatus event object.
		 */
		public static const NET_STATUS:String = "netStatus";
	}
}
