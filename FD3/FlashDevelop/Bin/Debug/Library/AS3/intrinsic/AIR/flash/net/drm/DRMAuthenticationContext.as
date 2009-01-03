package flash.net.drm
{
	import flash.utils.ByteArray;

	public class DRMAuthenticationContext extends DRMManagerSession
	{
		public function get authenticationToken () : ByteArray;

		public function authenticate (url:String, domain:String, username:String, password:String) : void;

		public function checkStatus () : uint;

		public function onSessionComplete () : void;

		public function onSessionError () : void;
	}
}
