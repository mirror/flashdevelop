package flash.net.drm
{
	import flash.events.EventDispatcher;
	import flash.net.drm.DRMManager;
	import flash.events.DRMStatusEvent;
	import flash.events.DRMErrorEvent;
	import flash.net.drm.DRMContentData;
	import flash.net.drm.DRMVoucher;
	import flash.utils.ByteArray;
	import flash.events.DRMAuthenticationCompleteEvent;
	import flash.events.DRMAuthenticationErrorEvent;

	public class DRMManager extends EventDispatcher
	{
		public function authenticate (serverURL:String, domain:String, username:String, password:String) : void;

		public function DRMManager ();

		public static function getDRMManager () : DRMManager;

		public function loadVoucher (contentData:DRMContentData, setting:String) : void;

		public function resetDRMVouchers () : void;

		public function setAuthenticationToken (serverUrl:String, domain:String, token:ByteArray) : void;
	}
}
