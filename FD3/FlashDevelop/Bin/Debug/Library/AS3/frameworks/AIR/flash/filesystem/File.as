/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.filesystem {
	import flash.net.FileReference;
	import flash.desktop.Icon;
	public class File extends FileReference {
		/**
		 * The folder containing the application's installed files.
		 */
		public static function get applicationDirectory():File;
		/**
		 * The application's private storage directory.
		 */
		public static function get applicationStorageDirectory():File;
		/**
		 * The user's desktop directory.
		 */
		public static function get desktopDirectory():File;
		/**
		 * The user's documents directory.
		 */
		public static function get documentsDirectory():File;
		/**
		 * Indicates whether the referenced file or directory exists.
		 *  The value is true if the File object points to an existing file or directory,
		 *  false otherwise.
		 */
		public function get exists():Boolean;
		/**
		 * An Icon object containing the icons defined for the file. An Icon object is an array of BitmapData
		 *  objects corresponding to the various icon states.
		 */
		public function get icon():Icon;
		/**
		 * Indicates whether the reference is to a directory.
		 *  The value is true if the File object points to a directory; false otherwise.
		 */
		public function get isDirectory():Boolean;
		/**
		 * Indicates whether the referenced file or directory is "hidden."
		 *  The value is true if the referenced file or directory is hidden, false otherwise.
		 */
		public function get isHidden():Boolean;
		/**
		 * Indicates whether the referenced directory is a package.
		 */
		public function get isPackage():Boolean;
		/**
		 * Indicates whether the reference is a symbolic link.
		 */
		public function get isSymbolicLink():Boolean;
		/**
		 * The line-ending character sequence used by the host operating system.
		 */
		public static function get lineEnding():String;
		/**
		 * The full path in the host operating system representation. On Mac OS,
		 *  the forward slash (/) character is used as the path separator.
		 *  However, in Windows, you can set the nativePath property
		 *  by using the forward slash character or the backslash (\) character as the
		 *  path separator, and AIR automatically replaces forward slashes with
		 *  the appropriate backslash character.
		 */
		public function get nativePath():String;
		public function set nativePath(value:String):void;
		/**
		 * The directory that contains the file or directory referenced by this File object.
		 */
		public function get parent():File;
		/**
		 * The host operating system's path component separator character.
		 */
		public static function get separator():String;
		/**
		 * The default encoding used by the host operating system.
		 */
		public static function get systemCharset():String;
		/**
		 * The URL for this file path.
		 */
		public function get url():String;
		public function set url(value:String):void;
		/**
		 * The user's directory.
		 */
		public static function get userDirectory():File;
		/**
		 * The constructor function for the File class.
		 *
		 * @param path              <String (default = null)> The path to the file. You can specify the path by using either a URL or
		 *                            native path (platform-specific) notation.
		 *                            If you specify a URL, you can use any of the following
		 *                            URL schemes: file, app, or
		 *                            app-storage. The following are valid values for the path
		 *                            parameter using URL notation:
		 *                            "app:/DesktopPathTest.xml"
		 *                            "app-storage:/preferences.xml"
		 *                            "file:///C:/Documents%20and%20Settings/bob/Desktop" (the desktop on Bob's Windows computer)
		 *                            "file:///Users/bob/Desktop" (the desktop on Bob's Mac computer)
		 *                            The app and app-storage URL schemes
		 *                            are useful because they can point to a valid file on both Mac and Windows. However,
		 *                            in the other two examples, which use the file URL scheme to point to the
		 *                            user's desktop directory, it would be better to pass no path argument
		 *                            to the File() constructor and then assign File.desktopDirectory
		 *                            to the File object, as a way to access the desktop directory that is both platform- and
		 *                            user-independent.
		 *                            If you specify a native path, on Windows you can use either the backslash character or
		 *                            the forward slash character as the path separator in this argument; on Mac OS, use the
		 *                            forward slash. The following are valid values for the path parameter using
		 *                            native path notation:
		 *                            "C:/Documents and Settings/bob/Desktop"
		 *                            "/Users/bob/Desktop"
		 *                            However, for these two examples, you should pass no path argument
		 *                            to the File() constructor and then assign File.desktopDirectory
		 *                            to the File object, as a way to access the desktop directory that is both platform- and
		 *                            user-independent.
		 */
		public function File(path:String = null);
		/**
		 * Displays a directory chooser dialog box, in which the user can select a directory.
		 *  When the user selects the directory, the select event is dispatched.
		 *  The target property of the select event is the
		 *  File object pointing to the selected directory.
		 *
		 * @param title             <String> The string that is diplayed in the title bar of the dialog box.
		 */
		public function browseForDirectory(title:String):void;
		/**
		 * Displays the Open File dialog box, in which the user can select a file to open.
		 *
		 * @param title             <String> The string that is diplayed in the title bar of the dialog box.
		 * @param typeFilter        <Array (default = null)> An array of FileFilter instances used to filter the files
		 *                            that are displayed in the dialog box. If you omit this parameter, all files are
		 *                            displayed. For more information, see the FileFilter class.
		 */
		public function browseForOpen(title:String, typeFilter:Array = null):void;
		/**
		 * Displays the Open File dialog box, in which the user can select one or more files to open.
		 *
		 * @param title             <String> The string that is diplayed in the title bar of the dialog box.
		 * @param typeFilter        <Array (default = null)> An array of FileFilter instances used to filter the files
		 *                            that are displayed in the dialog box. If you omit this parameter, all files are
		 *                            displayed. For more information, see the FileFilter class.
		 */
		public function browseForOpenMultiple(title:String, typeFilter:Array = null):void;
		/**
		 * Displays the Save File dialog box, in which the user can select a file destination.
		 *
		 * @param title             <String> The string that is diplayed in the title bar of the dialog box.
		 */
		public function browseForSave(title:String):void;
		/**
		 * Cancels any pending asynchronous operation.
		 */
		public override function cancel():void;
		/**
		 * Canonicalizes the File path.
		 */
		public function canonicalize():void;
		/**
		 * Returns a copy of this File object. Event registrations are not copied.
		 */
		public function clone():File;
		/**
		 * Copies the file or directory at the location specified by this File object to
		 *  the location specified by the newLocation parameter. The copy process
		 *  creates any required parent directories (if possible).
		 *
		 * @param newLocation       <FileReference> The target location of the new file. Note that this File object specifies
		 *                            the resulting (copied) file or directory, not the path to the containing directory.
		 * @param overwrite         <Boolean (default = false)> If false, the copy fails if the file specified by the target
		 *                            parameter already exists. If true, the operation first deletes any existing file or directory
		 *                            of the same name. (However, you cannot copy a file or folder to its original path.)
		 *                            Note: If you set this parameter to true and the source and destination File objects
		 *                            point to the same path, calling this method deletes the file or directory.
		 */
		public function copyTo(newLocation:FileReference, overwrite:Boolean = false):void;
		/**
		 * Begins copying the file or directory at the location specified by this File object to
		 *  the location specified by the destination parameter.
		 *
		 * @param newLocation       <FileReference> The target location of the new file. Note that this File object specifies
		 *                            the resulting (copied) file or directory, not the path to the containing directory.
		 * @param overwrite         <Boolean (default = false)> If false, the copy fails if the file specified by the target
		 *                            file already exists. If true, the operation first deletes any existing file or directory
		 *                            of the same name.
		 */
		public function copyToAsync(newLocation:FileReference, overwrite:Boolean = false):void;
		/**
		 * Creates the specified directory and any necessary parent directories. If the
		 *  directory already exists, no action is taken.
		 */
		public function createDirectory():void;
		/**
		 * Returns a reference to a new temporary directory. This is a new directory
		 *  in the system's temporary directory path.
		 *
		 * @return                  <File> A File object referencing the new temporary directory.
		 */
		public static function createTempDirectory():File;
		/**
		 * Returns a reference to a new temporary file. This is a new file
		 *  in the system's temporary directory path.
		 *
		 * @return                  <File> A File object referencing the new temporary file.
		 */
		public static function createTempFile():File;
		/**
		 * Deletes the directory.
		 *
		 * @param deleteDirectoryContents<Boolean (default = false)> Specifies whether or not to delete a directory that contains files or
		 *                            subdirectories. When false, if the directory contains files or directories, a call to
		 *                            this method throws an exception.
		 */
		public function deleteDirectory(deleteDirectoryContents:Boolean = false):void;
		/**
		 * Deletes the directory asynchronously.
		 *
		 * @param deleteDirectoryContents<Boolean (default = false)> Specifies whether or not to delete a directory that contains files or
		 *                            subdirectories. When false, if the directory contains files or directories,
		 *                            the File object dispatches an ioError event.
		 */
		public function deleteDirectoryAsync(deleteDirectoryContents:Boolean = false):void;
		/**
		 * Deletes the file.
		 */
		public function deleteFile():void;
		/**
		 * Deletes the file asynchronously.
		 */
		public function deleteFileAsync():void;
		/**
		 * Returns an array of File objects corresponding to files and directories in the directory represented by this
		 *  File object. This method does not explore the contents of subdirectories.
		 *
		 * @return                  <Array> An array of File objects.
		 */
		public function getDirectoryListing():Array;
		/**
		 * Asynchronously retrieves an array of File objects corresponding to the contents of the directory represented
		 *  by this File object.
		 */
		public function getDirectoryListingAsync():void;
		/**
		 * Finds the relative path between two File paths.
		 *
		 * @param ref               <FileReference> A File object against which the path is given.
		 * @param useDotDot         <Boolean (default = false)> Specifies whether the resulting relative path can use ".." components.
		 * @return                  <String> The relative path between this file (or directory) and the ref file
		 *                            (or directory), if possible; otherwise null.
		 */
		public function getRelativePath(ref:FileReference, useDotDot:Boolean = false):String;
		/**
		 * Returns an array of File objects, listing the file system root directories.
		 *
		 * @return                  <Array> An array of File objects, listing the root directories.
		 */
		public static function getRootDirectories():Array;
		/**
		 * Moves the file or directory at the location specified by this File object to
		 *  the location specified by the destination parameter.
		 *
		 * @param newLocation       <FileReference> The target location for the move. This object specifies the path to the resulting
		 *                            (moved) file or directory, not the path to the containing directory.
		 * @param overwrite         <Boolean (default = false)> If false, the move fails if the target file
		 *                            already exists. If true, the operation overwrites any existing file or directory
		 *                            of the same name.
		 *                            Note: If you set this parameter to true and the source and
		 *                            destination File objects point to the same path, calling this method deletes the file or directory.
		 */
		public function moveTo(newLocation:FileReference, overwrite:Boolean = false):void;
		/**
		 * Begins moving the file or directory at the location specified by this File object to
		 *  the location specified by the newLocation parameter.
		 *
		 * @param newLocation       <FileReference> The target location for the move. This object specifies the path to the resulting
		 *                            (moved) file or directory, not the path to the containing directory.
		 * @param overwrite         <Boolean (default = false)> If false, the move fails if the target file
		 *                            already exists. If true, the operation overwrites any existing file or directory
		 *                            of the same name.
		 */
		public function moveToAsync(newLocation:FileReference, overwrite:Boolean = false):void;
		/**
		 * Moves a file or directory to the trash.
		 */
		public function moveToTrash():void;
		/**
		 * Asynchronously moves a file or directory to the trash.
		 */
		public function moveToTrashAsync():void;
		/**
		 * Creates a new File object with a path relative to this File object's path, based on the
		 *  path parameter (a String).
		 *
		 * @param path              <String> The path to append to this File object's path.
		 * @return                  <File> A new File object, with the specified relative file path.
		 */
		public function resolvePath(path:String):File;
	}
}
