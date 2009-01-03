package flash.security
{
	/// The RevocationCheckSettings class defines constants used by the revocationCheckSetting property of an XMLSignatureValidator object.
	public class RevocationCheckSettings extends Object
	{
		/// [AIR] Always check certificate revocation.
		public static const ALWAYS_REQUIRED : String;
		/// [AIR] Check certificate revocation, if revocation information is available and the revocation status can be obtained.
		public static const BEST_EFFORT : String;
		/// [AIR] Do not check certificate revocation.
		public static const NEVER : String;
		/// [AIR] Check certificate revocation if the certificate includes revocation information.
		public static const REQUIRED_IF_AVAILABLE : String;
	}
}
