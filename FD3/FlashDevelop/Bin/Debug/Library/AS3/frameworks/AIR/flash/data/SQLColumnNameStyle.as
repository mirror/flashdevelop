/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLColumnNameStyle {
		/**
		 * Indicates that column names returned from a SELECT statement
		 *  use the default format. In the default format, column names have the form
		 *  [table-name]_[column-name] when multiple tables are
		 *  included in the SELECT statement, or [column-name] when
		 *  the SELECT statement includes a single table.
		 */
		public static const DEFAULT:String = "default";
		/**
		 * Indicates that column names returned from a SELECT statement use
		 *  long-column-name format. In this format, column names use the form
		 *  [table-name]_[column-name] regardless of how many
		 *  tables are included in the SELECT statement.
		 */
		public static const LONG:String = "long";
		/**
		 * Indicates that column names returned from a SELECT statement use short-column-name
		 *  format. In this format, column names use the form [column-name],
		 *  regardless of how many tables are included in the SELECT statement.
		 */
		public static const SHORT:String = "short";
	}
}
