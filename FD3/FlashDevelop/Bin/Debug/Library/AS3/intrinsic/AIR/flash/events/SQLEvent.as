package flash.events
{
	import flash.events.Event;

	/// Adobe AIR dispatches SQLEvent objects when one of the operations performed by a SQLConnection or SQLStatement instance completes successfully.
	public class SQLEvent extends Event
	{
		/// The SQLEvent.ANALYZE constant defines the value of the type property of an analyze event object.
		public static const ANALYZE : String = "analyze";
		/// The SQLEvent.ATTACH constant defines the value of the type property of an attach event object.
		public static const ATTACH : String = "attach";
		/// The SQLEvent.BEGIN constant defines the value of the type property of a begin event object.
		public static const BEGIN : String = "begin";
		/// The SQLEvent.CANCEL constant defines the value of the type property of a cancel event object.
		public static const CANCEL : String = "cancel";
		/// The SQLEvent.CLOSE constant defines the value of the type property of a close event object.
		public static const CLOSE : String = "close";
		/// The SQLEvent.COMMIT constant defines the value of the type property of a commit event object.
		public static const COMMIT : String = "commit";
		/// The SQLEvent.COMPACT constant defines the value of the type property of a compact event object.
		public static const COMPACT : String = "compact";
		/// The SQLEvent.DEANALYZE constant defines the value of the type property of a deanalyze event object.
		public static const DEANALYZE : String = "deanalyze";
		/// The SQLEvent.DETACH constant defines the value of the type property of a detach event object.
		public static const DETACH : String = "detach";
		/// The SQLEvent.OPEN constant defines the value of the type property of a open event object.
		public static const OPEN : String = "open";
		/// The SQLEvent.REENCRYPT constant defines the value of the type property of a reencrypt event object.
		public static const REENCRYPT : String = "reencrypt";
		/// The SQLEvent.RESULT constant defines the value of the type property of a result event object.
		public static const RESULT : String = "result";
		/// The SQLEvent.ROLLBACK constant defines the value of the type property of a rollback event object.
		public static const ROLLBACK : String = "rollback";
		/// The SQLEvent.SCHEMA constant defines the value of the type property of a schema event object.
		public static const SCHEMA : String = "schema";

		/// Creates a copy of the SQLEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Used to create new SQLEvent object.
		public function SQLEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);
	}
}
