/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class FileReferenceList extends EventDispatcher {
		/**
		 * An array of FileReference objects.
		 */
		public function get fileList():Array;
		/**
		 * Creates a new FileReferenceList object. A FileReferenceList object contains nothing
		 *  until you call the browse() method on it and the user selects one or more files.
		 *  When you call browse() on the
		 *  FileReference object, the fileList property of the object is populated
		 *  with an array of FileReference objects.
		 */
		public function FileReferenceList();
		/**
		 * Displays a file-browsing dialog box that lets the
		 *  user select one or more local files to upload. The dialog box is native to the user's
		 *  operating system.
		 *  When you call this method and the user successfully selects files,
		 *  the fileList property of this FileReferenceList object is populated with
		 *  an array of FileReference objects, one for each file that the user selects.
		 *  Each subsequent time that the FileReferenceList.browse() method is called, the
		 *  FileReferenceList.fileList property is reset to the file(s) that the
		 *  user selects in the dialog box.
		 *
		 * @param typeFilter        <Array (default = null)> An array of FileFilter instances used to filter the files that are
		 *                            displayed in the dialog box. If you omit this parameter, all files are displayed.
		 *                            For more information, see the FileFilter class.
		 * @return                  <Boolean> Returns true if the parameters are valid and the file-browsing dialog box
		 *                            opens.
		 */
		public function browse(typeFilter:Array = null):Boolean;
	}
}
