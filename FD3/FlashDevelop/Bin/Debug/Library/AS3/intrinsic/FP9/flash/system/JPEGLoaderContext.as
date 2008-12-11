package flash.system
{
	public class JPEGLoaderContext extends flash.system.LoaderContext
	{
		public var deblockingFilter:Number;

		public function JPEGLoaderContext(deblockingFilter:Number=0.0, checkPolicyFile:Boolean=false, applicationDomain:flash.system.ApplicationDomain=null, securityDomain:flash.system.SecurityDomain=null);

	}

}

