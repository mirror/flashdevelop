package flash.events
{
	import flash.events.Event;

	public class DRMAuthenticationErrorEvent extends ErrorEvent
	{
		public static const AUTHENTICATION_ERROR : String = "authenticationError";

		public function get domain () : String;
		public function set domain (value:String) : void;

		public function get serverURL () : String;
		public function set serverURL (value:String) : void;

		public function get subErrorID () : int;
		public function set subErrorID (value:int) : void;

		public function clone () : Event;
	}
}
