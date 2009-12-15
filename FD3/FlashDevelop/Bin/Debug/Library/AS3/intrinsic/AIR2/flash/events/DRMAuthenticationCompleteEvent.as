package flash.events
{
	import flash.utils.ByteArray;
	import flash.events.Event;

	/// An instance of the DRMAuthenticationCompleteEvent class is dispatched when a call to the authenticate() method of the DRMManager object succeeds.
	public class DRMAuthenticationCompleteEvent extends Event
	{
		/// The string constant to use for the authentication complete event in the type parameter when adding and removing event listeners.
		public static const AUTHENTICATION_COMPLETE : String = "authenticationComplete";

		/// The domain of the media rights server.
		public function get domain () : String;
		public function set domain (value:String) : void;

		/// The URL of the media rights server.
		public function get serverURL () : String;
		public function set serverURL (value:String) : void;

		/// The authentication token.
		public function get token () : ByteArray;
		public function set token (value:ByteArray) : void;

		/// Duplicates an instance of an Event subclass.
		public function clone () : Event;

		/// Creates a new instance of a DRMAuthenticationCompleteEvent object.
		public function DRMAuthenticationCompleteEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, inServerURL:String = null, inDomain:String = null, inToken:ByteArray = null);
	}
}
