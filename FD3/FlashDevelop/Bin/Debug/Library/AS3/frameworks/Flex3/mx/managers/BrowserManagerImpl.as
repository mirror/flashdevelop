package mx.managers
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import mx.core.ApplicationGlobals;
	import mx.events.BrowserChangeEvent;

	/**
	 *  Dispatched when the fragment property is changed either
 *  by the user interacting with the browser, invoking an
 *  application in Apollo
 *  or by code setting the property.
 *
 *  @eventType mx.events.BrowserChangeEvent.URL_CHANGE
	 */
	[Event(name="urlChange", type="flash.events.Event")] 

	/**
	 *  Dispatched when the fragment property is changed
 *  by the browser.
 *
 *  @eventType mx.events.BrowserChangeEvent.BROWSER_URL_CHANGE
	 */
	[Event(name="browserURLChange", type="mx.events.BrowserChangeEvent")] 

	/**
	 *  Dispatched when the fragment property is changed
 *  by the application via setFragment
 *
 *  @eventType mx.events.BrowserChangeEvent.APPLICATION_URL_CHANGE
	 */
	[Event(name="applicationURLChange", type="mx.events.BrowserChangeEvent")] 

include "../core/Version.as"
	/**
	 *  @private
 *  The BrowserManager is a Singleton manager that acts as
 *  a proxy between the browser and the application.
 *  It provides access to the URL in the browser address
 *  bar similar to accessing document.location in Javascript.
 *  Events are dispatched as the url property is changed. 
 *  Listeners can then respond, alter the url, and/or block others
 *  from getting the event. 
 * 
 *  For desktop applications, the BrowserManager
 *  provides access to the command-line parameters used to
 *  invoke the application.  The url property will be the concatenated
 *  string representing all of the command-line parameters separated
 *  by semi-colons.
 *
	 */
	public class BrowserManagerImpl extends EventDispatcher implements IBrowserManager
	{
		/**
		 *  @private
		 */
		private static var instance : IBrowserManager;
		private var _defaultFragment : String;
		private var _browserUserAgent : String;
		private var _browserPlatform : String;
		private var _isFirefoxMac : Boolean;
		private var browserMode : Boolean;
		private var _base : String;
		private var _fragment : String;
		private var _title : String;
		private var _url : String;

		/**
		 *  The portion of current URL before the '#' as it appears 
     *  in the browser address bar.
		 */
		public function get base () : String;

		/**
		 *  The portion of current URL after the '#' as it appears 
     *  in the browser address bar, or the default fragment
	 *  used in setup() if there is nothing after the '#'.  
	 *  Use setFragment to change this value.
		 */
		public function get fragment () : String;

		/**
		 *  The title of the app as it should appear in the
     *  browser history
		 */
		public function get title () : String;

		/**
		 *  The current URL as it appears in the browser address bar.
		 */
		public function get url () : String;

		/**
		 *  @private
		 */
		public static function getInstance () : IBrowserManager;

		/**
		 *  Constructor.
		 */
		public function BrowserManagerImpl ();

		/**
		 *  Initialize the BrowserManager.  The BrowserManager will get the initial URL.  If it
     *  has a fragment, it will dispatch BROWSER_URL_CHANGE, so add your event listener
	 *  before calling this method.
     *
     *  @param defaultFragment the fragment to use if no fragment in the initial URL.
     *  @param defaultTitle the title to use if no fragment in the initial URL.
		 */
		public function init (defaultFragment:String = "", defaultTitle:String = "") : void;

		/**
		 *  Initialize the BrowserManager.  The HistoryManager calls this method to
	 *  prepare the BrowserManager for further calls from the HistoryManager.  Use
	 *  of HistoryManager and setFragment calls from the application is
	 *  not supported, so the init() method sets 
	 *  Application.application.historyManagementEnabled to false to disable
	 *  the HistoryManager
		 */
		public function initForHistoryManager () : void;

		private function setup (defaultFragment:String, defaultTitle:String) : void;

		/**
		 *  Change the fragment of the url after the '#' in the browser.
     *  An attempt will be made to track this URL in the browser's
     *  history.
     *
     *  If the title is set, the old title in the browser is replaced
     *  by the new title.
     *
     *  To actually store the URL, a JavaScript
     *  method named setBrowserURL() will be called.
     *  The application's HTML wrapper must have that method which
     *  must implement a mechanism for taking this
     *  value and registering it with the browser's history scheme
     *  and address bar.
     *
     *  When set, the APPLICATION_URL_CHANGE event is sent.  If the event
     *  is cancelled the setBrowserURL() will not be called.
		 */
		public function setFragment (value:String) : void;

		/**
		 *  Change the title in the browser.
     *  Does not affect the browser's
     *  history.
		 */
		public function setTitle (value:String) : void;

		/**
		 *  @private
     *  Callback from browser when the URL has been changed
     *  in the browser.
		 */
		private function browserURLChangeBrowser (fragment:String) : void;

		private function browserURLChange (fragment:String, force:Boolean = false) : void;

		private function sandboxBrowserManagerHandler (event:Event) : void;

		private function debugTrace (s:String) : void;
	}
}
