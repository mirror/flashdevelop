package flash.data
{
	/// A SQLTriggerSchema instance provides information describing a specific trigger in a database.
	public class SQLTriggerSchema extends flash.data.SQLSchema
	{
		/// [AIR] The name of the table on which this trigger is defined, or the name of the view if the trigger is defined on a view.
		public var table:String;

		/// [AIR] Creates a SQLTriggerSchema instance.
		public function SQLTriggerSchema(database:String, name:String, sql:String, table:String);

	}

}

