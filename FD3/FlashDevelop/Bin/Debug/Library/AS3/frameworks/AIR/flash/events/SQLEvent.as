/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class SQLEvent extends Event {
		/**
		 * Creates a SQLEvent object to pass as a parameter to event listeners.
		 *
		 * @param type              <String> The type of the event, available in the type property.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling
		 *                            stage of the event flow. The default value is false.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled.
		 *                            The default value is false.
		 */
		public function SQLEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 * Creates a copy of the SQLEvent object and sets the value of each property to match
		 *  that of the original.
		 *
		 * @return                  <Event> A new SQLEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * The SQLEvent.ANALYZE constant defines the value of the
		 *  type property of an analyze event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.analyze() method call completes successfully.
		 *  The analyze event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const ANALYZE:String = "analyze";
		/**
		 * The SQLEvent.ATTACH constant defines the value of the
		 *  type property of an attach event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.attach() method call completes successfully.
		 *  The attach event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const ATTACH:String = "attach";
		/**
		 * The SQLEvent.BEGIN constant defines the value of the
		 *  type property of a begin event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.begin() method call completes successfully.
		 *  The begin event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const BEGIN:String = "begin";
		/**
		 * The SQLEvent.CANCEL constant defines the value of the
		 *  type property of a cancel event object.
		 *  This type of event is dispatched when a SQLConnection.cancel()
		 *  method call completes successfully.
		 *  The cancel event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection or SQLStatement object that performed the operation.
		 */
		public static const CANCEL:String = "cancel";
		/**
		 * The SQLEvent.CLOSE constant defines the value of the
		 *  type property of a close event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.close() method call completes successfully.
		 *  The close event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const CLOSE:String = "close";
		/**
		 * The SQLEvent.COMMIT constant defines the value of the
		 *  type property of a commit event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.commit() method call completes successfully.
		 *  The commit event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const COMMIT:String = "commit";
		/**
		 * The SQLEvent.COMPACT constant defines the value of the
		 *  type property of a compact event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.compact() method call completes successfully.
		 *  The compact event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const COMPACT:String = "compact";
		/**
		 * The SQLEvent.DEANALYZE constant defines the value of the
		 *  type property of a deanalyze event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.deanalyze() method call completes successfully.
		 *  The deanalyze event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const DEANALYZE:String = "deanalyze";
		/**
		 * The SQLEvent.DETACH constant defines the value of the
		 *  type property of a detach event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.detach() method call completes successfully.
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const DETACH:String = "detach";
		/**
		 * The SQLEvent.OPEN constant defines the value of the
		 *  type property of a open event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.open() or SQLConnection.openAsync() method call completes successfully.
		 *  The open event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const OPEN:String = "open";
		/**
		 * The SQLEvent.RESULT constant defines the value of the
		 *  type property of a result event object.
		 *  Dispatched when either the SQLStatement.execute() method or
		 *  SQLStatement.next() method completes successfully. Once the
		 *  SQLEvent.RESULT event is dispatched the SQLStatement.getResult()
		 *  method can be called to access the result data.
		 *  The result event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLStatement object that performed the operation.
		 */
		public static const RESULT:String = "result";
		/**
		 * The SQLEvent.ROLLBACK constant defines the value of the
		 *  type property of a rollback event object.
		 *  This type of event is dispatched when a
		 *  SQLConnection.rollback() method call completes successfully.
		 *  The rollback event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const ROLLBACK:String = "rollback";
		/**
		 * The SQLEvent.SCHEMA constant defines the value of the
		 *  type property of a schema event object.
		 *  Dispatched when the SQLConnection.loadSchema() method
		 *  completes successfully. Once the SQLEvent.SCHEMA event
		 *  is dispatched the SQLConnection.getSchemaResult() method can be
		 *  used to get the schema information.
		 *  The schema event has the following properties:
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  currentTargetThe object that is actively processing the event
		 *  object with an event listener.
		 *  targetThe SQLConnection object that performed the operation.
		 */
		public static const SCHEMA:String = "schema";
	}
}
