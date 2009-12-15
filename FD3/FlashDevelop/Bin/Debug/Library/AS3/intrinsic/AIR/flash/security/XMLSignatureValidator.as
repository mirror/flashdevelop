package flash.security
{
	import flash.events.EventDispatcher;
	import flash.security.IURIDereferencer;
	import flash.utils.IDataInput;
	import flash.security.XMLCanonicalizer;
	import flash.utils.ByteArray;
	import flash.security.CryptContext;
	import flash.security.XMLSignatureEnvelopedTransformer;
	import flash.security.AVMPlusDigest;

	/**
	 * Dispatched if verification cannot complete because of errors.
	 * @eventType flash.events.ErrorEvent.ERROR
	 */
	[Event(name="error", type="flash.events.ErrorEvent")] 

	/**
	 * Dispatched when verification is complete.
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/// The XMLSignatureValidator class validates whether an XML signature file is well formed, unmodified, and, optionally, whether it is signed using a key linked to a trusted digital certificate.
	public class XMLSignatureValidator extends EventDispatcher
	{
		/// The validity status of the cryptographic signature computed over the SignedInfo element.
		public function get digestStatus () : String;

		/// The validity status of the signing certificate.
		public function get identityStatus () : String;

		/// The validity status of the data in the references in the SignedInfo element.
		public function get referencesStatus () : String;

		/// Specifies the conditions under which references are checked.
		public function get referencesValidationSetting () : String;
		public function set referencesValidationSetting (setting:String) : void;

		/// Specifies how certificate revocation is checked.
		public function get revocationCheckSetting () : String;
		public function set revocationCheckSetting (setting:String) : void;

		/// The Common Name field of the signing certificate.
		public function get signerCN () : String;

		/// The Distinguished Name field of the signing certificate.
		public function get signerDN () : String;

		/// An array containing the Extended Key Usages OIDs listed in the signing certificate.
		public function get signerExtendedKeyUsages () : Array;

		/// An array containing the trust settings of the signing certificate.
		public function get signerTrustSettings () : Array;

		/// The IURIDereferencer implementation.
		public function get uriDereferencer () : IURIDereferencer;
		public function set uriDereferencer (uriDerefer:IURIDereferencer) : void;

		/// Specifies that certificates in the system trust store are used for chain building.
		public function get useSystemTrustStore () : Boolean;
		public function set useSystemTrustStore (trusted:Boolean) : void;

		/// The validity status of a verified XML signature.
		public function get validityStatus () : String;

		/// Adds an x509 certificate for chain building.
		public function addCertificate (cert:ByteArray, trusted:Boolean) : *;

		/// Verifies the specified signature.
		public function verify (signature:XML) : void;

		/// Creates an XMLSignatureValidator object.
		public function XMLSignatureValidator ();
	}
}
