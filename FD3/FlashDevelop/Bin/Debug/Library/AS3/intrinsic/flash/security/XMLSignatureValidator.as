package flash.security
{
	/// The XMLSignatureValidator class validates whether an XML signature file is well formed, unmodified, and, optionally, whether it is signed using a key linked to a trusted digital certificate.
	public class XMLSignatureValidator extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Dispatched if verification cannot complete because of errors.
		 * @eventType flash.events.ErrorEvent.ERROR
		 */
		[Event(name="error", type="flash.events.ErrorEvent")]

		/** 
		 * [AIR] Dispatched when verification is complete.
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/// [AIR] The IURIDereferencer implementation.
		public var uriDereferencer:flash.security.IURIDereferencer;

		/// [AIR] Specifies that certificates in the system trust store are used for chain building.
		public var useSystemTrustStore:Boolean;

		/// [AIR] Specifies how certificate revocation is checked.
		public var revocationCheckSetting:String;

		/// [AIR] The validity status of the digest of all the references in the SignedInfo element.
		public var referencesStatus:String;

		/// [AIR] The validity status of the cryptographic signature computed over the SignedInfo element.
		public var digestStatus:String;

		/// [AIR] The validity status of the signing certificate.
		public var identityStatus:String;

		/// [AIR] The validity status of a verified XML signature.
		public var validityStatus:String;

		/// [AIR] An array containing the trust settings of the signing certificate.
		public var signerTrustSettings:Array;

		/// [AIR] An array containing the Extended Key Usages OIDs listed in the signing certificate.
		public var signerExtendedKeyUsages:Array;

		/// [AIR] The Common Name field of the signing certificate.
		public var signerCN:String;

		/// [AIR] The Distinguished Name field of the signing certificate.
		public var signerDN:String;

		/// [AIR] Creates an XMLSignatureValidator object.
		public function XMLSignatureValidator();

		/// [AIR] Adds an x509 certificate for chain building.
		public function addCertificate(cert:flash.utils.ByteArray, trusted:Boolean):void;

		/// [AIR] Verifies the specified signature.
		public function verify(signature:XML):void;

	}

}

