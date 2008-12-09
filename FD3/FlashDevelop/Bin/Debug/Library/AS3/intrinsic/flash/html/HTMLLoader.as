package flash.html
{
	/// The HTMLLoader class defines a type of display object that is a container for HTML content.
	public class HTMLLoader extends flash.display.Sprite
	{
		/** 
		 * [AIR] Signals that the HTML DOM has been created in response to a load operation.
		 * @eventType flash.events.Event.HTML_DOM_INITIALIZE
		 */
		[Event(name="htmlDOMInitialize", type="flash.events.Event")]

		/** 
		 * [AIR] Signals that an uncaught JavaScript exception occurred in the HTMLLoader object.
		 * @eventType flash.events.HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION
		 */
		[Event(name="uncaughtScriptException", type="flash.events.HTMLUncaughtScriptExceptionEvent")]

		/** 
		 * [AIR] Signals that the scrollH or scrollV property has been changed by the HTMLLoader object.
		 * @eventType flash.events.Event.SCROLL
		 */
		[Event(name="scroll", type="flash.events.Event")]

		/** 
		 * [AIR] Signals that one or both of the contentWidth and contentHeight properties of the HTMLLoader object has changed.
		 * @eventType flash.events.Event.HTML_BOUNDS_CHANGE
		 */
		[Event(name="htmlBoundsChange", type="flash.events.Event")]

		/** 
		 * [AIR] Signals that the location property of the HTMLLoader object has changed.
		 * @eventType flash.events.Event.LOCATION_CHANGE
		 */
		[Event(name="locationChange", type="flash.events.Event")]

		/** 
		 * [AIR] Signals that the rendering of content in the HTMLLoader object is fully up to date.
		 * @eventType flash.events.Event.HTML_RENDER
		 */
		[Event(name="htmlRender", type="flash.events.Event")]

		/** 
		 * [AIR] Signals that the last load operation requested by loadString or load method has completed.
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/// [AIR] Indicates whether the JavaScript load event corresponding to the previous call to the load() or loadString() method has been delivered to the HTML DOM in the HTMLLoader object.
		public var loaded:Boolean;

		/// [AIR] The URL for the content loaded in the HTMLLoader object.
		public var location:String;

		/// [AIR] The width, in pixels, of the HTML content.
		public var contentWidth:Number;

		/// [AIR] The height, in pixels, of the HTML content.
		public var contentHeight:Number;

		/// [AIR] Specifies the width of the rectangle of the HTML canvas that is being rendered.
		public var width:Number;

		/// [AIR] Specifies the height of the rectangle of the HTML canvas that is being rendered.
		public var height:Number;

		/// [AIR] The horizontal scroll position of the HTML content in the HTMLLoader object.
		public var scrollH:Number;

		/// [AIR] The vertical scroll position of the HTML content in the HTMLLoader object.
		public var scrollV:Number;

		/// [AIR] The global JavaScript object for the content loaded into the HTML control.
		public var window:Object;

		/// [AIR] The application domain to use for the window.runtime object in JavaScript in the HTML page.
		public var runtimeApplicationDomain:flash.system.ApplicationDomain;

		/// [AIR] The user agent string to be used in any upcoming content requests from this HTMLLoader object.
		public var userAgent:String;

		/// [AIR] Specifies whether the HTTP protocol stack should manage cookies for this object.
		public var manageCookies:Boolean;

		/// [AIR] Specifies whether the local cache should be consulted before HTTP requests issued by this object fetch data.
		public var useCache:Boolean;

		/// [AIR] Specifies whether successful response data should be cached for HTTP requests issued by this object.
		public var cacheResponse:Boolean;

		/// [AIR] Specifies whether authentication requests should be handled (true) or not (false) for HTTP requests issued by this object.
		public var authenticate:Boolean;

		/// [AIR] Specifies whether the background of the HTMLLoader document is opaque white (true) or not (false).
		public var paintsDefaultBackground:Boolean;

		/// [AIR] The character encoding used by the HTMLLoader content, overriding any setting in the HTML page.
		public var textEncodingOverride:String;

		/// [AIR] The character encoding used by the HTMLLoader content if an HTML page does not specify a character encoding.
		public var textEncodingFallback:String;

		/// [AIR] Indicates whether any content in the HTMLLoader object is focusable.
		public var hasFocusableContent:Boolean;

		/// [AIR] The HTMLHost object used to handle changes to certain user interface elements, such as the window.document.title property of the HTMLLoader object.
		public var htmlHost:flash.html.HTMLHost;

		/// [AIR] Specifies whether navigation of the root frame of the HTML content (such as when the user clicks a link, when the window.location property is set, or when calling window.open()) results in navigation in the HTMLLoader object (false) or in the default system web browser (true).
		public var navigateInSystemBrowser:Boolean;

		/// [AIR] The type of PDF support on the user's system, defined as an integer code value.
		public var pdfCapability:int;

		/// [AIR] The overall length of the history list, including back and forward entries.
		public var historyLength:uint;

		/// [AIR] The current position in the history list.
		public var historyPosition:uint;

		/// [AIR] Creates an HTMLLoader object.
		public function HTMLLoader();

		/// [AIR] Creates a new NativeWindow object that contains an HTMLLoader object.
		public static function createRootWindow(visible:Boolean=true, windowInitOptions:flash.display.NativeWindowInitOptions=null, scrollBarsVisible:Boolean=true, bounds:flash.geom.Rectangle=null):flash.html.HTMLLoader;

		/// [AIR] Loads the HTMLLoader object with the HTML content contained in the HTML string.
		public function loadString(htmlContent:String):void;

		/// [AIR] Loads the HTMLLoader object with data from the site specified by the urlRequestToLoad parameter.
		public function load(urlRequestToLoad:flash.net.URLRequest):void;

		/// [AIR] Reloads the page from the current location.
		public function reload():void;

		/// [AIR] Cancels any load operation in progress.
		public function cancelLoad():void;

		/// [AIR] Navigates back in the browser history, if possible.
		public function historyBack():void;

		/// [AIR] Navigates forward in the browser history, if possible.
		public function historyForward():void;

		/// [AIR] Navigates the specified number of steps in the browser history.
		public function historyGo(steps:int):void;

		/// [AIR] Returns the history entry at the specified position.
		public function getHistoryAt(position:uint):flash.html.HTMLHistoryItem;

	}

}

