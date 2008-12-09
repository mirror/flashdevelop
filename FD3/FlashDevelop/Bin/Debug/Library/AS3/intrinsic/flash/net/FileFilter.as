package flash.net
{
	/// The FileFilter class is used to indicate what files on the user's system are shown in the file-browsing dialog box that is displayed when FileReference.browse() or FileReferenceList.browse() is called.
	public class FileFilter
	{
		/// The description string for the filter.
		public var description:String;

		/// A list of file extensions.
		public var extension:String;

		/// A list of Macintosh file types.
		public var macType:String;

		/// Creates a new FileFilter instance.
		public function FileFilter(description:String, extension:String, macType:String=null);

	}

}

