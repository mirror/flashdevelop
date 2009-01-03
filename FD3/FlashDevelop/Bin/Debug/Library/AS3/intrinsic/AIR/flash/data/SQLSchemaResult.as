package flash.data
{
	/// A SQLSchemaResult instance contains the information resulting from a call to the SQLConnection.loadSchema() method.
	public class SQLSchemaResult extends Object
	{
		/// [AIR] An array of SQLIndexSchema instances requested in a call to SQLConnection.loadSchema().
		public function get indices () : Array;

		/// [AIR] An array of SQLTableSchema instances requested in a call to SQLConnection.loadSchema().
		public function get tables () : Array;

		/// [AIR] An array of SQLTriggerSchema instances requested in a call to SQLConnection.loadSchema().
		public function get triggers () : Array;

		/// [AIR] An array of SQLViewSchema instances requested in a call to SQLConnection.loadSchema().
		public function get views () : Array;
	}
}
