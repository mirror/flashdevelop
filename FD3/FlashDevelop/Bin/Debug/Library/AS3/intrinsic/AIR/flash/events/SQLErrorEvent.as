package flash.events
{
	import flash.errors.SQLError;
	import flash.events.Event;

	/// A SQLErrorEvent instance is dispatched by a SQLConnection instance or SQLStatement instance when an error occurs while performing a database operation in asynchronous execution mode.
	public class SQLErrorEvent extends ErrorEvent
	{
		/// [AIR] The SQLErrorEvent.ERROR constant defines the value of the type property of an error event dispatched when a call to a method of a SQLConnection or SQLStatement instance completes with an error.
		public static const ERROR : String = "error";

		/// [AIR] A SQLError object containing detailed information about the cause of the error.
		public function get error () : SQLError;

		/// [AIR] Creates a copy of the SQLErrorEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// [AIR] Returns a string that contains all the properties of the SQLErrorEvent object.
		public function toString () : String;
	}
}
