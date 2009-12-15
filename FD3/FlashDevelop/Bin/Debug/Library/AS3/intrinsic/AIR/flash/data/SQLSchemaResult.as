package flash.data
{
	/// A SQLSchemaResult instance contains the information resulting from a call to the SQLConnection.loadSchema() method.
	public class SQLSchemaResult extends Object
	{
		/// An array of SQLIndexSchema instances requested in a call to SQLConnection.loadSchema().
		public function get indices () : Array;

		/// An array of SQLTableSchema instances requested in a call to SQLConnection.loadSchema().
		public function get tables () : Array;

		/// An array of SQLTriggerSchema instances requested in a call to SQLConnection.loadSchema().
		public function get triggers () : Array;

		/// An array of SQLViewSchema instances requested in a call to SQLConnection.loadSchema().
		public function get views () : Array;

		/// Creates a SQLSchemaResult instance.
		public function SQLSchemaResult (tables:Array, views:Array, indices:Array, triggers:Array);
	}
}
