/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLViewSchema extends SQLTableSchema {
		/**
		 * Creates a SQLViewSchema instance. Generally, developer code does not call the SQLViewSchema
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param database          <String> The name of the associated database.
		 * @param name              <String> The name of the view.
		 * @param sql               <String> The SQL statement used to create the view.
		 * @param columns           <Array> Array of SQLColumnSchema instances describing this view's columns.
		 */
		public function SQLViewSchema(database:String, name:String, sql:String, columns:Array);
	}
}
