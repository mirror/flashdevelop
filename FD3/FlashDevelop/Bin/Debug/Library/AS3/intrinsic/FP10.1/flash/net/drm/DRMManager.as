package flash.net.drm
{
	import flash.events.EventDispatcher;
	import flash.net.drm.DRMManager;
	import flash.utils.ByteArray;
	import flash.net.drm.DRMContentData;
	import flash.events.DRMAuthenticationCompleteEvent;
	import flash.events.DRMAuthenticationErrorEvent;
	import flash.events.DRMStatusEvent;
	import flash.events.DRMErrorEvent;
	import flash.net.drm.DRMVoucher;

	/// The DRMManager manages the retrieval and storage of the vouchers needed to view DRM-protected content.
	public class DRMManager extends EventDispatcher
	{
		/// Authenticates a user.
		public function authenticate (serverURL:String, domain:String, username:String, password:String) : void;

		public function DRMManager ();

		/// Returns an instance of the singleton DRMManager object.
		public static function getDRMManager () : DRMManager;

		public function loadPreviewVoucher (contentData:DRMContentData) : void;

		/// Loads a voucher from a media rights server or the local voucher cache.
		public function loadVoucher (contentData:DRMContentData, setting:String) : void;

		/// Deletes all locally cached digital rights management (DRM) voucher data.
		public function resetDRMVouchers () : void;

		/// Sets the authentication token to use for communication with the specified server and domain.
		public function setAuthenticationToken (serverUrl:String, domain:String, token:ByteArray) : void;
	}
}
