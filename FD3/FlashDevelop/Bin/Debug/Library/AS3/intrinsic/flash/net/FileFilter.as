/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public final  class FileFilter {
		/**
		 * The description string for the filter. The description
		 *  is visible to the user in the dialog box that opens
		 *  when FileReference.browse()
		 *  or FileReferenceList.browse() is called.
		 *  The description string contains a string, such as
		 *  "Images (*.gif, *.jpg, *.png)", that can
		 *  help instruct the user on what file types can be uploaded
		 *  or downloaded. Note that the actual file types that are supported by
		 *  this FileReference object are stored in the extension
		 *  property.
		 */
		public function get description():String;
		public function set description(value:String):void;
		/**
		 * A list of file extensions. This list indicates the types of files
		 *  that you want to show in the file-browsing dialog box. (The list
		 *  is not visible to the user; the user sees only the value of the
		 *  description property.) The extension property contains
		 *  a semicolon-delimited list of Windows file extensions,
		 *  with a wildcard (*) preceding each extension, as shown
		 *  in the following string: "*.jpg;*.gif;*.png".
		 */
		public function get extension():String;
		public function set extension(value:String):void;
		/**
		 * A list of Macintosh file types. This list indicates the types of files
		 *  that you want to show in the file-browsing dialog box. (This list
		 *  itself is not visible to the user; the user sees only the value of the
		 *  description property.) The macType property contains
		 *  a semicolon-delimited list of Macintosh file types, as shown
		 *  in the following string: "JPEG;jp2_;GIFF".
		 */
		public function get macType():String;
		public function set macType(value:String):void;
		/**
		 * Creates a new FileFilter instance.
		 *
		 * @param description       <String> The description string that is visible to users when they select files for uploading.
		 * @param extension         <String> A list of file extensions that indicate which Windows file formats are visible to users
		 *                            when they select files for uploading.
		 * @param macType           <String (default = null)> A list of Macintosh file types that indicate which file types are visible to
		 *                            users when they select files for uploading. If no value is passed, this parameter is set to null.
		 */
		public function FileFilter(description:String, extension:String, macType:String = null);
	}
}
