package flash.net.drm
{
	import flash.utils.ByteArray;

	public class DRMContentData extends Object
	{
		public function get authenticationMethod () : String;

		public function get domain () : String;

		public function get licenseID () : String;

		public function get serverURL () : String;

		public function DRMContentData ();
	}
}
