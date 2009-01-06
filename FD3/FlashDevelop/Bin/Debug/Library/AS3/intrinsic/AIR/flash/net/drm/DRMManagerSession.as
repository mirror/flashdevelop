package flash.net.drm
{
	import flash.events.EventDispatcher;
	import flash.net.drm.DRMContentData;
	import flash.net.drm.DRMVoucher;
	import flash.utils.ByteArray;

	public class DRMManagerSession extends EventDispatcher
	{
		public var m_isInSession : Boolean;

		public function get metadata () : DRMContentData;
		public function set metadata (inData:DRMContentData) : void;

		public function checkStatus () : uint;

		public function DRMManagerSession ();

		public function getLastError () : uint;

		public function getLastSubErrorID () : uint;

		public function issueDRMErrorEvent (metadata:DRMContentData, errorID:int, subErrorID:int) : void;

		public function issueDRMStatusEvent (inMetadata:DRMContentData, voucher:DRMVoucher, availableOffline:Boolean) : *;

		public function onSessionComplete () : void;

		public function onSessionError () : void;

		public function setMetadata (newMetadata:ByteArray) : void;

		public function setTimerUp () : void;
	}
}
