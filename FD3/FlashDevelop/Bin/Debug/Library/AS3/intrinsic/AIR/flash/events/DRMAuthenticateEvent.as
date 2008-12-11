package flash.events
{
	/// Dispatched when a NetStream object tries to play digital rights management (DRM) encrypted content that requires a user credential for authentication.
	public class DRMAuthenticateEvent extends flash.events.Event
	{
		/// [AIR] The DRMAuthenticateEvent.DRM_AUTHENTICATE constant defines the value of the type property of a drmAuthenticate event object.
		public static const DRM_AUTHENTICATE:String = "drmAuthenticate";

		/// [AIR] The DRMAuthenticateEvent.AUTHENTICATION_TYPE_DRM constant defines the value of the authenticationType property of a drmAuthenticate event object.
		public static const AUTHENTICATION_TYPE_DRM:String = "authenticationTypeDrm";

		/// [AIR] The DRMAuthenticateEvent.AUTHENTICATION_TYPE_PROXY constant defines the value of the authenticationType property of a drmAuthenticate event object.
		public static const AUTHENTICATION_TYPE_PROXY:String = "authenticationTypeProxy";

		/// [AIR] The encrypted content file header provided by the server.
		public var header:String;

		/// [AIR] A prompt for a user name credential, provided by the server.
		public var usernamePrompt:String;

		/// [AIR] A prompt for a password credential, provided by the server.
		public var passwordPrompt:String;

		/// [AIR] A prompt for a URL string, provided by the server.
		public var urlPrompt:String;

		/// [AIR] Indicates whether the supplied credentials are for authenticating against Flash Media Rights Management Server (FMRMS) or a proxy server.
		public var authenticationType:String;

		/// [AIR] The NetStream object that initiated this event.
		public var netstream:flash.net.NetStream;

		/// [AIR] Creates an Event object that contains specific information about DRM authentication events.
		public function DRMAuthenticateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, header:String, userPrompt:String, passPrompt:String, urlPrompt:String, authenticationType:String, netstream:flash.net.NetStream=null);

		/// [AIR] Creates a copy of the DRMAuthenticateEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the DRMAuthenticateEvent object.
		public function toString():String;

	}

}

