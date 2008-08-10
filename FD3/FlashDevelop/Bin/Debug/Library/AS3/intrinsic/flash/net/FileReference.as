/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class FileReference extends EventDispatcher {
		/**
		 * The creation date of the file on the local disk. If the object is
		 *  was not populated, a call to get the value of this property returns null.
		 */
		public function get creationDate():Date;
		/**
		 * The Macintosh creator type of the file, which is only used in Mac OS versions
		 *  prior to Mac OS X. In Windows, this property is null.
		 *  If the FileReference object
		 *  was not populated, a call to get the value of this property returns null.
		 */
		public function get creator():String;
		/**
		 * The date that the file on the local disk was last modified. If the FileReference
		 *  object was not populated, a call to get the value of this property returns null.
		 */
		public function get modificationDate():Date;
		/**
		 * The name of the file on the local disk. If the FileReference object
		 *  was not populated (by a valid call to FileReference.download() or
		 *  FileReference.browse()), Flash Player throws an error when you try to get the
		 *  value of this property.
		 */
		public function get name():String;
		/**
		 * The size of the file on the local disk in bytes. If size is 0,
		 *  an exception is thrown.
		 */
		public function get size():Number;
		/**
		 * The file type. In Windows, this property is the file extension. On the Macintosh, this property is
		 *  the four-character file type, which is only used in Mac OS versions prior to Mac OS X. If the FileReference object
		 *  was not populated, a call to get the value of this property returns null.
		 */
		public function get type():String;
		/**
		 * Creates a new FileReference object. When populated, a FileReference object represents a file
		 *  on the user's local disk.
		 */
		public function FileReference();
		/**
		 * Displays a file-browsing dialog box that lets the
		 *  user select a file to upload. The dialog box is native to the user's
		 *  operating system. The user can select a file on the local computer
		 *  or from other systems, for example, through a UNC path on Windows.
		 *
		 * @param typeFilter        <Array (default = null)> An array of FileFilter instances used to filter the files that are
		 *                            displayed in the dialog box. If you omit this parameter,
		 *                            all files are displayed.
		 *                            For more information, see the FileFilter class.
		 * @return                  <Boolean> Returns true if the parameters are valid and the file-browsing dialog box
		 *                            opens.
		 */
		public function browse(typeFilter:Array = null):Boolean;
		/**
		 * Cancels any ongoing upload or download operation on this FileReference object.
		 *  Calling this method does not dispatch the cancel event; that event
		 *  is dispatched only when the user cancels the operation by dismissing the
		 *  file upload or download dialog box.
		 */
		public function cancel():void;
		/**
		 * Opens a dialog box that lets the user download a file from a remote server.
		 *  Although Flash Player has no restriction on the size of files you can upload or download,
		 *  the player officially supports uploads or downloads of up to 100 MB.
		 *
		 * @param request           <URLRequest> The URLRequest object. The url property of the URLRequest object
		 *                            should contain the URL of the file to download to the local computer.
		 *                            If this parameter is null, an exception is thrown.
		 *                            To send POST or GET parameters to the server, set the value of URLRequest.data
		 *                            to your parameters, and set URLRequest.method to either URLRequestMethod.POST
		 *                            or URLRequestMethod.GET.
		 *                            On some browsers, URL strings are limited in length. Lengths greater than 256 characters may
		 *                            fail on some browsers or servers.
		 * @param defaultFileName   <String (default = null)> The default filename displayed in the dialog box for the file
		 *                            to be downloaded. This string must not contain the following characters:
		 *                            / \ : * ? " < > | %
		 *                            If you omit this parameter, the filename of the
		 *                            remote URL is parsed and used as the default.
		 */
		public function download(request:URLRequest, defaultFileName:String = null):void;
		/**
		 * Starts the upload of a file selected by a user to a remote server. Although
		 *  Flash Player has no restriction on the size of files you can upload or download,
		 *  the player officially supports uploads or downloads of up to 100 MB.
		 *  You must call the FileReference.browse() or FileReferenceList.browse()
		 *  method before you call this method.
		 *
		 * @param request           <URLRequest> The URLRequest object; the url property of the URLRequest object
		 *                            should contain the URL of the server script
		 *                            configured to handle upload through HTTP POST calls.
		 *                            On some browsers, URL strings are limited in length.
		 *                            Lengths greater than 256 characters may fail on some browsers or servers.
		 *                            If this parameter is null, an exception is thrown.
		 *                            The URL can be HTTP or, for secure uploads, HTTPS.
		 *                            To use HTTPS, use an HTTPS url in the url parameter.
		 *                            If you do not specify a port number in the url
		 *                            parameter, port 80 is used for HTTP and port 443 us used for HTTPS, by default.
		 *                            To send POST or GET parameters to the server, set the data property
		 *                            of the URLRequest object to your parameters, and set the method property
		 *                            to either URLRequestMethod.POST or
		 *                            URLRequestMethod.GET.
		 * @param uploadDataFieldName<String (default = "Filedata")> The field name that precedes the file data in the upload POST operation.
		 *                            The uploadDataFieldName value must be non-null and a non-empty String.
		 *                            By default, the value of uploadDataFieldName is "Filedata",
		 *                            as shown in the following sample POST request:
		 *                            Content-Type: multipart/form-data; boundary=AaB03x
		 *                            --AaB03x
		 *                            Content-Disposition: form-data; name="Filedata"; filename="example.jpg"
		 *                            Content-Type: application/octet-stream
		 *                            ... contents of example.jpg ...
		 *                            --AaB03x--
		 * @param testUpload        <Boolean (default = false)> A setting to request a test file upload. If testUpload
		 *                            is true, for files larger than 10 KB, Flash Player attempts
		 *                            a test file upload POST with a Content-Length of 0. The test upload
		 *                            checks whether the actual file upload will be successful and that server
		 *                            authentication, if required, will succeed. A test upload
		 *                            is only available for Windows players.
		 */
		public function upload(request:URLRequest, uploadDataFieldName:String = "Filedata", testUpload:Boolean = false):void;
	}
}
