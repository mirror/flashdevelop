package flash.net.drm
{
	/// The LoadVoucherSetting class provides string constants enumerating the options to use with the DRMManager settings parameter of the loadVoucher() method.
	public class LoadVoucherSetting extends Object
	{
		/// Load the voucher from the local cache, if possible.
		public static const ALLOW_SERVER : String;
		/// Download the voucher from the media rights server only.
		public static const FORCE_REFRESH : String;
		/// Load the voucher from the local cache only.
		public static const LOCAL_ONLY : String;

		public function LoadVoucherSetting ();
	}
}
