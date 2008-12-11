package flash.security
{
	/// The SignerTrustSettings class defines constants used with the SignerTrustSettings property of an XMLSignatureValidator object.
	public class SignerTrustSettings
	{
		/// [AIR] The certificate is trusted for signing in general.
		public static const SIGNING:String = "signing";

		/// [AIR] The certificate is trusted for code signing.
		public static const CODE_SIGNING:String = "codeSigning";

		/// [AIR] The certificate is trusted for signing playlists.
		public static const PLAYLIST_SIGNING:String = "playlistSigning";

	}

}

