package flash.net.drm
{
	import flash.net.drm.DRMContentData;
	import flash.net.drm.DRMVoucher;

	public class DRMVoucherStoreContext extends DRMManagerSession
	{
		public function get voucher () : DRMVoucher;

		public function checkStatus () : uint;

		public function DRMVoucherStoreContext ();

		public function getVoucherFromStore (inMetadata:DRMContentData) : void;

		public function onSessionComplete () : void;

		public function onSessionError () : void;
	}
}
