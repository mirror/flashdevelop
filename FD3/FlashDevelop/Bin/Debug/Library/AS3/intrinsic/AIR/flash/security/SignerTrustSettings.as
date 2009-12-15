package flash.security
{
	/// The SignerTrustSettings class defines constants used with the SignerTrustSettings property of an XMLSignatureValidator object.
	public class SignerTrustSettings extends Object
	{
		/// [AIR] The certificate is trusted for code signing.
		public static const CODE_SIGNING : String;
		/// [AIR] The certificate is trusted for signing playlists.
		public static const PLAYLIST_SIGNING : String;
		/// [AIR] The certificate is trusted for signing in general.
		public static const SIGNING : String;

		public function SignerTrustSettings ();
	}
}
