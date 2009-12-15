package flash.data
{
	/// This class contains the constants that represent the possible values for the SQLConnection.columnNameStyle property.
	public class SQLColumnNameStyle extends Object
	{
		/// Indicates that column names returned from a SELECT statement use the default format.
		public static const DEFAULT : String;
		/// Indicates that column names returned from a SELECT statement use long-column-name format.
		public static const LONG : String;
		/// Indicates that column names returned from a SELECT statement use short-column-name format.
		public static const SHORT : String;

		public function SQLColumnNameStyle ();
	}
}
