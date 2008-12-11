package flash.data
{
	/// A SQLStatement instance is used to execute a SQL statement against a local SQL database that is open through a SQLConnection instance.
	public class SQLStatement extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Dispatched when an error occurs during an operation.
		 * @eventType flash.events.SQLErrorEvent.ERROR
		 */
		[Event(name="error", type="flash.events.SQLErrorEvent")]

		/** 
		 * [AIR] Dispatched when an execute() or next() method call's operation completes successfully.
		 * @eventType flash.events.SQLEvent.RESULT
		 */
		[Event(name="result", type="flash.events.SQLEvent")]

		/// [AIR] Indicates whether the statement is currently executing.
		public var executing:Boolean;

		/// [AIR] The SQLConnection object that manages the connection to the database or databases on which the statement is executed.
		public var sqlConnection:flash.data.SQLConnection;

		/// [AIR] Indicates a class (data type) that is used for each row returned as a result of the statement's execution.
		public var itemClass:Class;

		/// [AIR] Serves as an associative array to which you add values for the parameters specified in the SQL statement's text property.
		public var parameters:Object;

		/// [AIR] The actual SQL text of the statement.
		public var text:String;

		/// [AIR] Creates a SQLStatement instance.
		public function SQLStatement();

		/// [AIR] Cancels execution of this statement.
		public function cancel():void;

		/// [AIR] Clears all current parameter settings.
		public function clearParameters():void;

		/// [AIR] Executes the SQL in the text property against the database that is connected to the SQLConnection object in the sqlConnection property.
		public function execute(prefetch:int=-1, responder:flash.net.Responder=null):void;

		/// [AIR] Provides access to a SQLResult object containing the results of the statement execution, including any result rows from a SELECT statement, and other information about the statement execution for all executed statements.
		public function getResult():flash.data.SQLResult;

		/// [AIR] Retrieves the next portion of a SELECT statement's result set.
		public function next(prefetch:int=-1, responder:flash.net.Responder=null):void;

	}

}

