package flash.filesystem
{
	/// The FileMode class defines string constants used in the fileMode parameter of the open() and openAsync() methods of the FileStream class.
	public class FileMode
	{
		/// [AIR] Used for a file to be opened in read-only mode.
		public static const READ:String = "read";

		/// [AIR] Used for a file to be opened in write-only mode.
		public static const WRITE:String = "write";

		/// [AIR] Used for a file to be opened in read/write mode.
		public static const UPDATE:String = "update";

		/// [AIR] Used for a file to be opened in write mode, with all written data appended to the end of the file.
		public static const APPEND:String = "append";

	}

}

