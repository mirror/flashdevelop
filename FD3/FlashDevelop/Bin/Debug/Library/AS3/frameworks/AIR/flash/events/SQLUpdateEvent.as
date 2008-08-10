/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class SQLUpdateEvent extends Event {
		/**
		 * The unique row identifier of the row that was inserted, deleted, or updated.
		 */
		public function get rowID():Number;
		/**
		 * The name of the table whose data change caused the event to be dispatched.
		 */
		public function get table():String;
		/**
		 * Creates a new SQLUpdateEvent instance.
		 *
		 * @param type              <String> The type of the event, available through the type property.
		 * @param bubbles           <Boolean (default = false)> Determines whether the event object participates in the bubbling
		 *                            stage of the event flow. The default value is false.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled.
		 *                            The default value is false.
		 * @param table             <String (default = null)> Indicates the name of the table whose data changed.
		 * @param rowID             <Number (default = 0)> The unique row identifier of the row that was inserted, deleted, or updated.
		 */
		public function SQLUpdateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, table:String = null, rowID:Number = 0);
		/**
		 * Creates a copy of the SQLUpdateEvent object and sets the value of each property to
		 *  match that of the original.
		 *
		 * @return                  <Event> A new SQLUpdateEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * The SQLUpdateEvent.DELETE constant defines the value of the
		 *  type property of a SQLConnection delete event.
		 *  The delete event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  rowIDThe unique row identifier of the row that was inserted, deleted, or updated.
		 *  targetThe SQLConnection object on which the operation was performed.
		 *  tableThe name of the table on which the change occurred.
		 */
		public static const DELETE:String = "delete";
		/**
		 * The SQLUpdateEvent.INSERT constant defines the value of the
		 *  type property of a SQLConnection insert event.
		 *  The insert event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  rowIDThe unique row identifier of the row that was inserted, deleted, or updated.
		 *  targetThe SQLConnection object on which the operation was performed.
		 *  tableThe name of the table on which the change occurred.
		 */
		public static const INSERT:String = "insert";
		/**
		 * The SQLUpdateEvent.UPDATE constant defines the value of the
		 *  type property of a SQLConnection update event.
		 */
		public static const UPDATE:String = "update";
	}
}
