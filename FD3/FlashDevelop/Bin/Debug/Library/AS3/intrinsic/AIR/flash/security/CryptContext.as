package flash.security
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;

	public class CryptContext extends EventDispatcher
	{
		public function get signerCN () : String;

		public function get signerDN () : String;

		public function addChainBuildingCertBase64 (cert:String, trusted:Boolean) : void;

		public function addChainBuildingCertRaw (cert:ByteArray, trusted:Boolean) : void;

		public function addCRLRevEvidenceBase64 (crl:String) : void;

		public function addCRLRevEvidenceRaw (crl:ByteArray) : void;

		public function addTimestampingRootRaw (cert:ByteArray) : void;

		public function getDataTBVStatus () : uint;

		public function getIDStatus () : uint;

		public function getIDSummaryFromSigChain (version:uint) : String;

		public function getOverallStatus () : uint;

		public function getRevCheckSetting () : String;

		public function getSignerExtendedKeyUsages () : Array;

		public function getSignerIDSummary (version:uint) : String;

		public function getSignerTrustFlags () : uint;

		public function getSignerTrustSettings () : Array;

		public function getTimestampRevCheckSetting () : String;

		public function getUseSystemTrustStore () : Boolean;

		public function HasValidVerifySession () : Boolean;

		public function setRevCheckSetting (setting:String) : void;

		public function setSignerCert (cert:String) : *;

		public function setSignerCertDN (dn:String) : *;

		public function setTimestampRevCheckSetting (setting:String) : void;

		public function useCodeSigningValidationRules () : void;

		public function useSystemTrustStore (trusted:Boolean) : void;

		public function VerifySigASync (sig:String, data:String) : void;

		public function VerifySigSync (sig:String, data:String) : void;

		public function verifyTimestamp (tsp:String, data:String) : void;
	}
}
