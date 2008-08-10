/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLIndexSchema extends SQLSchema {
		/**
		 * The name of the table to which this index is attached.
		 */
		public function get table():String;
		/**
		 * Creates a SQLIndexSchema instance. Generally, developer code does not call the SQLIndexSchema
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param database          <String> The name of the associated database.
		 * @param name              <String> The name of the index.
		 * @param sql               <String> The SQL statement used to create this index.
		 * @param table             <String> The name of the table to which this index is attached.
		 */
		public function SQLIndexSchema(database:String, name:String, sql:String, table:String);
	}
}
