package flash.net.drm
{
	import flash.net.drm.DRMPlaybackTimeWindow;

	public class DRMVoucher extends Object
	{
		public function get offlineLeaseEndDate () : Date;

		public function get offlineLeaseStartDate () : Date;

		public function get playbackTimeWindow () : DRMPlaybackTimeWindow;

		public function get policies () : Object;

		public function get voucherEndDate () : Date;

		public function get voucherStartDate () : Date;
	}
}
