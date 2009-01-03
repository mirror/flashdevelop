package flash.net.drm
{
	import flash.net.drm.DRMContentData;

	public class DRMVoucherStoreContext extends DRMManagerSession
	{
		public function checkStatus () : uint;

		public function getVoucherFromStore (inMetadata:DRMContentData) : void;

		public function onSessionComplete () : void;

		public function onSessionError () : void;
	}
}
