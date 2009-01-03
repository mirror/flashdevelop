package flash.data
{
	/// This class contains the constants that represent the possible values for the option parameter of the SQLConnection.begin() method.
	public class SQLTransactionLockType extends Object
	{
		/// [AIR] Specifies the deferred locking transaction option.
		public static const DEFERRED : String;
		/// [AIR] Specifies the exclusive locking transaction option.
		public static const EXCLUSIVE : String;
		/// [AIR] Specifies the immediate locking transaction option.
		public static const IMMEDIATE : String;
	}
}
