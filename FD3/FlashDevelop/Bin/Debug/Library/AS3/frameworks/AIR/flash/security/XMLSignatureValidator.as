/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.security {
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	public class XMLSignatureValidator extends EventDispatcher {
		/**
		 * The validity status of the cryptographic signature computed over the
		 *  SignedInfo element.
		 */
		public function get digestStatus():String;
		/**
		 * The validity status of the signing certificate.
		 */
		public function get identityStatus():String;
		/**
		 * The validity status of the digest of all the references in the SignedInfo
		 *  element.
		 */
		public function get referencesStatus():String;
		/**
		 * Specifies how certificate revocation is checked.
		 */
		public function get revocationCheckSetting():String;
		public function set revocationCheckSetting(value:String):void;
		/**
		 * The Common Name field of the signing certificate.
		 */
		public function get signerCN():String;
		/**
		 * The Distinguished Name field of the signing certificate.
		 */
		public function get signerDN():String;
		/**
		 * An array containing the Extended Key Usages OIDs listed in the signing certificate.
		 */
		public function get signerExtendedKeyUsages():Array;
		/**
		 * An array containing the trust settings of the signing certificate.
		 */
		public function get signerTrustSettings():Array;
		/**
		 * The IURIDereferencer implementation.
		 */
		public function get uriDereferencer():IURIDereferencer;
		public function set uriDereferencer(value:IURIDereferencer):void;
		/**
		 * Specifies that certificates in the system trust store are used for chain building.
		 */
		public function get useSystemTrustStore():Boolean;
		public function set useSystemTrustStore(value:Boolean):void;
		/**
		 * The validity status of a verified XML signature.
		 */
		public function get validityStatus():String;
		/**
		 * Creates an XMLSignatureValidator object.
		 */
		public function XMLSignatureValidator();
		/**
		 * Adds an x509 certificate for chain building.
		 *
		 * @param cert              <ByteArray> A ByteArray object containing a DER-encoded x509 digital certificate.
		 * @param trusted           <Boolean> Set to true to designate this certificate as a trust anchor.
		 */
		public function addCertificate(cert:ByteArray, trusted:Boolean):*;
		/**
		 * Verifies the specified signature.
		 *
		 * @param signature         <XML> The XML signature to verify.
		 */
		public function verify(signature:XML):void;
	}
}
