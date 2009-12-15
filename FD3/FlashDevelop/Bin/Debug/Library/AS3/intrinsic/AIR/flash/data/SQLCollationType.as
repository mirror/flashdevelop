package flash.data
{
	/// This class contains the constants that represent the possible values for the defaultCollationType parameter of the SQLColumnSchema constructor, as well as the SQLColumnSchema.defaultCollationType property.
	public class SQLCollationType extends Object
	{
		/// Indicates that the column is defined to use the BINARY collation sequence.
		public static const BINARY : String;
		/// Indicates that the column is defined to use the NOCASE collation sequence.
		public static const NO_CASE : String;

		public function SQLCollationType ();
	}
}
