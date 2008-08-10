/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLSchema {
		/**
		 * The name of the database to which this schema object belongs. The name is "main" for the main
		 *  database associated with a SQLConnection instance (the database file that is
		 *  opened by calling a SQLConnection instance's open() or openAsync() method). For other
		 *  databases that are attached to the connection using the
		 *  SQLConnection.attach() method, the value is the name specified in the attach()
		 *  method call.
		 */
		public function get database():String;
		/**
		 * The name of this schema object. Each object within a
		 *  database has a unique name. The name is defined in the SQL statement that creates the object
		 *  (such as the CREATE TABLE statement for a table).
		 */
		public function get name():String;
		/**
		 * Returns the entire text of the SQL statement that was used to create this schema object.
		 *  Each object within a database is created using a SQL statement.
		 */
		public function get sql():String;
		/**
		 * Creates a SQLSchema instance. Generally, developer code does not call the SQLSchema
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param database          <String> The name of the associated database.
		 * @param name              <String> The name of the database object.
		 * @param sql               <String> The SQL used to construct the database
		 *                            object.
		 */
		public function SQLSchema(database:String, name:String, sql:String);
	}
}
