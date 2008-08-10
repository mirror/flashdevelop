/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLColumnSchema {
		/**
		 * Indicates whether NULL values are allowed in this column. A column
		 *  that is declared with a NOT NULL constraint has a false
		 *  value for the allowNull property.
		 */
		public function get allowNull():Boolean;
		/**
		 * Indicates whether this is an auto-increment column. An auto-increment column is a special type
		 *  of PRIMARY KEY column whose value is automatically generated as the next value
		 *  in a sequence of integers when a new row is inserted into the table.
		 */
		public function get autoIncrement():Boolean;
		/**
		 * Gets the data type of the column as a string. The value is the literal data type name that was
		 *  specified in the CREATE TABLE statement that was used to define the table, or
		 *  null if no data type was specified.
		 */
		public function get dataType():String;
		/**
		 * Indicates the default collation sequence that is defined for this column.
		 *  The value of this property corresponds to one of the constants in the SQLCollationType class:
		 *  SQLCollationType.BINARY indicates that the column uses the
		 *  BINARY collation sequence.
		 *  SQLCollationType.NO_CASE indicates that the column uses the NOCASE
		 *  collation sequence, meaning that text comparisons are made in a case-insensitive manner.
		 */
		public function get defaultCollationType():String;
		/**
		 * Gets the name of the column.
		 */
		public function get name():String;
		/**
		 * Indicates whether this column is the primary key column (or one of the primary key columns
		 *  in a composite key) for its associated table.
		 */
		public function get primaryKey():Boolean;
		/**
		 * Constructs a SQLColumnSchema instance. Generally, developer code does not call the SQLColumnSchema
		 *  constructor directly. To obtain schema information for a database, call the
		 *  SQLConnection.loadSchema() method.
		 *
		 * @param name              <String> The name of the column.
		 * @param primaryKey        <Boolean> Indicates whether this column is a part of the primary
		 *                            key for the associated table.
		 * @param allowNull         <Boolean> Indicates whether this column can contain NULL values.
		 * @param autoIncrement     <Boolean> Indicates whether this is an auto increment column.
		 * @param dataType          <String> The declared type of the column.
		 * @param defaultCollationType<String> The collation sequence defined for this column.
		 *                            This value corresponds to one of the constants in the SQLCollationType class:
		 *                            SQLCollationType.BINARY indicates that the column uses the
		 *                            BINARY collation sequence.
		 *                            SQLCollationType.NO_CASE indicates that the column uses the NOCASE
		 *                            collation sequence, meaning text comparisons are made in a case-insensitive manner.
		 */
		public function SQLColumnSchema(name:String, primaryKey:Boolean, allowNull:Boolean, autoIncrement:Boolean, dataType:String, defaultCollationType:String);
	}
}
