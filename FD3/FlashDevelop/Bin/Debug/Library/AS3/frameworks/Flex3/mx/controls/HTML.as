package mx.controls
{
	import flash.events.Event;
	import flash.events.HTMLUncaughtScriptExceptionEvent;
	import flash.events.MouseEvent;
	import flash.html.HTMLLoader;
	import flash.html.HTMLHistoryItem;
	import flash.html.HTMLHost;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.FlexHTMLLoader;
	import mx.core.mx_internal;
	import mx.core.ScrollControlBase;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;
	import mx.events.ScrollEvent;
	import mx.styles.StyleManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.managers.IFocusManagerComponent;

	/**
	 *  Dispatched after the last loading operation caused by *  setting the <code>location</code> or <code>htmlText</code> *  property has completed. * *  <p>This event is always dispatched asynchronously, *  after the JavaScript <code>load</code> event *  has been dispatched in the HTML DOM.</p> * *  <p>An event handler for this event may call any method *  or access any property of this control *  or its internal <code>htmlLoader</code>.</p> * *  @eventType flash.events.Event.COMPLETE *  *  @see location *  @see htmlText
	 */
	[Event(name="complete", type="flash.events.Event")] 
	/**
	 *  Dispatched after the HTML DOM has been initialized *  in response to a loading operation caused by *  setting the <code>location</code> or <code>htmlText</code> property. * *  <p>When this event is dispatched, *  no JavaScript methods have yet executed. *  The <code>domWindow</code>and <code>domWindow.document</code> *  objects exist, but other DOM objects may not. *  You can use this event to set properties *  onto the <code>domWindow</code> and <code>domWindow.document</code> *  objects for JavaScript methods to later access.</p> * *  <p>A handler for this event should not set any properties *  or call any methods which start another loading operation *  or which affect the URL for the current loading operation; *  doing so causes either an ActionScript or a JavaScript exception.</p> * *  @eventType flash.events.Event.HTML_DOM_INITIALIZE *  *  @see location *  @see htmlText
	 */
	[Event(name="htmlDOMInitialize", type="flash.events.Event")] 
	/**
	 *  Dispatched when this control's HTML content initially renders, *  and each time that it re-renders. * *  <p>Because an HTML control can dispatch many of these events, *  you should avoid significant processing in a <code>render</code> *  handler that might negatively impact performance.</p> * *  @eventType flash.events.Event.HTML_RENDER
	 */
	[Event(name="htmlRender", type="flash.events.Event")] 
	/**
	 *  Dispatched when the <code>location</code> property changes. * *  <p>This event is always dispatched asynchronously. *  An event handler for this event may call any method *  or access any property of this control *  or its internal <code>htmlLoader</code>.</p> * *  @eventType flash.events.Event.LOCATION_CHANGE
	 */
	[Event(name="locationChange", type="flash.events.Event")] 
	/**
	 *  Dispatched when an uncaught JavaScript exception occurs. * *  <p>This event is always dispatched asynchronously. *  An event handler for this event may call any method *  or access any property of this control *  or its internal <code>htmlLoader</code>.</p> * *  @eventType flash.events.HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION
	 */
	[Event(name="uncaughtScriptException", type="flash.events.HTMLUncaughtScriptExceptionEvent")] 
	/**
	 *  The number of pixels between the bottom edge of this control *  and the bottom edge of its HTML content area. * *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  The number of pixels between the left edge of this control *  and the left edge of its HTML content area. * *  @default 0
	 */
	[Style(name="paddingLeft", type="Number", format="Length", inherit="no")] 
	/**
	 *  The number of pixels between the right edge of this control *  and the right edge of its HTML content area. * *  @default 0
	 */
	[Style(name="paddingRight", type="Number", format="Length", inherit="no")] 
	/**
	 *  The number of pixels between the top edge of this control *  and the top edge of its HTML content area. * *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The HTML control lets you display HTML content in your application. * *  <p>You use the <code>location</code> property to specify the URL *  of an HTML page whose content is displayed in the control, or you *  can set the <code>htmlText</code> property to specify a String *  containing HTML-formatted text that is rendered in the control.</p> * *  @mxml * *  <p>The <code>&lt;mx:HTML&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:HTML *    <strong>Properties</strong> *    data="<i>null</i>" *    historyPosition="0" *    htmlHost="<i>null</i>" *    htmlLoaderFactory="mx.core.ClassFactory" *    htmlText="" *    listData="<i>null</i>" *    location="" *    paintsDefaultBackground="false" *    runtimeApplicationDomain="<i>null</i>" *    userAgent="<i>null</i>" *  *    <strong>Styles</strong> *    paddingBottom="0" *    paddingLeft="0" *    paddingRight="0" *    paddingTop="0" *  *    <strong>Events</strong> *    complete="<i>No default</i>" *    htmlDOMInitialize="<i>No default</i>" *    htmlRender="<i>No default</i>" *    locationChange="<i>No default</i>" *    uncaughtScriptException="<i>No default</i>" *  /&gt; *  </pre> *  *  @see flash.html.HTMLLoader *  *  @playerversion AIR 1.1
	 */
	public class HTML extends ScrollControlBase implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private static const MAX_HTML_WIDTH : Number = 2880;
		/**
		 *  @private
		 */
		private static const MAX_HTML_HEIGHT : Number = 2880;
		/**
		 *  @private     *  Flag that will block default data/listData behavior.
		 */
		private var textSet : Boolean;
		/**
		 *  @private     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  The internal HTMLLoader object that renders     *  the HTML content for this control.
		 */
		public var htmlLoader : HTMLLoader;
		/**
		 *  @private     *  Storage for the htmlLoaderFactory property.
		 */
		private var _htmlLoaderFactory : IFactory;
		/**
		 *  @private     *  Storage for the htmlHost property.
		 */
		private var _htmlHost : HTMLHost;
		/**
		 *  @private
		 */
		private var htmlHostChanged : Boolean;
		/**
		 *  @private     *  Storage for the htmlText property.
		 */
		private var _htmlText : String;
		/**
		 *  @private
		 */
		private var htmlTextChanged : Boolean;
		/**
		 *  @private     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;
		/**
		 *  @private     *  Storage for the location property.
		 */
		private var _location : String;
		/**
		 *  @private
		 */
		private var locationChanged : Boolean;
		/**
		 *  @private     *  Storage for the paintsDefaultBackground property.
		 */
		private var _paintsDefaultBackground : Boolean;
		/**
		 *  @private
		 */
		private var paintsDefaultBackgroundChanged : Boolean;
		/**
		 *  @private     *  Storage for the runtimeApplicationDomain property.
		 */
		private var _runtimeApplicationDomain : ApplicationDomain;
		/**
		 *  @private
		 */
		private var runtimeApplicationDomainChanged : Boolean;
		/**
		 *  @private     *  Storage for the userAgent property.
		 */
		private var _userAgent : String;
		/**
		 *  @private
		 */
		private var userAgentChanged : Boolean;

		/**
		 *  The type of PDF support on the user's system,     *  defined as an integer code value.     *     *  <p>An HTML object can display PDF content only if this property     *  evaluates to <code>PDFCapability.STATUS_OK</code>.     *  The PDFCapability class defines constants for possible values     *  of the <code>pdfCapability</code> property, as follows:</p>     *     *  <table class="innertable">     *    <tr>     *     <th>PDFCapability constant</th>     *     <th>Meaning</th>     *    </tr>     *    <tr>     *     <td><code>STATUS_OK</code></td>     *     <td>A sufficient version (8.1 or later) of Acrobat Reader     *         is detected and PDF content can be loaded in an HTML object.     *       <p><em>Note:</em> On Windows, if a Acrobat Acrobat     *         or Acrobat Reader version 7.x or above     *       is currently running on the user's system,     *         that version is used even if a later version     *       that supports loading PDF loaded in an HTML object is installed.     *         In this case, if the the value of the     *         <code>pdfCampability</code> property is     *       <code>PDFCapability.STATUS_OK</code>,     *         when an AIR application attempts to load PDF content     *      into an HTML object, the older version of Acrobat or Reader     *         displays an alert, without an error message displayed the AIR runtime.     *         If this is a possible situation for your end users,     *         you may consider providing them with instructions to close Acrobat     *      while running your application.     *         You may consider displaying these instructions if the PDF     *      content does not load within an acceptable timeframe.</p></td>     *    </tr>     *    <tr>     *     <td><code>ERROR_INSTALLED_READER_NOT_FOUND</code></td>     *     <td>No version of Acrobat Reader is detected.     *         An HTML object cannot display PDF content.</td>     *    </tr>     *    <tr>     *     <td><code>ERROR_INSTALLED_READER_TOO_OLD</code></td>     *     <td>Acrobat Reader has been detected, but the version is too old.     *         An HTML object cannot display PDF content.</td>     *    </tr>     *    <tr>     *     <td><code>ERROR_PREFERED_READER_TOO_OLD</code></td>     *     <td>A sufficient version (8.1 or later) of Acrobat Reader is detected,     *         but the the version of Acrobat Reader that is setup     *         to handle PDF content is older than Reader 8.1.     *         An HTML object cannot display PDF content.</td>     *    </tr>     *  </table>
		 */
		public static function get pdfCapability () : int;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 *  The height, in pixels, of the HTML content.
		 */
		public function get contentHeight () : Number;
		/**
		 *  The width, in pixels, of the HTML content.
		 */
		public function get contentWidth () : Number;
		/**
		 *  Lets you pass a value to the component     *  when you use it in an item renderer or item editor.     *  You typically use data binding to bind a field of the <code>data</code>     *  property to a property of this component.     *     *  <p>When you use the control as a drop-in item renderer or drop-in     *  item editor, Flex automatically writes the current value of the item     *  to the <code>text</code> property of this control.</p>     *     *  <p>You cannot set this property in MXML.</p>     *     *  @default null     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  The overall length of the history list,     *  including back and forward entries.     *     *  This property has the same value     *  as the <code>window.history.length</code>     *  JavaScript property of the the HTML content.     *     *  @see #historyPosition
		 */
		public function get historyLength () : int;
		/**
		 *  The current position in the history list.     *     *  <p>The history list corresponds to the <code>window.history</code>     *  object of the HTML content.     *  Entries less than the current position are the "back" list;     *  entries greater are "forward."     *  Attempting to set the position beyond the end sets it to the end.</p>	 * 	 *  @default 0
		 */
		public function get historyPosition () : int;
		/**
		 *  @private
		 */
		public function set historyPosition (value:int) : void;
		/**
		 *  The IFactory that creates an HTMLLoader-derived instance     *  to use as the htmlLoader.	 *     *  <p>The default value is an IFactory for HTMLLoader.</p>
		 */
		public function get htmlLoaderFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set htmlLoaderFactory (value:IFactory) : void;
		/**
		 *  The HTMLHost object is used to handle changes     *  to certain user interface elements in the HTML content,     *  such as the <code>window.document.title</code> property.     *     *  <p>To override default behaviors for the HTMLLoader,     *  create a subclass of the HTMLHost class,     *  override its member functions     *  to handle various user interface changes in the HTML content,     *  and set this property to an instance of your subclass.</p>	 * 	 *  @default null
		 */
		public function get htmlHost () : HTMLHost;
		/**
		 *  @private
		 */
		public function set htmlHost (value:HTMLHost) : void;
		/**
		 *  Specifies an HTML-formatted String for display by the control.     *     *  <p>Setting this property has the side effect of setting     *  the <code>location</code> property to <code>null</code>,     *  and vice versa.</p>	 * 	 *  <p>Content added via the <code>htmlText</code> property is put in the 	 *  application security sandbox. If an AIR application includes an HTML 	 *  control located in the application sandbox, and remote HTML code is 	 *  directly added into the control by setting the  <code>htmlText</code> 	 *  property, any script contained in the HTML text is executed in the 	 *  application sandbox.</p>     *     *  @default ""     *     *  @see #location
		 */
		public function get htmlText () : String;
		/**
		 *  @private
		 */
		public function set htmlText (value:String) : void;
		/**
		 *  The JavaScript <code>window</code> object     *  for the root frame of the HTML DOM inside this control.     *     *  <p>This property is <code>null</code> until the     *  <code>htmlDOMInitialize</code> event has been dispatched.</p>     *     *  @default null
		 */
		public function get domWindow () : Object;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in     *  item editor, Flex initializes the <code>listData</code> property     *  of the component with the appropriate data from the List control.     *  The component can then use the <code>listData</code> property     *  to initialize the <code>data</code> property of the drop-in     *  item renderer or drop-in item editor.     *     *  <p>You do not set this property in MXML or ActionScript;     *  Flex sets it when the component is used as a drop-in item renderer     *  or drop-in item editor.</p>     *     *  @default null     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  A flag which indicates whether the JavaScript <code>load</code> event     *  corresponding to the previous loading operation     *  has been delivered to the HTML DOM in this control.     *     *  <p>This property is <code>true</code>     *  before the <code>complete</code> event is dispatched.</p>     *     *  <p>It is possible that this property     *  never becomes <code>true</code>.     *  This happens in the same cases     *  in which the <code>complete</code> event is never dispatched.</p>     *     *  @default false
		 */
		public function get loaded () : Boolean;
		/**
		 *  The URL of an HTML page to be displayed by this control.     *     *  <p>Setting this property has the side effect of setting     *  the <code>htmlText</code> property to <code>null</code>,     *  and vice versa.</p>     *     *  @default ""     *     *  @see #htmlText
		 */
		public function get location () : String;
		/**
		 *  @private
		 */
		public function set location (value:String) : void;
		/**
		 *  Whether this control's HTML content     *  has a default opaque white background or not.     *     *  <p>If this property is <code>false</code>,     *  then the background specified for this Flex control, if any,     *  appears behind the HTML content.</p>     *     *  <p>However, if any HTML element has its own opaque background color     *  (specified by style="background-color:gray", for instance),     *  then that background appears behind that element.</p>	 * 	 *  @default false;
		 */
		public function get paintsDefaultBackground () : Boolean;
		/**
		 *  @private
		 */
		public function set paintsDefaultBackground (value:Boolean) : void;
		/**
		 *  The ApplicationDomain to use for HTML's <code>window.runtime</code>     *  scripting.     *     *  <p>If this property is <code>null</code>, or if it specifies     *  an ApplicationDomain from a different security domain     *  than the HTML content, the HTML page uses a default     *  <code>ApplicationDomain</code> for the page's domain.</p>     *     *  @default null
		 */
		public function get runtimeApplicationDomain () : ApplicationDomain;
		/**
		 *  @private
		 */
		public function set runtimeApplicationDomain (value:ApplicationDomain) : void;
		/**
		 *  The user agent string to be used in content requests     *  from this control.     *     *  <p>You can set the default user agent string used by all     *  HTML controls in an application domain by setting the     *  static <code>URLRequestDefaults.userAgent</code> property.     *  If no value is set for the <code>userAgent</code> property     *  (or if the value is set to <code>null</code>),     *  the user agent string is set to the value of     *  <code>URLRequestDefaults.userAgent</code>.</p>     *     *  <p>If neither the <code>userAgent</code> property     *  of this control nor for <code>URLRequestDefaults.userAgent</code>,     *  has a value set, a default value is used as the user agent string.     *  This default value varies depending on the runtime     *  operating system (such as Mac OS or Windows),     *  the runtime language, and the runtime version,     *  as in the following two examples:</p>     *     *  <pre>     *  "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) AdobeAIR/1.0"     *  "Mozilla/5.0 (Windows; U; en) AppleWebKit/420+ (KHTML, like Gecko) AdobeAIR/1.0"     *  </pre>     *     *  @default null     *     *  @see flash.net.URLRequest#userAgent     *  @see flash.net.URLRequestDefaults#userAgent
		 */
		public function get userAgent () : String;
		/**
		 *  @private
		 */
		public function set userAgent (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function HTML ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Cancels any load operation in progress.     *     *  <p>This method does nothing if it is called before this component's     *  internal HTMLLoader (the <code>htmlLoader</code> property) has been created.</p>
		 */
		public function cancelLoad () : void;
		/**
		 *  Returns the HTMLHistoryItem at the specified position     *  in this control's history list.     *     *  <p>This method returns <code>null</code> if it is called before this     *  component's internal HTMLLoader (the <code>htmlLoader</code> property) has been created.</p>     *     *  @param position The position in the history list.     *     *  @return A HTMLHistoryItem object     *  for the history entry  at the specified position.     *     *  @see historyPosition
		 */
		public function getHistoryAt (position:int) : HTMLHistoryItem;
		/**
		 *  Navigates back in this control's history list, if possible.     *     *  <p>Calling this method of the HTMLLoader object     *  has the same effect as calling the <code>back()</code> method     *  of the <code>window.history</code> property in JavaScript     *  in the HTML content.</p>     *     *  <p>This method does nothing if it is called before this component's     *  internal HTMLLoader (the <code>htmlLoader</code> property) has been created.</p>     *     *  @see #historyPosition     *  @see #historyForward()
		 */
		public function historyBack () : void;
		/**
		 *  Navigates forward in this control's history list, if possible.     *     *  <p>Calling this method of the HTMLLoader object     *  has the same effect as calling the <code>forward()</code> method     *  of the <code>window.history</code> property in JavaScript     *  in the HTML content.</p>     *     *  <p>This function throws no errors.</p>     *     *  <p>This method does nothing if it is called before this component's     *  internal HTMLLoader (the <code>htmlLoader</code> property) has been created.</p>     *     *  @see #historyPosition     *  @see #historyBack()
		 */
		public function historyForward () : void;
		/**
		 *  Navigates the specified number of steps in this control's history list.     *     *  <p>This method navigates forward if the number of steps     *  is positive and backward if it is negative.     *  Navigation by zero steps is equivalent     *  to calling <code>reload()</code>.</p>     *     *  <p>This method is equivalent to calling the <code>go()</code> method     *  of the <code>window.history</code> property in JavaScript     *  in the HTML content.</p>     *     *  <p>This method does nothing if it is called before this component's     *  internal HTMLLoader (the <code>htmlLoader</code> property) has been created.</p>     *     *  @param steps The number of steps in the history list     *  to move forward (positive) or backward (negative).
		 */
		public function historyGo (steps:int) : void;
		/**
		 *  Reloads the HTML content from the current <code>location</code>.     *     *  <p>This method does nothing if it is called before this component's     *  internal HTMLLoader (the <code>htmlLoader</code> property) has been created.</p>
		 */
		public function reload () : void;
		/**
		 *  @private
		 */
		private function adjustScrollBars () : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_domInitialize (event:Event) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_htmlRenderHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_locationChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_htmlBoundsChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function htmlLoader_uncaughtScriptExceptionHandler (event:HTMLUncaughtScriptExceptionEvent) : void;
	}
}
