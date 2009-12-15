package flash.data
{
	/// This class contains the constants that represent the possible values for the option parameter of the SQLConnection.begin() method.
	public class SQLTransactionLockType extends Object
	{
		/// Specifies the deferred locking transaction option.
		public static const DEFERRED : String;
		/// Specifies the exclusive locking transaction option.
		public static const EXCLUSIVE : String;
		/// Specifies the immediate locking transaction option.
		public static const IMMEDIATE : String;

		public function SQLTransactionLockType ();
	}
}
