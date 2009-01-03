package flash.filesystem
{
	import flash.net.FileReference;
	import flash.filesystem.File;
	import flash.desktop.Icon;

	/**
	 * Dispatched when a directory list is available as a result of a call to the getDirectoryListingAsync() method.
	 * @eventType flash.events.FileListEvent.DIRECTORY_LISTING
	 */
	[Event(name="directoryListing", type="flash.events.FileListEvent")] 

	/**
	 * Dispatched when the user selects files from the dialog box opened by a call to the browseForOpenMultiple() method.
	 * @eventType flash.events.FileListEvent.SELECT_MULTIPLE
	 */
	[Event(name="selectMultiple", type="flash.events.FileListEvent")] 

	/**
	 * Dispatched when the user selects a file or directory from a file- or directory-browsing dialog box.
	 * @eventType flash.events.Event.SELECT
	 */
	[Event(name="select", type="flash.events.Event")] 

	/**
	 * Dispatched when an operation violates a security constraint.
	 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
	 */
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")] 

	/**
	 * Dispatched when an error occurs during an asynchronous file operation.
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 

	/**
	 * Dispatched when an asynchronous operation is complete.
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/**
	 * Dispatched when a pending asynchronous operation is canceled.
	 * @eventType flash.events.Event.CANCEL
	 */
	[Event(name="cancel", type="flash.events.Event")] 

	/// A File object represents a path to a file or directory.
	public class File extends FileReference
	{
		/// [AIR] The folder containing the application's installed files.
		public static function get applicationDirectory () : File;

		/// [AIR] The application's private storage directory.
		public static function get applicationStorageDirectory () : File;

		/// [AIR] The user's desktop directory.
		public static function get desktopDirectory () : File;

		/// [AIR] The user's documents directory.
		public static function get documentsDirectory () : File;

		/// [AIR] Indicates whether the referenced file or directory exists.
		public function get exists () : Boolean;

		/// [AIR] An Icon object containing the icons defined for the file.
		public function get icon () : Icon;

		/// [AIR] Indicates whether the reference is to a directory.
		public function get isDirectory () : Boolean;

		/// [AIR] Indicates whether the referenced file or directory is "hidden." The value is true if the referenced file or directory is hidden, false otherwise.
		public function get isHidden () : Boolean;

		/// [AIR] Indicates whether the referenced directory is a package.
		public function get isPackage () : Boolean;

		/// [AIR] Indicates whether the reference is a symbolic link.
		public function get isSymbolicLink () : Boolean;

		/// [AIR] The line-ending character sequence used by the host operating system.
		public static function get lineEnding () : String;

		/// [AIR] The full path in the host operating system representation.
		public function get nativePath () : String;
		public function set nativePath (value:String) : void;

		/// [AIR] The directory that contains the file or directory referenced by this File object.
		public function get parent () : File;

		/// [AIR] The host operating system's path component separator character.
		public static function get separator () : String;

		/// [AIR] The space available for use at this File location, in bytes.
		public function get spaceAvailable () : Number;

		/// [AIR] The default encoding used by the host operating system.
		public static function get systemCharset () : String;

		/// [AIR] The URL for this file path.
		public function get url () : String;
		public function set url (value:String) : void;

		/// [AIR] The user's directory.
		public static function get userDirectory () : File;

		/// [AIR] Displays a directory chooser dialog box, in which the user can select a directory.
		public function browseForDirectory (title:String) : void;

		/// [AIR] Displays the Open File dialog box, in which the user can select a file to open.
		public function browseForOpen (title:String, typeFilter:Array) : void;

		/// [AIR] Displays the Open File dialog box, in which the user can select one or more files to open.
		public function browseForOpenMultiple (title:String, typeFilter:Array) : void;

		/// [AIR] Displays the Save File dialog box, in which the user can select a file destination.
		public function browseForSave (title:String) : void;

		/// [AIR] Cancels any pending asynchronous operation.
		public function cancel () : void;

		/// [AIR] Canonicalizes the File path.
		public function canonicalize () : void;

		/// [AIR] Returns a copy of this File object.
		public function clone () : File;

		/// [AIR] Copies the file or directory at the location specified by this File object to the location specified by the newLocation parameter.
		public function copyTo (newLocation:FileReference, overwrite:Boolean) : void;

		/// [AIR] Begins copying the file or directory at the location specified by this File object to the location specified by the destination parameter.
		public function copyToAsync (newLocation:FileReference, overwrite:Boolean) : void;

		/// [AIR] Creates the specified directory and any necessary parent directories.
		public function createDirectory () : void;

		/// [AIR] Returns a reference to a new temporary directory.
		public static function createTempDirectory () : File;

		/// [AIR] Returns a reference to a new temporary file.
		public static function createTempFile () : File;

		/// [AIR] Deletes the directory.
		public function deleteDirectory (deleteDirectoryContents:Boolean) : void;

		/// [AIR] Deletes the directory asynchronously.
		public function deleteDirectoryAsync (deleteDirectoryContents:Boolean) : void;

		/// [AIR] Deletes the file.
		public function deleteFile () : void;

		/// [AIR] Deletes the file asynchronously.
		public function deleteFileAsync () : void;

		/// [AIR] Returns an array of File objects corresponding to files and directories in the directory represented by this File object.
		public function getDirectoryListing () : Array;

		/// [AIR] Asynchronously retrieves an array of File objects corresponding to the contents of the directory represented by this File object.
		public function getDirectoryListingAsync () : void;

		/// [AIR] Finds the relative path between two File paths.
		public function getRelativePath (ref:FileReference, useDotDot:Boolean) : String;

		/// [AIR] Returns an array of File objects, listing the file system root directories.
		public static function getRootDirectories () : Array;

		/// [AIR] Moves the file or directory at the location specified by this File object to the location specified by the destination parameter.
		public function moveTo (newLocation:FileReference, overwrite:Boolean) : void;

		/// [AIR] Begins moving the file or directory at the location specified by this File object to the location specified by the newLocation parameter.
		public function moveToAsync (newLocation:FileReference, overwrite:Boolean) : void;

		/// [AIR] Moves a file or directory to the trash.
		public function moveToTrash () : void;

		/// [AIR] Asynchronously moves a file or directory to the trash.
		public function moveToTrashAsync () : void;

		/// [AIR] Creates a new File object with a path relative to this File object's path, based on the path parameter (a string).
		public function resolvePath (path:String) : File;

		public function toString () : String;
	}
}
