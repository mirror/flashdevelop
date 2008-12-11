package flash.security
{
	/// The RevocationCheckSettings class defines constants used by the revocationCheckSetting property of an XMLSignatureValidator object.
	public class RevocationCheckSettings
	{
		/// [AIR] Do not check certificate revocation.
		public static const NEVER:String = "never";

		/// [AIR] Check certificate revocation, if revocation information is available and the revocation status can be obtained.
		public static const BEST_EFFORT:String = "bestEffort";

		/// [AIR] Check certificate revocation if the certificate includes revocation information.
		public static const REQUIRED_IF_AVAILABLE:String = "requiredIfAvailable";

		/// [AIR] Always check certificate revocation.
		public static const ALWAYS_REQUIRED:String = "alwaysRequired";

	}

}

