package flash.data
{
	/// A SQLSchemaResult instance contains the information resulting from a call to the SQLConnection.loadSchema() method.
	public class SQLSchemaResult
	{
		/// [AIR] An array of SQLIndexSchema instances requested in a call to SQLConnection.loadSchema().
		public var indices:Array;

		/// [AIR] An array of SQLTableSchema instances requested in a call to SQLConnection.loadSchema().
		public var tables:Array;

		/// [AIR] An array of SQLTriggerSchema instances requested in a call to SQLConnection.loadSchema().
		public var triggers:Array;

		/// [AIR] An array of SQLViewSchema instances requested in a call to SQLConnection.loadSchema().
		public var views:Array;

		/// [AIR] Creates a SQLSchemaResult instance.
		public function SQLSchemaResult(tables:Array, views:Array, indices:Array, triggers:Array);

	}

}

