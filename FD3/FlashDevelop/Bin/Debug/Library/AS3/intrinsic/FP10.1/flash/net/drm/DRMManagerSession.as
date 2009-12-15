package flash.net.drm
{
	import flash.events.EventDispatcher;
	import flash.net.drm.DRMContentData;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.net.drm.DRMVoucher;

	public class DRMManagerSession extends EventDispatcher
	{
		public var m_isInSession : Boolean;

		public function get metadata () : DRMContentData;
		public function set metadata (inData:DRMContentData) : void;

		public function checkStatus () : uint;

		public function DRMManagerSession ();

		public function errorCodeToThrow (errorCode:uint) : void;

		public function getLastError () : uint;

		public function getLastSubErrorID () : uint;

		public function issueDRMErrorEvent (metadata:DRMContentData, errorID:int, subErrorID:int) : void;

		public function issueDRMStatusEvent (inMetadata:DRMContentData, voucher:DRMVoucher) : *;

		public function onSessionComplete () : void;

		public function onSessionError () : void;

		public function setTimerUp () : void;
	}
}
