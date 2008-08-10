/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.system {
	public class LoaderContext {
		/**
		 * Specifies whether you can use the loadBytes() method of a Loader object
		 *  to load content with executable code, such as a SWF file. With his property set to false
		 *  (the default), the loadBytes() method is restricted to safe operations, such as loading images.
		 */
		public var allowLoadBytesCodeExecution:Boolean = false;
		/**
		 * Specifies the application domain to use for the Loader.load() or
		 *  Loader.loadBytes() method.  Use this property only when loading a SWF file
		 *  written in ActionScript 3.0 (not an image or a SWF file written in ActionScript 1.0 or ActionScript 2.0).
		 */
		public var applicationDomain:ApplicationDomain = null;
		/**
		 * Specifies whether a cross-domain policy file should be loaded from the
		 *  loaded object's server before beginning to load the object itself.  This flag is applicable to
		 *  the Loader.load() method, but not to the Loader.loadBytes() method.
		 */
		public var checkPolicyFile:Boolean = false;
		/**
		 * Specifies the security domain to use for a Loader.load() operation. Use this property
		 *  only when loading a SWF file (not an image).
		 */
		public var securityDomain:SecurityDomain = null;
		/**
		 * Creates a new LoaderContext object, with the specified settings. For complete
		 *  details on these settings, see the descriptions of the properties of this class.
		 *
		 * @param checkPolicyFile   <Boolean (default = false)> Specifies whether a check should be made for the existence of a
		 *                            cross-domain policy file should be checked before loading the object.
		 * @param applicationDomain <ApplicationDomain (default = null)> Specifies the ApplicationDomain object to use for a Loader object.
		 * @param securityDomain    <SecurityDomain (default = null)> Specifies the SecurityDomain object to use for a Loader object.
		 *                            Note: Content in the air application security sandbox cannot load content from
		 *                            other sandboxes into its SecurityDomain.
		 */
		public function LoaderContext(checkPolicyFile:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null);
	}
}
