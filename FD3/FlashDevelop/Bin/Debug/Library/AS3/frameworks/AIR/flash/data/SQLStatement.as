/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	public class SQLStatement extends EventDispatcher {
		/**
		 * Indicates whether the statement is currently executing.
		 */
		public function get executing():Boolean;
		/**
		 * Indicates a class (data type) that is used for each
		 *  row returned as a result of the statement's execution.
		 */
		public function get itemClass():Class;
		public function set itemClass(value:Class):void;
		/**
		 * Serves as an associative array to which you add values for the
		 *  parameters specified in the SQL statement's
		 *  text property. The array keys are
		 *  the names of the parameters. If an unnamed parameter is specified
		 *  in the statement text, its key is the index of the parameter.
		 */
		public function get parameters():Object;
		/**
		 * The SQLConnection object that manages the connection to the database or databases on which
		 *  the statement is executed.
		 */
		public function get sqlConnection():SQLConnection;
		public function set sqlConnection(value:SQLConnection):void;
		/**
		 * The actual SQL text of the statement.
		 */
		public function get text():String;
		public function set text(value:String):void;
		/**
		 * Creates a SQLStatement instance.
		 */
		public function SQLStatement();
		/**
		 * Cancels execution of this statement.  Like SQLConnection.cancel()
		 *  this method is used to stop a long running query or to cancel a query that is not
		 *  yet complete. However, unlike SQLConnection.cancel() this method only cancels the
		 *  single statement. If the statement is not currently executing, calling this method does
		 *  nothing.
		 */
		public function cancel():void;
		/**
		 * Clears all current parameter settings.
		 */
		public function clearParameters():void;
		/**
		 * Executes the SQL in the text property against the database that
		 *  is connected to the SQLConnection object in the sqlConnection
		 *  property.
		 *
		 * @param prefetch          <int (default = -1)> When the statement's text property is a
		 *                            SELECT statement, this value indicates how many rows are
		 *                            returned at one time by the statement.
		 *                            The default value is -1, indicating that all the result rows are returned
		 *                            at one time. This parameter is used in conjunction with the next()
		 *                            method to divide large result sets into smaller sets of data. This can improve
		 *                            users' perceptions of application performance by returning initial results more
		 *                            quickly and dividing result-processing operations.
		 *                            When the SQL statement is a SELECT query and a prefetch
		 *                            argument greater than zero is specified, the statement is considered to be executing
		 *                            until the entire result set is returned or either the SQLStatement.cancel()
		 *                            or SQLConnection.cancel() method is called. Note that because the number of
		 *                            rows in a result set is unknown at execution time, the database cursor must move beyond
		 *                            the last row in the result set before the statement is considered complete. When a
		 *                            prefetch argument is specified in an execute() call, at least
		 *                            one row more than the total number of rows in the result set must be requested
		 *                            (either through a prefetch value that's larger than the number of rows in the
		 *                            result set, or through subsequent calls to the next() method) before
		 *                            the resulting SQLResult instance's complete property is true.
		 * @param responder         <Responder (default = null)> An object that designates methods to be called when
		 *                            the operation succeeds or fails. In asynchronous execution mode, if the
		 *                            responder argument is null
		 *                            a result or error event is dispatched when execution completes.
		 */
		public function execute(prefetch:int = -1, responder:Responder = null):void;
		/**
		 * Provides access to a SQLResult object containing the results of the statement
		 *  execution, including any result rows from a SELECT statement, and other
		 *  information about the statement execution for all executed statements.
		 *  In asynchronous execution mode, the result information is not available until the
		 *  result event is dispatched.
		 *
		 * @return                  <SQLResult> A SQLResult object containing the result of a call to the execute()
		 *                            or next() method.
		 */
		public function getResult():SQLResult;
		/**
		 * Retrieves the next portion of a SELECT statement's result set.
		 *  If there are no more rows in the result set, a result event is dispatched but
		 *  no additional SQLResult object is added to the getResult() queue.
		 *
		 * @param prefetch          <int (default = -1)> When the statement's text property is a SELECT
		 *                            statement, this value indicates how many rows are returned at one time by
		 *                            the statement.
		 *                            The default value is -1, indicating that all the result rows are returned
		 *                            at one time.  This can improve
		 *                            users' perceptions of application performance by returning initial results more
		 *                            quickly and dividing result-processing operations.
		 * @param responder         <Responder (default = null)> An object that designates methods to be called when
		 *                            the operation succeeds or fails. If the responder argument is null
		 *                            a result or error event is dispatched when execution completes.
		 */
		public function next(prefetch:int = -1, responder:Responder = null):void;
	}
}
