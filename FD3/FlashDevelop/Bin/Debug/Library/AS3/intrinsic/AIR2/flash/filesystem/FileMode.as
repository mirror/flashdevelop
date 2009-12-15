package flash.filesystem
{
	/// The FileMode class defines string constants used in the fileMode parameter of the open() and openAsync() methods of the FileStream class.
	public class FileMode extends Object
	{
		/// Used for a file to be opened in write mode, with all written data appended to the end of the file.
		public static const APPEND : String;
		/// Used for a file to be opened in read-only mode.
		public static const READ : String;
		/// Used for a file to be opened in read/write mode.
		public static const UPDATE : String;
		/// Used for a file to be opened in write-only mode.
		public static const WRITE : String;

		public function FileMode ();
	}
}
