package flash.net.drm
{
	/// The DRMPlaybackWindow class represents the time period in which a DRM voucher is valid.
	public class DRMPlaybackTimeWindow extends Object
	{
		/// The date on which the playback window ends.
		public function get endDate () : Date;

		/// The time window length in milliseconds.
		public function get period () : uint;

		/// The date on which the playback window started.
		public function get startDate () : Date;

		public function DRMPlaybackTimeWindow ();
	}
}
