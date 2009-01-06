package flash.errors
{
	/// This class contains the constants that represent the possible values for the SQLError.operation property.
	public class SQLErrorOperation extends Object
	{
		/// [AIR] Indicates that the SQLConnection.analyze() method was called.
		public static const ANALYZE : String;
		/// [AIR] Indicates that the SQLConnection.attach() method was called.
		public static const ATTACH : String;
		/// [AIR] Indicates that the SQLConnection.begin() method was called.
		public static const BEGIN : String;
		/// [AIR] Indicates that the SQLConnection.close() method was called.
		public static const CLOSE : String;
		/// [AIR] Indicates that the SQLConnection.commit() method was called.
		public static const COMMIT : String;
		/// [AIR] Indicates that the SQLConnection.compact() method was called.
		public static const COMPACT : String;
		/// [AIR] Indicates that the SQLConnection.deanalyze() method was called.
		public static const DEANALYZE : String;
		/// [AIR] Indicates that the SQLConnection.detach() method was called.
		public static const DETACH : String;
		/// [AIR] Indicates that either the SQLStatement.execute() method or the SQLStatement.next() method was called.
		public static const EXECUTE : String;
		/// [AIR] Indicates that either the SQLConnection.open() method or the SQLConnection.openAsync() method was called.
		public static const OPEN : String;
		public static const REENCRYPT : String;
		/// [AIR] Indicates that the SQLConnection.rollback() method was called.
		public static const ROLLBACK : String;
		/// [AIR] Indicates that the SQLConnection.loadSchema() method was called.
		public static const SCHEMA : String;

		public function SQLErrorOperation ();
	}
}
