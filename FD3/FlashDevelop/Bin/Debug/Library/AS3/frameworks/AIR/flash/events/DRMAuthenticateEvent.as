/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	import flash.net.NetStream;
	public class DRMAuthenticateEvent extends Event {
		/**
		 * Indicates whether the supplied credentials are for authenticating against Flash Media Rights Management Server (FMRMS)
		 *  or a proxy server. For example, the "proxy" option allows the application to authenticate against a proxy server
		 *  if an enterprise requires such a step before the user can access the Internet. Unless anonymous authentication is used,
		 *  after the proxy authentication, the user still needs to authenticate against FMRMS in order to obtain the voucher
		 *  and play the content. You can use setDRMAuthenticationcredentials() a second time, with "drm"
		 *  option, to authenticate against FMRMS.
		 */
		public function get authenticationType():String;
		/**
		 * The encrypted content file header provided by the server.
		 *  It contains information about the context of the encrypted content.
		 */
		public function get header():String;
		/**
		 * The NetStream object that initiated this event.
		 */
		public function get netstream():NetStream;
		/**
		 * A prompt for a password credential, provided by the server.
		 *  The string can include instruction for the type of password required.
		 */
		public function get passwordPrompt():String;
		/**
		 * A prompt for a URL string, provided by the server.
		 *  The string can provide the location where the username and password will be sent.
		 */
		public function get urlPrompt():String;
		/**
		 * A prompt for a user name credential, provided by the server.
		 *  The string can include instruction for the type of user name required.
		 *  For example, a content provider may require an e-mail address as the user name.
		 */
		public function get usernamePrompt():String;
		/**
		 * Creates an Event object that contains specific information about DRM authentication events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of DRMAuthenticate event: DRMAuthenticateEvent.DRM_AUTHENTICATE.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param header            <String (default = "")> The encrypted content file header provided by the server.
		 * @param userPrompt        <String (default = "")> A prompt for a user name credential, provided by the server.
		 * @param passPrompt        <String (default = "")> A prompt for a password credential, provided by the server.
		 * @param urlPrompt         <String (default = "")> A prompt for a URL to display, provided by the server.
		 * @param authenticationType<String (default = "")> Indicates whether the supplied credentials are for authenticating against the Flash Media Rights Management Server (FMRMS) or a proxy server.
		 * @param netstream         <NetStream (default = null)> The NetStream object that initiated this event.
		 */
		public function DRMAuthenticateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, header:String = "", userPrompt:String = "", passPrompt:String = "", urlPrompt:String = "", authenticationType:String = "", netstream:NetStream = null);
		/**
		 * Creates a copy of the DRMAuthenticateEvent object and sets the value of each property to match
		 *  that of the original.
		 *
		 * @return                  <Event> A new DRMAuthenticateEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the DRMAuthenticateEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the DRMAuthenticateEvent object.
		 */
		public override function toString():String;
		/**
		 * The DRMAuthenticateEvent.AUTHENTICATION_TYPE_DRM constant defines the value of the
		 *  authenticationType property of a drmAuthenticate event object.
		 */
		public static const AUTHENTICATION_TYPE_DRM:String = "drm";
		/**
		 * The DRMAuthenticateEvent.AUTHENTICATION_TYPE_PROXY constant defines the value of the
		 *  authenticationType property of a drmAuthenticate event object.
		 */
		public static const AUTHENTICATION_TYPE_PROXY:String = "proxy";
		/**
		 * The DRMAuthenticateEvent.DRM_AUTHENTICATE constant defines the value of the
		 *  type property of a drmAuthenticate event object.
		 */
		public static const DRM_AUTHENTICATE:String = "drmAuthenticate";
	}
}
