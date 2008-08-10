/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLTransactionLockType {
		/**
		 * Specifies the deferred locking transaction option.
		 *  A deferred-lock transaction does not acquire a lock on the database
		 *  until the database is first accessed. With a deferred
		 *  transaction, a lock is not acquired until the first read or write
		 *  operation.
		 */
		public static const DEFERRED:String = "deferred";
		/**
		 * Specifies the exclusive locking transaction option.
		 *  An exclusive-locked transaction acquires a lock on the database immediately.
		 *  Other SQLStatement objects executing against the same database through a
		 *  different SQLConnection (in the same AIR application or a different one)
		 *  can't read data from or write data to the database.
		 */
		public static const EXCLUSIVE:String = "exclusive";
		/**
		 * Specifies the immediate locking transaction option.
		 *  An immediate-locked transaction acquires a lock on the database immediately.
		 *  SQLStatement objects executing against the same database through a
		 *  different SQLConnection (in the same AIR application or a different one)
		 *  can read data from the database but can't write data to it. However, for those
		 *  other connections reading data from the database, the initial state of the data
		 *  in the database is identical to the state of the database before the
		 *  in-transaction SQLConnection instance's begin() method was called.
		 *  Any uncommitted data changes made within the immediate-locked transaction are
		 *  not available to the other connections.
		 */
		public static const IMMEDIATE:String = "immediate";
	}
}
