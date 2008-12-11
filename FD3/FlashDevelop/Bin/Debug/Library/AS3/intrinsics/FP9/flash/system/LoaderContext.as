package flash.system
{
	/// The LoaderContext class provides options for loading SWF files and other media by using the Loader class.
	public class LoaderContext
	{
		/// Specifies whether Flash Player should attempt to download a URL policy file from the loaded object's server before beginning to load the object itself.
		public var checkPolicyFile:Boolean;

		/// Specifies the application domain to use for the Loader.load() or Loader.loadBytes() method.
		public var applicationDomain:flash.system.ApplicationDomain;

		/// Specifies the security domain to use for a Loader.load() operation.
		public var securityDomain:flash.system.SecurityDomain;

		/// Creates a new LoaderContext object, with the specified settings.
		public function LoaderContext(checkPolicyFile:Boolean=false, applicationDomain:flash.system.ApplicationDomain=null, securityDomain:flash.system.SecurityDomain=null);

	}

}

