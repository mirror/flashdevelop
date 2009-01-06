package flash.events
{
	import flash.events.Event;

	/// The NativeApplication object of an AIR application dispatches a browserInvoke event when the application is invoked as the result of a SWF file in the browser using the browser invocation feature.
	public class BrowserInvokeEvent extends Event
	{
		/// [AIR] The BrowserInvokeEvent.INVOKE constant defines the value of the type property of a BrowserInvokeEvent object.
		public static const BROWSER_INVOKE : String = "browserInvoke";

		/// [AIR] An array of arguments (strings) to pass to the application.
		public function get arguments () : Array;

		/// [AIR] Whether the content in the browser uses the HTTPS URL scheme (true) or not (false).
		public function get isHTTPS () : Boolean;

		/// [AIR] Whether the browser invocation resulted in a user event (such as a mouse click).
		public function get isUserEvent () : Boolean;

		/// [AIR] The sandbox type for the content in the browser.
		public function get sandboxType () : String;

		/// [AIR] The security domain for the content in the browser, such as "www.adobe.com" or "www.example.org".
		public function get securityDomain () : String;

		/// [AIR] The constructor function for the BrowserInvokeEvent class.
		public function BrowserInvokeEvent (type:String, bubbles:Boolean, cancelable:Boolean, arguments:Array, sandboxType:String, securityDomain:String, isHTTPS:Boolean, isUserEvent:Boolean);

		/// [AIR] Creates a new copy of this event.
		public function clone () : Event;
	}
}
