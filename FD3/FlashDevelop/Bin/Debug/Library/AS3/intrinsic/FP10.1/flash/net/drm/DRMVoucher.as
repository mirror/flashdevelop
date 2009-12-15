package flash.net.drm
{
	import flash.net.drm.DRMPlaybackTimeWindow;

	/// The DRMVoucher class represents a license token that allows a user to view DRM-protected content.
	public class DRMVoucher extends Object
	{
		/// The date on which this voucher expires for offline playback.
		public function get offlineLeaseEndDate () : Date;

		/// The date on which this voucher becomes valid for offline playback.
		public function get offlineLeaseStartDate () : Date;

		/// The time period, after first view, in which the related content can be viewed or reviewed.
		public function get playbackTimeWindow () : DRMPlaybackTimeWindow;

		/// A dynamic Object reporting application-defined policies.
		public function get policies () : Object;

		/// The date on which this voucher expires.
		public function get voucherEndDate () : Date;

		/// The beginning of this voucher's validity period.
		public function get voucherStartDate () : Date;

		public function DRMVoucher ();
	}
}
