/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.security {
	public final  class RevocationCheckSettings {
		/**
		 * Always check certificate revocation. Certificates without revocation information are rejected.
		 */
		public static const ALWAYS_REQUIRED:* = alwaysRequired;
		/**
		 * Check certificate revocation, if revocation information is available and the revocation status
		 *  can be obtained. If revocation status cannot be positively determined, the certificate is not rejected.
		 */
		public static const BEST_EFFORT:* = bestEffort;
		/**
		 * Do not check certificate revocation.
		 */
		public static const NEVER:* = never;
		/**
		 * Check certificate revocation if the certificate includes revocation information. If the information
		 *  is available, but revocation status cannot be positively determined, the certificate is rejected.
		 */
		public static const REQUIRED_IF_AVAILABLE:* = requiredIfInfoAvailable;
	}
}
