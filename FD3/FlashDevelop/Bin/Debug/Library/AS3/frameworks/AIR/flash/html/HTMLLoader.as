/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.html {
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.display.NativeWindowInitOptions;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	public class HTMLLoader extends Sprite {
		/**
		 * Specifies whether authentication requests should be handled (true)
		 *  or not (false) for HTTP requests issued by this object. If false, authentication
		 *  challenges return an HTTP error.
		 */
		public function get authenticate():Boolean;
		public function set authenticate(value:Boolean):void;
		/**
		 * Specifies whether successful response data should be cached for HTTP requests issued by this object.
		 *  When set to true, the HTMLLoader object uses the operating system's HTTP cache.
		 */
		public function get cacheResponse():Boolean;
		public function set cacheResponse(value:Boolean):void;
		/**
		 * The height, in pixels, of the HTML content. This property can change as the dimensions of the HTMLLoader object change.
		 *  For example, an HTML page often uses the entire height of the HTMLLoader object, and the contentHeight property may
		 *  change if you change the height of the HTMLLoader object.
		 */
		public function get contentHeight():Number;
		/**
		 * The width, in pixels, of the HTML content. This property can change as the dimensions of the HTMLLoader object change.
		 *  For example, an HTML page often uses the entire width of the HTMLLoader object, and the contentWidth property may
		 *  change if you change the width of the HTMLLoader object.
		 */
		public function get contentWidth():Number;
		/**
		 * Indicates whether any content in the HTMLLoader object is focusable.
		 */
		public function get hasFocusableContent():Boolean;
		/**
		 * Specifies the height of the rectangle of the HTML canvas that is being rendered.
		 *  This is the height of the HTMLLoader display object in pixels.
		 *  Changing this property causes the HTMLLoader object to re-render the HTML document.
		 *  htmlBoundsChanged events may dispatched in response to changing this property.
		 *  When you set the width or
		 *  height property of an HTMLLoader object, the bounds of the object change but
		 *  content is not scaled (as would happen with other types of display objects).
		 */
		public function get height():Number;
		public function set height(value:Number):void;
		/**
		 * The overall length of the history list, including back and forward entries.
		 *  This property has the same value as the window.history.length
		 *  JavaScript property of the the HTML page.
		 */
		public function get historyLength():uint;
		/**
		 * The current position in the history list. The history list corresponds to the
		 *  window.history object of the HTML page.
		 *  Entries less than the current position are the "back" list; entries greater are "forward."
		 *  Attempts to set position beyond the end set it to the end.
		 */
		public function get historyPosition():uint;
		public function set historyPosition(value:uint):void;
		/**
		 * The HTMLHost object used to handle changes to certain user interface elements, such as the
		 *  window.document.title property of the HTMLLoader object.  To override default
		 *  behaviors for the HTMLLoader object, create a subclass of the HTMLHost class and override its member
		 *  functions to handle various user interface changes in the HTML content.
		 */
		public function get htmlHost():HTMLHost;
		public function set htmlHost(value:HTMLHost):void;
		/**
		 * Indicates whether the JavaScript load event corresponding to the previous call to the
		 *  load() or loadString() method has been delivered to
		 *  the HTML DOM in the HTMLLoader object.
		 *  This property is true before the complete event is dispatched.
		 *  It is possible that this property will never become true.  This happens in the
		 *  same cases as when the complete event is never dispatched.
		 */
		public function get loaded():Boolean;
		/**
		 * The URL for the content loaded in the HTMLLoader object.
		 */
		public function get location():String;
		/**
		 * Specifies whether the HTTP protocol stack should manage cookies for this
		 *  object. If true, cookies are added to the request
		 *  and response cookies are remembered. If false, cookies are
		 *  not added to the request and response cookies are not
		 *  remembered.
		 */
		public function get manageCookies():Boolean;
		public function set manageCookies(value:Boolean):void;
		/**
		 * Specifies whether navigation of the root frame of the HTML content (such as when the user clicks a link, when the
		 *  window.location property is set, or when calling window.open()) results in
		 *  navigation in the HTMLLoader object (false) or in the default system web browser
		 *  (true). Set this property to true if you want all navigation to occur in the
		 *  system web browser (not in the HTMLLoader object).
		 */
		public function get navigateInSystemBrowser():Boolean;
		public function set navigateInSystemBrowser(value:Boolean):void;
		/**
		 * Specifies whether the background of the HTMLLoader document is opaque white (true) or
		 *  not (false). If this property is set to false, the HTMLLoader
		 *  object uses its display object container as a background for the HTML and it uses the opacity
		 *  (alpha value) of the display object container as the HTML background. However, if
		 *  the body element or any other element of the HTML document has an opaque background
		 *  color (specified by style="background-color:gray", for instance), then that portion
		 *  of the rendered HTML uses the specified opaque background color.
		 */
		public function get paintsDefaultBackground():Boolean;
		public function set paintsDefaultBackground(value:Boolean):void;
		/**
		 * The type of PDF support on the user's system, defined as an integer code value.
		 *  An HTMLLoader object can display PDF content only if this property evaluates to
		 *  PDFCapability.STATUS_OK. The PDFCapability class defines constants
		 *  for possible values of the pdfCapability property, as follows:
		 *  PDFCapability constantMeaning
		 *  STATUS_OKA sufficient version (8.1 or later) of Acrobat or Adobe Reader is detected and PDF content
		 *  can be loaded in an HTMLLoader object.
		 */
		public static function get pdfCapability():int;
		/**
		 * The application domain to use for the window.runtime object in JavaScript
		 *  in the HTML page.
		 */
		public function get runtimeApplicationDomain():ApplicationDomain;
		public function set runtimeApplicationDomain(value:ApplicationDomain):void;
		/**
		 * The horizonal scroll position of the HTML content in the HTMLLoader object.
		 */
		public function get scrollH():Number;
		public function set scrollH(value:Number):void;
		/**
		 * The vertical scroll position of the HTML content in the HTMLLoader object.
		 */
		public function get scrollV():Number;
		public function set scrollV(value:Number):void;
		/**
		 * The character encoding used by the HTMLLoader content if an HTML page does not specify
		 *  a character encoding.
		 */
		public function get textEncodingFallback():String;
		public function set textEncodingFallback(value:String):void;
		/**
		 * The character encoding used by the HTMLLoader content, overriding any setting in the HTML page.
		 */
		public function get textEncodingOverride():String;
		public function set textEncodingOverride(value:String):void;
		/**
		 * Specifies whether the local cache should be consulted before HTTP requests issued by this object
		 *  fetch data.
		 */
		public function get useCache():Boolean;
		public function set useCache(value:Boolean):void;
		/**
		 * The user agent string to be used in any upcoming content requests from this HTMLLoader
		 *  object.
		 */
		public function get userAgent():String;
		public function set userAgent(value:String):void;
		/**
		 * Specifies the width of the rectangle of the HTML canvas that is being rendered.
		 *  This is the width of the HTMLLoader display object in pixels.
		 *  Changing this property causes the HTMLLoader object to re-render the HTML document.
		 *  htmlBoundsChange events may dispatched in response to changing this property.
		 *  When you set the width and
		 *  height properties of an HTMLLoader object, the bounds of the object change but
		 *  content is not scaled (as would happen with other types of display objects).
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * The global JavaScript object for the content loaded into the HTML control.
		 */
		public function get window():Object;
		/**
		 * Creates an HTMLLoader object.
		 */
		public function HTMLLoader();
		/**
		 * Cancels any load operation in progress.
		 */
		public function cancelLoad():void;
		/**
		 * Creates a new NativeWindow object that contains an HTMLLoader object. Use the
		 *  HTMLLoader object that is returned by this method to load HTML content.
		 *
		 * @param visible           <Boolean (default = true)> Specifies whether the window is visible.
		 * @param windowInitOptions <NativeWindowInitOptions (default = null)> Specifies window initialization options; if null, uses default
		 *                            NativeWindowInitOptions values.
		 * @param scrollBarsVisible <Boolean (default = true)> Specifies whether the window provides scrollbars.
		 * @param bounds            <Rectangle (default = null)> If not null, specifies the window bounds.  If any of x, y,
		 *                            width, or height is NaN, then the corresponding dimension of the window is
		 *                            left at its default value.
		 * @return                  <HTMLLoader> A new HTMLLoader object that is on the stage of the new NativeWindow object.
		 */
		public static function createRootWindow(visible:Boolean = true, windowInitOptions:NativeWindowInitOptions = null, scrollBarsVisible:Boolean = true, bounds:Rectangle = null):HTMLLoader;
		/**
		 * Returns the history entry at the specified position.
		 *
		 * @param position          <uint> The position in the history list.
		 * @return                  <HTMLHistoryItem> A URLRequest object for the history entry at the specified position.
		 */
		public function getHistoryAt(position:uint):HTMLHistoryItem;
		/**
		 * Navigates back in the browser history, if possible.
		 */
		public function historyBack():void;
		/**
		 * Navigates forward in the browser history, if possible.
		 */
		public function historyForward():void;
		/**
		 * Navigates the specified number of steps in the browser history.
		 *  Navigates forward if positive, backward if negative.
		 *  Navigation by zero forces a reload.
		 *
		 * @param steps             <int> The number of steps in the history list to move
		 *                            forward (positive) or backward (negative).
		 */
		public function historyGo(steps:int):void;
		/**
		 * Loads the HTMLLoader object with data from the site specified by the urlRequestToLoad parameter.
		 *  Calling this method initially sets the loaded property to false.  This method
		 *  initiates an operation that always completes asynchronously.
		 *
		 * @param urlRequestToLoad  <URLRequest> The URLRequest object containing information about the URL to
		 *                            load. In addition to the URL to load, a URLRequest object contains properties that define
		 *                            the HTTP form submission method (GET or POST), any data to be transmitted with the request,
		 *                            and request headers.
		 */
		public function load(urlRequestToLoad:URLRequest):void;
		/**
		 * Loads the HTMLLoader object with the HTML content contained in the HTML string. When rendering of the
		 *  of the HTML in the string is complete, the complete event is dispatched.  The
		 *  complete event is always dispatched asynchronously.
		 *
		 * @param htmlContent       <String> The string containing the HTML content to load into the HTMLLoader object.
		 */
		public function loadString(htmlContent:String):void;
		/**
		 * Reloads the page from the current location.
		 */
		public function reload():void;
	}
}
