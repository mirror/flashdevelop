package flash.data
{
	/// The SQLSchema class is the base class for schema information for database objects such as tables, views, and indices.
	public class SQLSchema
	{
		/// [AIR] The name of the database to which this schema object belongs.
		public var database:String;

		/// [AIR] The name of this schema object.
		public var name:String;

		/// [AIR] Returns the entire text of the SQL statement that was used to create this schema object.
		public var sql:String;

		/// [AIR] Creates a SQLSchema instance.
		public function SQLSchema(database:String, name:String, sql:String);

	}

}

