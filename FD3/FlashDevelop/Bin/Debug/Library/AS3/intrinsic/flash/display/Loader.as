/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	public class Loader extends DisplayObjectContainer {
		/**
		 * Contains the root display object of the SWF file or image (JPG, PNG, or GIF)
		 *  file that was loaded by using the load() or loadBytes() methods.
		 */
		public function get content():DisplayObject;
		/**
		 * Returns a LoaderInfo object corresponding to the object being loaded. LoaderInfo objects
		 *  are shared between the Loader object and the loaded content object. The LoaderInfo object
		 *  supplies loading progress information and statistics about the loaded file.
		 */
		public function get contentLoaderInfo():LoaderInfo;
		/**
		 * Creates a Loader object that you can use to load files, such as SWF, JPEG, GIF, or PNG files.
		 *  Call the load() method to load the asset as a child of the Loader instance.
		 *  You can then add the Loader object to the display list (for instance, by using the
		 *  addChild() method of a DisplayObjectContainer instance).
		 *  The asset appears on the Stage as it loads.
		 */
		public function Loader();
		/**
		 * Cancels a load() method operation that is currently in progress for the Loader instance.
		 */
		public function close():void;
		/**
		 * Loads a SWF, JPEG, progressive JPEG, unanimated GIF, or PNG file into an object that is a child of
		 *  this Loader object. If you load an animated GIF file, only the first frame is displayed.
		 *  As the Loader object can contain only a single child, issuing a subsequent load()
		 *  request terminates the previous request, if still pending, and commences a new load.
		 *
		 * @param request           <URLRequest> The absolute or relative URL of the SWF, JPEG, GIF, or PNG file to be loaded. A
		 *                            relative path must be relative to the main SWF file. Absolute URLs must include the
		 *                            protocol reference, such as http:// or file:///. Filenames cannot include disk drive
		 *                            specifications.
		 * @param context           <LoaderContext (default = null)> A LoaderContext object, which has properties that define the following:
		 *                            Whether or not to check for the existence of a policy file
		 *                            upon loading the object
		 *                            The ApplicationDomain for the loaded object
		 *                            The SecurityDomain for the loaded object
		 *                            For complete details, see the description of the properties in the
		 *                            LoaderContext class.
		 */
		public function load(request:URLRequest, context:LoaderContext = null):void;
		/**
		 * Loads from binary data stored in a ByteArray object.
		 *
		 * @param bytes             <ByteArray> A ByteArray object. The contents of the ByteArray can be
		 *                            any of the file formats supported by the Loader class: SWF, GIF, JPEG, or PNG.
		 * @param context           <LoaderContext (default = null)> A LoaderContext object. Only the applicationDomain property
		 *                            of the LoaderContext object applies; the checkPolicyFile and securityDomain
		 *                            properties of the LoaderContext object do not apply.
		 */
		public function loadBytes(bytes:ByteArray, context:LoaderContext = null):void;
		/**
		 * Removes a child of this Loader object that was loaded by using the load() method.
		 *  The property of the associated LoaderInfo object is reset to null.
		 *  The child is not necessarily destroyed because other objects might have references to it; however,
		 *  it is no longer a child of the Loader object.
		 */
		public function unload():void;
	}
}
