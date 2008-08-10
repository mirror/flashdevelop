/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLSchemaResult {
		/**
		 * An array of SQLIndexSchema instances requested in a call
		 *  to SQLConnection.loadSchema(). If the specified databases
		 *  do not contain any indices, or if the loadSchema() call
		 *  specifies to exclude indices from the result, the indices
		 *  property is an empty array (an array whose length property
		 *  is 0).
		 */
		public function get indices():Array;
		/**
		 * An array of SQLTableSchema instances requested in a call
		 *  to SQLConnection.loadSchema(). If the specified databases
		 *  do not contain any tables, or if the loadSchema() call
		 *  specifies to exclude tables from the result, the tables
		 *  property is an empty array (an array whose length property
		 *  is 0).
		 */
		public function get tables():Array;
		/**
		 * An array of SQLTriggerSchema instances requested in a call
		 *  to SQLConnection.loadSchema(). If the specified databases
		 *  do not contain any triggers, or if the loadSchema() call
		 *  specifies to exclude triggers from the result, the triggers
		 *  property is an empty array (an array whose length property
		 *  is 0).
		 */
		public function get triggers():Array;
		/**
		 * An array of SQLViewSchema instances requested in a call
		 *  to SQLConnection.loadSchema(). If the specified databases
		 *  do not contain any views, or if the loadSchema() call
		 *  indicates that views should be excluded from the result, the views
		 *  property is an empty array (an array whose length property
		 *  is 0).
		 */
		public function get views():Array;
		/**
		 * Creates a SQLSchemaResult instance. Generally, developer code does not call the SQLSchemaResult
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param tables            <Array> An array of SQLTableSchema instances as specified in the loadSchema() request.
		 * @param views             <Array> An array of SQLViewSchema instances as specified in the loadSchema() request.
		 * @param indices           <Array> An array of SQLIndexSchema instances as specified in the loadSchema() request.
		 * @param triggers          <Array> An array of SQLTriggerSchema instances as specified in the loadSchema() request.
		 */
		public function SQLSchemaResult(tables:Array, views:Array, indices:Array, triggers:Array);
	}
}
