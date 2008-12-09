package flash.filesystem
{
	/// A File object represents a path to a file or directory.
	public class File extends flash.net.FileReference
	{
		/** 
		 * [AIR] Dispatched when a directory list is available as a result of a call to the getDirectoryListingAsync() method.
		 * @eventType flash.events.FileListEvent.DIRECTORY_LISTING
		 */
		[Event(name="directoryListing", type="flash.events.FileListEvent")]

		/** 
		 * [AIR] Dispatched when the user selects files from the dialog box opened by a call to the browseForOpenMultiple() method.
		 * @eventType flash.events.FileListEvent.SELECT_MULTIPLE
		 */
		[Event(name="selectMultiple", type="flash.events.FileListEvent")]

		/** 
		 * [AIR] Dispatched when the user selects a file or directory from a file- or directory-browsing dialog box.
		 * @eventType flash.events.Event.SELECT
		 */
		[Event(name="select", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when an operation violates a security constraint.
		 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
		 */
		[Event(name="securityError", type="flash.events.SecurityErrorEvent")]

		/** 
		 * [AIR] Dispatched when an error occurs during an asynchronous file operation.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * [AIR] Dispatched when an asynchronous operation is complete.
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when a pending asynchronous operation is canceled.
		 * @eventType flash.events.Event.CANCEL
		 */
		[Event(name="cancel", type="flash.events.Event")]

		/// [AIR] The default encoding used by the host operating system.
		public var systemCharset:String;

		/// [AIR] The host operating system's path component separator character.
		public var separator:String;

		/// [AIR] The line-ending character sequence used by the host operating system.
		public var lineEnding:String;

		/// [AIR] Indicates whether the referenced file or directory exists.
		public var exists:Boolean;

		/// [AIR] Indicates whether the referenced file or directory is "hidden." The value is true if the referenced file or directory is hidden, false otherwise.
		public var isHidden:Boolean;

		/// [AIR] Indicates whether the reference is to a directory.
		public var isDirectory:Boolean;

		/// [AIR] Indicates whether the referenced directory is a package.
		public var isPackage:Boolean;

		/// [AIR] Indicates whether the reference is a symbolic link.
		public var isSymbolicLink:Boolean;

		/// [AIR] The directory that contains the file or directory referenced by this File object.
		public var parent:flash.filesystem.File;

		/// [AIR] The full path in the host operating system representation.
		public var nativePath:String;

		/// [AIR] The user's directory.
		public var userDirectory:flash.filesystem.File;

		/// [AIR] The user's documents directory.
		public var documentsDirectory:flash.filesystem.File;

		/// [AIR] The user's desktop directory.
		public var desktopDirectory:flash.filesystem.File;

		/// [AIR] The application's private storage directory.
		public var applicationStorageDirectory:flash.filesystem.File;

		/// [AIR] The folder containing the application's installed files.
		public var applicationDirectory:flash.filesystem.File;

		/// [AIR] The URL for this file path.
		public var url:String;

		/// [AIR] An Icon object containing the icons defined for the file.
		public var icon:flash.desktop.Icon;

		/// [AIR] The space available for use at this File location, in bytes.
		public var spaceAvailable:Number;

		/// [AIR] The constructor function for the File class.
		public function File(path:String=null);

		/// [AIR] Cancels any pending asynchronous operation.
		public function cancel():void;

		/// [AIR] Creates a new File object with a path relative to this File object's path, based on the path parameter (a string).
		public function resolvePath(path:String):flash.filesystem.File;

		/// [AIR] Finds the relative path between two File paths.
		public function getRelativePath(ref:flash.net.FileReference, useDotDot:Boolean=false):String;

		/// [AIR] Returns a reference to a new temporary file.
		public static function createTempFile():flash.filesystem.File;

		/// [AIR] Returns a reference to a new temporary directory.
		public static function createTempDirectory():flash.filesystem.File;

		/// [AIR] Returns an array of File objects, listing the file system root directories.
		public static function getRootDirectories():Array;

		/// [AIR] Canonicalizes the File path.
		public function canonicalize():void;

		/// [AIR] Displays the Open File dialog box, in which the user can select a file to open.
		public function browseForOpen(title:String, typeFilter:Array=null):void;

		/// [AIR] Displays the Open File dialog box, in which the user can select one or more files to open.
		public function browseForOpenMultiple(title:String, typeFilter:Array=null):void;

		/// [AIR] Displays the Save File dialog box, in which the user can select a file destination.
		public function browseForSave(title:String):void;

		/// [AIR] Displays a directory chooser dialog box, in which the user can select a directory.
		public function browseForDirectory(title:String):void;

		/// [AIR] Deletes the file.
		public function deleteFile():void;

		/// [AIR] Deletes the file asynchronously.
		public function deleteFileAsync():void;

		/// [AIR] Deletes the directory.
		public function deleteDirectory(deleteDirectoryContents:Boolean=false):void;

		/// [AIR] Deletes the directory asynchronously.
		public function deleteDirectoryAsync(deleteDirectoryContents:Boolean=false):void;

		/// [AIR] Copies the file or directory at the location specified by this File object to the location specified by the newLocation parameter.
		public function copyTo(newLocation:flash.net.FileReference, overwrite:Boolean=false):void;

		/// [AIR] Begins copying the file or directory at the location specified by this File object to the location specified by the destination parameter.
		public function copyToAsync(newLocation:flash.net.FileReference, overwrite:Boolean=false):void;

		/// [AIR] Moves the file or directory at the location specified by this File object to the location specified by the destination parameter.
		public function moveTo(newLocation:flash.net.FileReference, overwrite:Boolean=false):void;

		/// [AIR] Begins moving the file or directory at the location specified by this File object to the location specified by the newLocation parameter.
		public function moveToAsync(newLocation:flash.net.FileReference, overwrite:Boolean=false):void;

		/// [AIR] Moves a file or directory to the trash.
		public function moveToTrash():void;

		/// [AIR] Asynchronously moves a file or directory to the trash.
		public function moveToTrashAsync():void;

		/// [AIR] Creates the specified directory and any necessary parent directories.
		public function createDirectory():void;

		/// [AIR] Returns an array of File objects corresponding to files and directories in the directory represented by this File object.
		public function getDirectoryListing():Array;

		/// [AIR] Asynchronously retrieves an array of File objects corresponding to the contents of the directory represented by this File object.
		public function getDirectoryListingAsync():void;

		/// [AIR] Returns a copy of this File object.
		public function clone():flash.filesystem.File;

	}

}

