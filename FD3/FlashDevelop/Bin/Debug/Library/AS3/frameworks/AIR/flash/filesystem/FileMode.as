/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.filesystem {
	public class FileMode {
		/**
		 * Used for a file to be opened in write mode, with all written data appended to the end of the file.
		 *  Upon opening, any nonexistent file is created.
		 */
		public static const APPEND:String = "append";
		/**
		 * Used for a file to be opened in read-only mode. The file must exist (missing files are not created).
		 */
		public static const READ:String = "read";
		/**
		 * Used for a file to be opened in read/write mode. Upon opening, any nonexistent file is created.
		 */
		public static const UPDATE:String = "update";
		/**
		 * Used for a file to be opened in write-only mode. Upon opening, any nonexistent file is created, and any
		 *  existing file is truncated (its data is deleted).
		 */
		public static const WRITE:String = "write";
	}
}
