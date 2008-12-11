package flash.data
{
	/// A SQLTableSchema instance provides information describing a specific table in a database.
	public class SQLTableSchema extends flash.data.SQLSchema
	{
		/// [AIR] An array of SQLColumnSchema instances containing schema information for this table's columns.
		public var columns:Array;

		/// [AIR] Creates a SQLTableSchema instance.
		public function SQLTableSchema(database:String, name:String, sql:String, columns:Array);

	}

}

