package flash.data
{
	/// The SQLSchema class is the base class for schema information for database objects such as tables, views, and indices.
	public class SQLSchema extends Object
	{
		/// [AIR] The name of the database to which this schema object belongs.
		public function get database () : String;

		/// [AIR] The name of this schema object.
		public function get name () : String;

		/// [AIR] Returns the entire text of the SQL statement that was used to create this schema object.
		public function get sql () : String;
	}
}
