/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class BrowserInvokeEvent extends Event {
		/**
		 * An array of arguments (strings) to pass to the application.
		 */
		public function get arguments():Array;
		/**
		 * Whether the content in the browser uses the https
		 *  URL scheme (true) or not (false).
		 */
		public function get isHTTPS():Boolean;
		/**
		 * Whether the browser invocation resulted in a user event (such as
		 *  a mouse click). In AIR 1.0, this is always set to true;
		 *  AIR requires a user event to initiate a call to the browser invocation feature.
		 */
		public function get isUserEvent():Boolean;
		/**
		 * The sandbox type for the content in the browser. This can be set
		 *  to one of the following values:
		 *  Security.APPLICATION - The content is in
		 *  the application security sandbox.
		 *  Security.LOCAL_TRUSTED - The content is in
		 *  the local-trusted security sandbox.
		 *  Security.LOCAL_WITH_FILE - The content is in
		 *  the local-with-filesystem security sandbox.
		 *  Security.LOCAL_WITH_NETWORK - The content is in
		 *  the local-with-networking security sandbox.
		 *  Security.REMOTE - The content is in
		 *  a remote (network) domain
		 */
		public function get sandboxType():String;
		/**
		 * The security domain for the content in the browser, such as
		 *  "www.adobe.com" or "www.example.org".
		 *  This property is set only for content in the remote security
		 *  sandbox (for content from a network domain), not for content
		 *  in a local or application security sandbox.
		 */
		public function get securityDomain():String;
		/**
		 * The constructor function for the BrowserInvokeEvent class.
		 *  Generally, developers do not call the BrowserInvokeEvent() constructor directly.
		 *  Only the runtime should create a BrowserInvokeEvent object.
		 *
		 * @param type              <String> The type of the event, accessible as Event.type.
		 * @param bubbles           <Boolean> Set to false for a BrowserInvokeEvent object.
		 * @param cancelable        <Boolean> Set to false for a BrowserInvokeEvent object.
		 * @param arguments         <Array> An array of arguments (strings) to pass to the application.
		 * @param sandboxType       <String> The sandbox type for the content in the browser.
		 * @param securityDomain    <String> The security domain for the content in the browser.
		 * @param isHTTPS           <Boolean> Whether the content in the browser uses the https URL scheme.
		 * @param isUserEvent       <Boolean> Whether the browser invocation was the result of a user event.
		 */
		public function BrowserInvokeEvent(type:String, bubbles:Boolean, cancelable:Boolean, arguments:Array, sandboxType:String, securityDomain:String, isHTTPS:Boolean, isUserEvent:Boolean);
		/**
		 * Creates a new copy of this event.
		 *
		 * @return                  <Event> The copy of the event.
		 */
		public override function clone():Event;
		/**
		 * The  constant defines the value of the type
		 *  property of a BrowserInvokeEvent object.
		 */
		public static const BROWSER_INVOKE:String = "browserInvoke";
	}
}
