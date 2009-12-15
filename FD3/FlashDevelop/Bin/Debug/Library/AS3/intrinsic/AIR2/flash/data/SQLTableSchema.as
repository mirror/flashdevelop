package flash.data
{
	/// A SQLTableSchema instance provides information describing a specific table in a database.
	public class SQLTableSchema extends SQLSchema
	{
		/// An array of SQLColumnSchema instances containing schema information for this table's columns.
		public function get columns () : Array;

		/// Creates a SQLTableSchema instance.
		public function SQLTableSchema (database:String, name:String, sql:String, columns:Array);
	}
}
