/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLTriggerSchema extends SQLSchema {
		/**
		 * The name of the table on which this trigger is defined, or the name of the view if
		 *  the trigger is defined on a view.
		 */
		public function get table():String;
		/**
		 * Creates a SQLTriggerSchema instance.  Generally, developer code does not call the SQLTriggerSchema
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param database          <String> The name of the associated database.
		 * @param name              <String> The name of the trigger.
		 * @param sql               <String> The SQL used to create the trigger.
		 * @param table             <String> The name of the trigger's associated table.
		 */
		public function SQLTriggerSchema(database:String, name:String, sql:String, table:String);
	}
}
