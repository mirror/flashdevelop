package flash.events
{
	import flash.utils.ByteArray;
	import flash.events.Event;

	public class DRMAuthenticationCompleteEvent extends Event
	{
		public static const AUTHENTICATION_COMPLETE : String = "authenticationComplete";

		public function get domain () : String;
		public function set domain (value:String) : void;

		public function get serverURL () : String;
		public function set serverURL (value:String) : void;

		public function get token () : ByteArray;
		public function set token (value:ByteArray) : void;

		public function clone () : Event;

		public function DRMAuthenticationCompleteEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, inServerURL:String = null, inDomain:String = null, inToken:ByteArray = null);
	}
}
