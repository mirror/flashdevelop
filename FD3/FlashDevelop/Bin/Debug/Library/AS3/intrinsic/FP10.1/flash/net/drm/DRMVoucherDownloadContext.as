package flash.net.drm
{
	import flash.net.drm.DRMContentData;
	import flash.net.drm.DRMVoucher;

	public class DRMVoucherDownloadContext extends DRMManagerSession
	{
		public function get voucher () : DRMVoucher;

		public function checkStatus () : uint;

		public function download (inMetadata:DRMContentData, previewVoucher:Boolean = false) : void;

		public function DRMVoucherDownloadContext ();

		public function onSessionComplete () : void;

		public function onSessionError () : void;
	}
}
