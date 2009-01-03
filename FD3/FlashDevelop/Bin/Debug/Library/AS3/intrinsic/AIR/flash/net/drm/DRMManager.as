package flash.net.drm
{
	import flash.events.EventDispatcher;
	import flash.net.drm.DRMManager;
	import flash.net.drm.DRMContentData;
	import flash.utils.ByteArray;

	public class DRMManager extends EventDispatcher
	{
		public function authenticate (serverURL:String, domain:String, username:String, password:String) : void;

		public static function getDRMManager () : DRMManager;

		public function loadVoucher (contentData:DRMContentData, setting:String) : void;

		public function resetDRMVouchers () : void;

		public function setAuthenticationToken (serverUrl:String, domain:String, token:ByteArray) : void;
	}
}
