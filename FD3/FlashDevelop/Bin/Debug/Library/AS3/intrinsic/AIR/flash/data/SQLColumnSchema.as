package flash.data
{
	/// The SQLColumnSchema class provides information describing the characteristics of a specific column within a table in a database.
	public class SQLColumnSchema extends Object
	{
		/// [AIR] Indicates whether NULL values are allowed in this column.
		public function get allowNull () : Boolean;

		/// [AIR] Indicates whether this is an auto-increment column.
		public function get autoIncrement () : Boolean;

		/// [AIR] Gets the data type of the column as a string.
		public function get dataType () : String;

		/// [AIR] Indicates the default collation sequence that is defined for this column.
		public function get defaultCollationType () : String;

		/// [AIR] Gets the name of the column.
		public function get name () : String;

		/// [AIR] Indicates whether this column is the primary key column (or one of the primary key columns in a composite key) for its associated table.
		public function get primaryKey () : Boolean;
	}
}
