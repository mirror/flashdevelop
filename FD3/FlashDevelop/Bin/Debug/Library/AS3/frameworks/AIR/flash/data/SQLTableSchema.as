/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLTableSchema extends SQLSchema {
		/**
		 * An array of SQLColumnSchema instances containing schema information for this table's columns.
		 *  If the SQlConnection.loadSchema() call indicates that column information
		 *  is excluded from the result, the columns property is an empty array
		 *  (an array whose length property is 0).
		 */
		public function get columns():Array;
		/**
		 * Creates a SQLTableSchema instance. Generally, developer code does not call the SQLTableSchema
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param database          <String> The name of the associated database.
		 * @param name              <String> The name of the table.
		 * @param sql               <String> The SQL statement used to create the table.
		 * @param columns           <Array> Array of SQLColumnSchema instances describing this table's columns.
		 */
		public function SQLTableSchema(database:String, name:String, sql:String, columns:Array);
	}
}
