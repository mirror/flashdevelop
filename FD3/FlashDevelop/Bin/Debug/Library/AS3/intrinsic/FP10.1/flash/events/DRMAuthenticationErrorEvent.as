package flash.events
{
	import flash.events.Event;

	/// An instance of the DRMAuthenticationErrorEvent class is dispatched when a call to the authenticate() method of the DRMManager object fails.
	public class DRMAuthenticationErrorEvent extends ErrorEvent
	{
		/// The string constant to use for the authentication error event in the type parameter when adding and removing event listeners.
		public static const AUTHENTICATION_ERROR : String = "authenticationError";

		/// The media rights server domain.
		public function get domain () : String;
		public function set domain (value:String) : void;

		/// The URL of the media rights server that rejected the authentication attempt.
		public function get serverURL () : String;
		public function set serverURL (value:String) : void;

		/// A more detailed error code.
		public function get subErrorID () : int;
		public function set subErrorID (value:int) : void;

		/// Creates a copy of the ErrorEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Creates a new instance of a DRMAuthenticationErrorEvent object.
		public function DRMAuthenticationErrorEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, inDetail:String = "", inErrorID:int = 0, inSubErrorID:int = 0, inServerURL:String = null, inDomain:String = null);
	}
}
