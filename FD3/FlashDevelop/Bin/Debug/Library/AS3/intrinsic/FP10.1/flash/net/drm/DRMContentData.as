package flash.net.drm
{
	import flash.net.drm.VoucherAccessInfo;
	import flash.utils.ByteArray;

	/// The DRMContentData class provides the information required to obtain the voucher necessary to view DRM-protected content.
	public class DRMContentData extends Object
	{
		/// The type of authentication required to obtain a voucher for the associated content.
		public function get authenticationMethod () : String;

		/// The server domain to which the user must be authenticated in order to obtain the voucher for the associated content.
		public function get domain () : String;

		/// A unique id identifying the content associated with this metadata on the media rights server.
		public function get licenseID () : String;

		/// URL of a media rights server that can provide the voucher required to view the associated content.
		public function get serverURL () : String;

		public function DRMContentData (rawData:ByteArray = null);

		public function getVoucherAccessInfo () : Vector.<VoucherAccessInfo>;
	}
}
