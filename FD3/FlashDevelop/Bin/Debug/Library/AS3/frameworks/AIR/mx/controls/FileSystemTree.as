/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package mx.controls {
	import flash.filesystem.File;
	public class FileSystemTree extends Tree {
		/**
		 * The directory whose contents this control displays.
		 */
		public function get directory():File;
		public function set directory(value:File):void;
		/**
		 * A String specifying whether this control displays
		 *  only files, only subdirectories, or both.
		 *  In the case that both are displayed,
		 *  it also specifies whether the subdirectories are displayed
		 *  before, after, or mixed in with the files.
		 *  The possible values are specified
		 *  by the FileSystemEnumerationMode class.
		 */
		public function get enumerationMode():String;
		public function set enumerationMode(value:String):void;
		/**
		 * An Array of extensions specifying which files
		 *  can be displayed in this control.
		 *  If this property is set, for example,
		 *  to [ ".htm", ".html" ],
		 *  then only files with these extensions can be displayed.
		 */
		public function get extensions():Array;
		public function set extensions(value:Array):void;
		/**
		 * A callback Function that you can use to perform additional filtering,
		 *  after the enumerationMode and extensions
		 *  properties have been applied, to determine which files
		 *  and subdirectories are displayed and which are hidden.
		 */
		public function get filterFunction():Function;
		public function set filterFunction(value:Function):void;
		/**
		 * A callback Function that you can use to change how file and subdirectory
		 *  names are compared in order to produce the sort order.
		 */
		public function get nameCompareFunction():Function;
		public function set nameCompareFunction(value:Function):void;
		/**
		 * An Array of nativePath Strings for the File items
		 *  representing the open subdirectories.
		 *  This Array is empty if no subdirectories are open.
		 */
		public function get openPaths():Array;
		public function set openPaths(value:Array):void;
		/**
		 * The nativePath of the File item
		 *  representing the selected subdirectory or file,
		 *  or null if no item is selected.
		 */
		public function get selectedPath():String;
		public function set selectedPath(value:String):void;
		/**
		 * An Array of nativePath Strings for the File items
		 *  representing the selected subdirectories and files.
		 *  This Array is empty if no items are selected.
		 */
		public function get selectedPaths():Array;
		public function set selectedPaths(value:Array):void;
		/**
		 * A flag that specifies whether extensions in file names are shown.
		 *  Set this property to true to show file extensions
		 *  and to false to hide them.
		 *  Extensions in directory names are always shown.
		 */
		public function get showExtensions():Boolean;
		public function set showExtensions(value:Boolean):void;
		/**
		 * A flag that specifies whether files and directories
		 *  that the operating system considers hidden are displayed.
		 *  Set this property to true to show hidden files
		 *  and directories and to false to hide them.
		 */
		public function get showHidden():Boolean;
		public function set showHidden(value:Boolean):void;
		/**
		 * A flag that specifies that icons are displayed
		 *  before the file name.
		 *  Set this property to true to show icons
		 *  and to false to hide them.
		 */
		public function get showIcons():Boolean;
		public function set showIcons(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function FileSystemTree();
		/**
		 * Clears the list.
		 */
		public function clear():void;
		/**
		 * Closes a subdirectory specified by a native file system path.
		 *
		 * @param nativePath        <String> A String specifying the nativePath
		 *                            of a File item.
		 */
		public function closeSubdirectory(nativePath:String):void;
		/**
		 * Returns the index of the File item with the specified
		 *  native file system path.
		 *
		 * @param nativePath        <String> A String specifying the nativePath
		 *                            of a File item.
		 * @return                  <int> A zero-based index, or -1
		 *                            if no File was found with the specified path.
		 */
		public function findIndex(nativePath:String):int;
		/**
		 * Searches the File instances currently displayed in this control
		 *  and returns the one with the specified nativePathproperty.
		 *
		 * @param nativePath        <String> A String specifying the nativePath
		 *                            of a File item.
		 * @return                  <File> A File instance if one was found with the specified
		 *                            nativePath, or null if none was found.
		 */
		public function findItem(nativePath:String):File;
		/**
		 * Opens a subdirectory specified by a native file system path.
		 *
		 * @param nativePath        <String> A String specifying the nativePath
		 *                            of a File item.
		 */
		public function openSubdirectory(nativePath:String):void;
		/**
		 * Re-enumerates the current directory being displayed by this control.
		 */
		public function refresh():void;
		/**
		 * A constant that can be used as a value for the directory property,
		 *  representing a pseudo-top level directory named "Computer". This pseudo-directory
		 *  contains the root directories
		 *  (such as C:\ and D:\ on Windows or / on Macintosh).
		 */
		public static const COMPUTER:File;
	}
}
