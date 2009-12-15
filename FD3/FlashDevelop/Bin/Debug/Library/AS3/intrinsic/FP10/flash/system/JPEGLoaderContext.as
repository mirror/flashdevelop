package flash.system
{
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;

	/// JPEGLoaderContext class includes a property for enabling a deblocking filter when loading a JPEG image.
	public class JPEGLoaderContext extends LoaderContext
	{
		/// Specifies the strength of the deblocking filter.
		public var deblockingFilter : Number;

		/// Creates a new JPEGLoaderContext object, with the specified settings.
		public function JPEGLoaderContext (deblockingFilter:Number = 0, checkPolicyFile:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null);
	}
}
