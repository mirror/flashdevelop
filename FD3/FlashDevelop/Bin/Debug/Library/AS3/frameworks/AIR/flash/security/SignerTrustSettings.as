/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.security {
	public final  class SignerTrustSettings {
		/**
		 * The certificate is trusted for code signing. This implies that
		 *  the certificate chains to a trusted root, the root is trusted for
		 *  code signing, and the signing certificate has the CodeSigning
		 *  OID in its Extended Key Usage extension.
		 */
		public static const CODE_SIGNING:String = "codeSigning";
		/**
		 * The certificate is trusted for signing playlists. This implies that
		 *  the certificate chains to a trusted root and has the
		 *  playlist signing OID in its Extended Key Usage extension.
		 */
		public static const PLAYLIST_SIGNING:String = "playlistSigning";
		/**
		 * The certificate is trusted for signing in general.
		 */
		public static const SIGNING:String = "signing";
	}
}
