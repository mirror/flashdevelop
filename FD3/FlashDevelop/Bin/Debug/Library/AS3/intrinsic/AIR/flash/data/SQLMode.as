package flash.data
{
	/// This class contains the constants that represent the possible values for the openMode parameter of the SQLConnection.open() and SQLConnection.openAsync() methods.
	public class SQLMode extends Object
	{
		/// [AIR] Indicates that the connection is opened for updates, and a database file is created if the specified file doesn't exist.
		public static const CREATE : String;
		/// [AIR] Indicates that the connection is opened in read-only mode.
		public static const READ : String;
		/// [AIR] Indicates that the connection is opened for updates but a new database file is not created if the specified file doesn't exist.
		public static const UPDATE : String;

		public function SQLMode ();
	}
}
