/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class SyncEvent extends Event {
		/**
		 * An array of objects; each object contains properties that describe the changed members of a remote shared object.
		 *  The properties of each object are code, name, and oldValue.
		 */
		public function get changeList():Array;
		public function set changeList(value:Array):void;
		/**
		 * Creates an Event object that contains information about sync events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of sync event: SyncEvent.SYNC.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param changeList        <Array (default = null)> An array of objects that describe the synchronization with the remote SharedObject. Event listeners can access this object through the changeList property.
		 */
		public function SyncEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, changeList:Array = null);
		/**
		 * Creates a copy of the SyncEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new SyncEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the SyncEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the SyncEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a sync event object.
		 */
		public static const SYNC:String = "sync";
	}
}
