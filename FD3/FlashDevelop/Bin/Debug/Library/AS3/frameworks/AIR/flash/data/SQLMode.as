/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLMode {
		/**
		 * Indicates that the connection is opened for updates, and a database
		 *  file is created if the specified file doesn't exist. In this
		 *  mode reading and writing are allowed to the database. If the database
		 *  does not exist one is created before the operation completes.
		 */
		public static const CREATE:String = "create";
		/**
		 * Indicates that the connection is opened in read-only mode. In this
		 *  mode writes are not allowed to the database. If the database does not
		 *  exist the open operation fails.
		 */
		public static const READ:String = "read";
		/**
		 * Indicates that the connection is opened for updates but a
		 *  new database file is not created if the specified file doesn't exist. In this
		 *  mode reading and writing are allowed to the database. If the database
		 *  does not exist the open operation fails.
		 */
		public static const UPDATE:String = "update";
	}
}
