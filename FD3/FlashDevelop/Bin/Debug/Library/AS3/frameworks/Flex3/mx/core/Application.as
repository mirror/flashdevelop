package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.setInterval;
	import mx.containers.utilityClasses.ApplicationLayout;
	import mx.effects.EffectManager;
	import mx.events.FlexEvent;
	import mx.managers.FocusManager;
	import mx.managers.ILayoutManager;
	import mx.managers.ISystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;

	/**
	 *  Dispatched after the Application has been initialized,
 *  processed by the LayoutManager, and attached to the display list.
 * 
 *  @eventType mx.events.FlexEvent.APPLICATION_COMPLETE
	 */
	[Event(name="applicationComplete", type="mx.events.FlexEvent")] 

	/**
	 *  Dispatched when an error occurs anywhere in the application,
 *  such as an HTTPService, WebService, or RemoteObject fails.
 * 
 *  @eventType flash.events.ErrorEvent.ERROR
	 */
	[Event(name="error", type="flash.events.ErrorEvent")] 

include "../styles/metadata/ModalTransparencyStyles.as"
	/**
	 *  Specifies the alpha transparency values used for the background gradient fill of the application.
 *  You should set this to an Array of two numbers.
 *  Elements 0 and 1 specify the start and end values for an alpha gradient.
 *
 *  @default [ 1.0, 1.0 ]
	 */
	[Style(name="backgroundGradientAlphas", type="Array", arrayType="Number", inherit="no")] 

	/**
	 *  Specifies the colors used to tint the background gradient fill of the application.
 *  You should set this to an Array of two uint values that specify RGB colors.
 *  Elements 0 and 1 specify the start and end values for a color gradient.
 *  For a solid-color background, set the same color value for elements 0 and 1.
 *  A value of <code>undefined</code> means background gradient is generated
 *  based on the <code>backgroundColor</code> property.
 *
 *  @default undefined
	 */
	[Style(name="backgroundGradientColors", type="Array", arrayType="uint", format="Color", inherit="no")] 

	/**
	 *  Number of pixels between the application's bottom border
 *  and its content area.  
 *
 *  @default 24
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the application's top border
 *  and its content area. 
 *
 *  @default 24
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	[Exclude(name="direction", kind="property")] 

	[Exclude(name="icon", kind="property")] 

	[Exclude(name="label", kind="property")] 

	[Exclude(name="tabIndex", kind="property")] 

	[Exclude(name="toolTip", kind="property")] 

	[Exclude(name="x", kind="property")] 

	[Exclude(name="y", kind="property")] 

include "../core/Version.as"
	/**
	 *  Flex defines a default, or Application, container that lets you start
 *  adding content to your application without explicitly defining
 *  another container.
 *  Flex creates this container from the <code>&lt;mx:Application&gt;</code>
 *  tag, the first tag in an MXML application file.
 *  While you might find it convenient to use the Application container
 *  as the only  container in your application, in most cases you explicitly
 *  define at least one more container before you add any controls
 *  to your application.
 *
 *  <p>Applications support a predefined plain style that sets
 *  a white background, left alignment, and removes all margins.
 *  To use this style, do the following:</p>
 *
 *  <pre>
 *    &lt;mx:Application styleName="plain" /&gt;
 *  </pre>
 *
 *  <p>This is equivalent to setting the following style attributes:</p>
 *
 *  <pre>
 *    backgroundColor="0xFFFFFF"
 *    horizontalAlign="left"
 *    paddingLeft="0"
 *    paddingTop="0"
 *    paddingBottom="0"
 *    paddingRight="0"
 *  </pre>
 * 
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Application&gt;</code> tag inherits all of the tag 
 *  attributes of its superclass and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:Application
 *    <strong>Properties</strong>
 *    application="<i>No default</i>"
 *    controlBar="null"
 *    frameRate="24"
 *    historyManagementEnabled="true|false"
 *    layout="vertical|horizontal|absolute"
 *    pageTitle"<i>No default</i>"
 *    preloader="<i>No default</i>"
 *    resetHistory="false|true"
 *    scriptRecursionLimit="1000"
 *    scriptTimeLimit="60"
 *    usePreloader="true|false"
 *    viewSourceURL=""
 *    xmlns:<i>No default</i>="<i>No default</i>"
 * 
 *    <strong>Styles</strong> 
 *    backgroundGradientAlphas="[ 1.0, 1.0 ]"
 *    backgroundGradientColors="undefined"
 *    horizontalAlign="center|left|right"
 *    horizontalGap="8"
 *    modalTransparency="0.5"
 *    modalTransparencyBlur="3"
 *    modalTransparencyColor="#DDDDDD"
 *    modalTransparencyDuration="100"
 *    paddingBottom="24"
 *    paddingTop="24"
 *    verticalAlign="top|bottom|middle"
 *    verticalGap="6"
 *  
 *    <strong>Events</strong>
 *    applicationComplete="<i>No default</i>"
 *    error="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/SimpleApplicationExample.mxml
 *  
 *  @see mx.managers.CursorManager
 *  @see mx.managers.LayoutManager
 *  @see mx.managers.SystemManager
 *  @see flash.events.EventDispatcher
	 */
	public class Application extends LayoutContainer
	{
		/**
		 *  @private
		 */
		static var useProgressiveLayout : Boolean;
		/**
		 *  @private
		 */
		private var resizeHandlerAdded : Boolean;
		/**
		 *  @private
     *  Placeholder for Preloader object reference.
		 */
		private var preloadObj : Object;
		/**
		 *  @private
     *  Used in progressive layout.
		 */
		private var creationQueue : Array;
		/**
		 *  @private
     *  Used in progressive layout.
		 */
		private var processingCreationQueue : Boolean;
		/**
		 *  @private
     *  The application's view metrics.
		 */
		private var _applicationViewMetrics : EdgeMetrics;
		/**
		 *  @private
     *  This flag indicates whether the width of the Application instance
     *  can change or has been explicitly set by the developer.
     *  When the stage is resized we use this flag to know whether the
     *  width of the Application should be modified.
		 */
		private var resizeWidth : Boolean;
		/**
		 *  @private
     *  This flag indicates whether the height of the Application instance
     *  can change or has been explicitly set by the developer.
     *  When the stage is resized we use this flag to know whether the
     *  height of the Application should be modified.
		 */
		private var resizeHeight : Boolean;
		/**
		 * @private
     * (Possibly null) reference to the View Source context menu item,
     * so that we can update it for runtime localization.
		 */
		private var viewSourceCMI : ContextMenuItem;
		/**
		 *    Specifies the frame rate of the application.
     *    <p>Note: This property cannot be set by ActionScript code; it must be set in MXML code.</p>
     *
     *    @default 24
		 */
		public var frameRate : Number;
		/**
		 *    Specifies a string that appears in the title bar of the browser.
     *    This property provides the same functionality as the
     *    HTML <code>&lt;title&gt;</code> tag.
     *    <p>Note: This property cannot be set by ActionScript code; it must be set in MXML code.</p>
     *
     *    @default ""
		 */
		public var pageTitle : String;
		/**
		 *    Specifies the path of a SWC component class or ActionScript
     *    component class that defines a custom progress bar.
     *    A SWC component must be in the same directory as the MXML file
     *    or in the WEB-INF/flex/user_classes directory of your Flex
     *    web application.
     *    <p>Note: This property cannot be set by ActionScript code; it must be set in MXML code.</p>
		 */
		public var preloader : Object;
		/**
		 *    Specifies the maximum depth of Flash Player or AIR 
     *    call stack before the player stops.
     *    This is essentially the stack overflow limit.
     *    <p>Note: This property cannot be set by ActionScript code; it must be set in MXML code.</p>
     *
     *    @default 1000
		 */
		public var scriptRecursionLimit : int;
		/**
		 *    Specifies the maximum duration, in seconds, that an ActionScript
     *    event handler can execute before Flash Player or AIR assumes
     *    that it is hung, and aborts it.
     *    The maximum allowable value that you can set is 60 seconds.
     *
     *  @default 60
		 */
		public var scriptTimeLimit : Number;
		/**
		 *    If <code>true</code>, specifies to display the application preloader.
     *    <p>Note: This property cannot be set by ActionScript code; it must be set in MXML code.</p>
     *
     *    @default true
		 */
		public var usePreloader : Boolean;
		/**
		 *  The ApplicationControlBar for this Application. 
     *
     *  @see mx.containers.ApplicationControlBar
     *  @default null
		 */
		public var controlBar : IUIComponent;
		/**
		 *  If <code>false</code>, the history manager will be disabled.
     *  Setting to false is recommended when using the BrowserManager.
     *
     *  @default true
		 */
		public var historyManagementEnabled : Boolean;
		/**
		 *  @private
     *  Storage for the parameters property.
     *  This variable is set in the initialize() method of SystemManager.
		 */
		var _parameters : Object;
		/**
		 *  If <code>true</code>, the application's history state is reset
     *  to its initial state whenever the application is reloaded.
     *  Applications are reloaded when any of the following occurs:
     *  <ul>
     *    <li>The user clicks the browser's Refresh button.</li>
     *    <li>The user navigates to another web page, and then clicks
     *    the browser's Back button to return to the Flex application.</li>
     *    <li>The user loads a Flex application from the browser's
     *    Favorites or Bookmarks menu.</li>
     *  </ul>
     *
     *  @default true
		 */
		public var resetHistory : Boolean;
		/**
		 *  @private
     *  Storage for the url property.
     *  This variable is set in the initialize() method of SystemManager.
		 */
		var _url : String;
		/**
		 *  @private
     *  Storage for viewSourceURL property.
		 */
		private var _viewSourceURL : String;

		/**
		 *  Note: here are two reasons that 'application' is typed as Object
     *  rather than as Application. The first is for consistency with
     *  the 'parentApplication' property of UIComponent. That property is not
     *  typed as Application because it would make UIComponent dependent
     *  on Application, slowing down compile times not only for SWCs
     *  for also for MXML and AS components. Second, if it were typed
     *  as Application, authors would not be able to access properties
     *  and methods in the <Script> of their <Application> without
     *  casting it to their application's subclass, as in
     *  MyApplication(Application.application).myAppMethod().
     *  Therefore we decided to dispense with strict typing for
     *  'application'.
		 */
		public static function get application () : Object;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set icon (value:Class) : void;

		/**
		 *  @private
		 */
		public function get id () : String;

		/**
		 *  @private
		 */
		public function set label (value:String) : void;

		/**
		 *  @private
		 */
		public function set percentHeight (value:Number) : void;

		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;

		/**
		 *  @private
		 */
		public function set tabIndex (value:int) : void;

		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;

		/**
		 *  @private
     *  Returns the thickness of the edges of the object, including
     *  the border, title bar and scroll bars, if visible.
     *
     *  @return EdgeMetrics object with left, right, top, and bottom
     *  properties containing the edge thickness, in pixels.
		 */
		public function get viewMetrics () : EdgeMetrics;

		/**
		 *  The parameters property returns an Object containing name-value
     *  pairs representing the parameters provided to this Application.
     *
     *  <p>You can use a for-in loop to extract all the names and values
     *  from the parameters Object.</p>
     *
     *  <p>There are two sources of parameters: the query string of the
     *  Application's URL, and the value of the FlashVars HTML parameter
     *  (this affects only the main Application).</p>
		 */
		public function get parameters () : Object;

		/**
		 *  The URL from which this Application's SWF file was loaded.
		 */
		public function get url () : String;

		/**
		 *  @private
		 */
		function get usePadding () : Boolean;

		/**
		 *  URL where the application's source can be viewed. Setting this
     *  property inserts a "View Source" menu item into the application's
     *  default context menu.  Selecting the menu item opens the
     *  <code>viewSourceURL</code> in a new window.
     *
     *  <p>You must set the <code>viewSourceURL</code> property 
     *  using MXML, not using ActionScript, as the following example shows:</p>
     *
     *  <pre>
     *    &lt;mx:Application viewSourceURL="http://path/to/source"&gt;
     *      ...
     *    &lt;/mx:Application&gt;</pre>
     *
		 */
		public function get viewSourceURL () : String;
		/**
		 *  @private
		 */
		public function set viewSourceURL (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function Application ();

		/**
		 *  @private
		 */
		function setUnscaledHeight (value:Number) : void;

		/**
		 *  @private
		 */
		function setUnscaledWidth (value:Number) : void;

		/**
		 *  @private
		 */
		public function getChildIndex (child:DisplayObject) : int;

		/**
		 *  @private
		 */
		public function initialize () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
     *  Calculates the preferred, mininum and maximum sizes of the
     *  Application. See the <code>UIComponent.measure()</code> method for more
     *  information.
     *  <p>
     *  The <code>measure()</code> method first calls
     *  <code>Box.measure()</code> method, then makes sure the
     *  <code>measuredWidth</code> and <code>measuredMinWidth</code>
     *  are wide enough to display the application's control bar.
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
     *  Prepare the Object for printing.
     *
     *  @see mx.printing.FlexPrintJob
		 */
		public function prepareToPrint (target:IFlexDisplayObject) : Object;

		/**
		 *  @private
     *  Should be called after printing is done for post-processing and clean up.
     *
     *  @see mx.printing.FlexPrintJob
		 */
		public function finishPrint (obj:Object, target:IFlexDisplayObject) : void;

		/**
		 *  @private
     *  Application also handles themeColor defined
     *  on the global selector.
		 */
		function initThemeColor () : Boolean;

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  @private
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  This is here so we get the this pointer set to Application.
		 */
		private function debugTickler () : void;

		/**
		 *  @private
		 */
		private function initManagers (sm:ISystemManager) : void;

		/**
		 *  @private
     *  Disable all the built-in items except "Print...".
		 */
		private function initContextMenu () : void;

		/**
		 *  Add a container to the Application's creation queue.
     *
     *  <p>Use this mechanism to instantiate and draw the contents
     *  of a container in an ordered manner.
     *  The container should have the <code>creationPolicy</code> property
     *  set to <code>"none"</code> prior to calling this function.</p>
     *
     *  @param id The id of the container to add to the queue or a 
     *  pointer to the container itself
     *
     *  @param preferredIndex (optional) A positive integer that determines
     *  the container's position in the queue relative to the other
     *  containers presently in the queue.
     *
     *  @param callbackFunc This parameter is ignored.
     *
     *  @param parent This parameter is ignored.
		 */
		public function addToCreationQueue (id:Object, preferredIndex:int = -1, callbackFunc:Function = null, parent:IFlexDisplayObject = null) : void;

		/**
		 *  @private
		 */
		private function doNextQueueItem (event:FlexEvent = null) : void;

		/**
		 *  @private
		 */
		private function processNextQueueItem () : void;

		/**
		 *  @private
		 */
		private function printCreationQueue () : void;

		/**
		 *  @private
		 */
		private function setControlBar (newControlBar:IUIComponent) : void;

		/**
		 *  @private
		 */
		function dockControlBar (controlBar:IUIComponent, dock:Boolean) : void;

		/**
		 *  @private
     *   Called after all children are drawn.
		 */
		private function addedHandler (event:Event) : void;

		/**
		 *  @private 
     *  Triggered by a resize event of the stage.
     *  Sets the new width and height.
     *  After the SystemManager performs its function,
     *  it is only necessary to notify the children of the change.
		 */
		private function resizeHandler (event:Event) : void;

		/**
		 *  @private
     *  Called when the "View Source" item in the application's context menu is
     *  selected.
		 */
		protected function menuItemSelectHandler (event:Event) : void;
	}
}
