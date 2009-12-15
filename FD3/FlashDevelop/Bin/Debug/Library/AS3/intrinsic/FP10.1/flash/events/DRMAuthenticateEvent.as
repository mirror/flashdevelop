package flash.events
{
	import flash.net.NetStream;
	import flash.events.Event;

	/// Dispatched when a NetStream object tries to play digital rights management (DRM) encrypted content that requires a user credential for authentication.
	public class DRMAuthenticateEvent extends Event
	{
		/// The DRMAuthenticateEvent.AUTHENTICATION_TYPE_DRM constant defines the value of the authenticationType property of a DRMAuthenticateEvent object.
		public static const AUTHENTICATION_TYPE_DRM : String = "authenticationTypeDrm";
		/// The DRMAuthenticateEvent.AUTHENTICATION_TYPE_PROXY constant defines the value of the authenticationType property of a DRMAuthenticateEvent object.
		public static const AUTHENTICATION_TYPE_PROXY : String = "authenticationTypeProxy";
		/// The DRMAuthenticateEvent.DRM_AUTHENTICATE constant defines the value of the type property of a DRMAuthenticateEvent object.
		public static const DRM_AUTHENTICATE : String = "drmAuthenticate";

		/// Indicates whether the supplied credentials are for authenticating against Flash Media Rights Management Server (FMRMS) or a proxy server.
		public function get authenticationType () : String;

		/// The encrypted content file header provided by the server.
		public function get header () : String;

		/// The NetStream object that initiated this event.
		public function get netstream () : NetStream;

		/// A prompt for a password credential, provided by the server.
		public function get passwordPrompt () : String;

		/// A prompt for a URL string, provided by the server.
		public function get urlPrompt () : String;

		/// A prompt for a user name credential, provided by the server.
		public function get usernamePrompt () : String;

		/// Creates a copy of the DRMAuthenticateEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Creates an Event object that contains specific information about DRM authentication events.
		public function DRMAuthenticateEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, header:String = "", userPrompt:String = "", passPrompt:String = "", urlPrompt:String = "", authenticationType:String = "", netstream:NetStream = null);

		/// Returns a string that contains all the properties of the DRMAuthenticateEvent object.
		public function toString () : String;
	}
}
