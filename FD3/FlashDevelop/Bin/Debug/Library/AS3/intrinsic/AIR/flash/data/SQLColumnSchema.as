package flash.data
{
	/// The SQLColumnSchema class provides information describing the characteristics of a specific column within a table in a database.
	public class SQLColumnSchema
	{
		/// [AIR] Indicates whether NULL values are allowed in this column.
		public var allowNull:Boolean;

		/// [AIR] Indicates whether this is an auto-increment column.
		public var autoIncrement:Boolean;

		/// [AIR] Indicates the default collation sequence that is defined for this column.
		public var defaultCollationType:String;

		/// [AIR] Gets the data type of the column as a string.
		public var dataType:String;

		/// [AIR] Gets the name of the column.
		public var name:String;

		/// [AIR] Indicates whether this column is the primary key column (or one of the primary key columns in a composite key) for its associated table.
		public var primaryKey:Boolean;

		/// [AIR] Constructs a SQLColumnSchema instance.
		public function SQLColumnSchema(name:String, primaryKey:Boolean, allowNull:Boolean, autoIncrement:Boolean, dataType:String, defaultCollationType:String);

	}

}

