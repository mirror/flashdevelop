package flash.errors
{
	/// This class contains the constants that represent the possible values for the SQLError.operation property.
	public class SQLErrorOperation extends Object
	{
		/// Indicates that the SQLConnection.analyze() method was called.
		public static const ANALYZE : String;
		/// Indicates that the SQLConnection.attach() method was called.
		public static const ATTACH : String;
		/// Indicates that the SQLConnection.begin() method was called.
		public static const BEGIN : String;
		/// Indicates that the SQLConnection.close() method was called.
		public static const CLOSE : String;
		/// Indicates that the SQLConnection.commit() method was called.
		public static const COMMIT : String;
		/// Indicates that the SQLConnection.compact() method was called.
		public static const COMPACT : String;
		/// Indicates that the SQLConnection.deanalyze() method was called.
		public static const DEANALYZE : String;
		/// Indicates that the SQLConnection.detach() method was called.
		public static const DETACH : String;
		/// Indicates that either the SQLStatement.execute() method or the SQLStatement.next() method was called.
		public static const EXECUTE : String;
		/// Indicates that either the SQLConnection.open() method or the SQLConnection.openAsync() method was called.
		public static const OPEN : String;
		/// Indicates that the SQLConnection.reencrypt() method was called.
		public static const REENCRYPT : String;
		/// Indicates that the SQLConnection.rollback() method was called.
		public static const ROLLBACK : String;
		/// Indicates that the SQLConnection.loadSchema() method was called.
		public static const SCHEMA : String;

		public function SQLErrorOperation ();
	}
}
