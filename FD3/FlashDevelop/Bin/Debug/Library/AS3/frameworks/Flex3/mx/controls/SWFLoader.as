package mx.controls
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import mx.core.Application;
	import mx.core.FlexLoader;
	import mx.core.FlexVersion;
	import mx.core.ISWFLoader;
	import mx.core.IFlexDisplayObject;
	import mx.core.ISWFBridgeProvider;
	import mx.core.ISWFLoader;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.InvalidateRequestData;
	import mx.events.InterManagerRequest;
	import mx.events.SWFBridgeEvent;
	import mx.events.SWFBridgeRequest;
	import mx.managers.CursorManager;
	import mx.managers.FocusManager;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManagerGlobals;
	import mx.styles.ISimpleStyleClient;
	import mx.utils.LoaderUtil;

	/**
	 *  Dispatched when content loading is complete. * *  <p>This event is dispatched regardless of whether the load was triggered *  by an autoload or an explicit call to the <code>load()</code> method.</p> * *  @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 
	/**
	 *  Dispatched when a network request is made over HTTP  *  and Flash Player or AIR can detect the HTTP status code. *  *  @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
	 */
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")] 
	/**
	 *  Dispatched when the properties and methods of a loaded SWF file  *  are accessible. The following two conditions must exist *  for this event to be dispatched: *  *  <ul> *    <li>All properties and methods associated with the loaded  *    object and those associated with the control are accessible.</li> *    <li>The constructors for all child objects have completed.</li> *  </ul> *  *  @eventType flash.events.Event.INIT
	 */
	[Event(name="init", type="flash.events.Event")] 
	/**
	 *  Dispatched when an input/output error occurs. *  @see flash.events.IOErrorEvent * *  @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 
	/**
	 *  Dispatched when a network operation starts. *  *  @eventType flash.events.Event.OPEN
	 */
	[Event(name="open", type="flash.events.Event")] 
	/**
	 *  Dispatched when content is loading. * *  <p>This event is dispatched regardless of whether the load was triggered *  by an autoload or an explicit call to the <code>load()</code> method.</p> * *  <p><strong>Note:</strong>  *  The <code>progress</code> event is not guaranteed to be dispatched. *  The <code>complete</code> event may be received, without any *  <code>progress</code> events being dispatched. *  This can happen when the loaded content is a local file.</p> * *  @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	/**
	 *  Dispatched when a security error occurs while content is loading. *  For more information, see the SecurityErrorEvent class. * *  @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
	 */
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")] 
	/**
	 *  Dispatched when a loaded object is removed,  *  or when a second load is performed by the same SWFLoader control  *  and the original content is removed prior to the new load beginning. *  *  @eventType flash.events.Event.UNLOAD
	 */
	[Event(name="unload", type="flash.events.Event")] 
	/**
	 *  The name of class to use as the SWFLoader border skin if the control cannot *  load the content. *  @default BrokenImageBorderSkin
	 */
	[Style(name="brokenImageBorderSkin", type="Class", inherit="no")] 
	/**
	 *  The name of the class to use as the SWFLoader skin if the control cannot load *  the content. *  The default value is the "__brokenImage" symbol in the Assets.swf file.
	 */
	[Style(name="brokenImageSkin", type="Class", inherit="no")] 
	/**
	 *  The horizontal alignment of the content when it does not have *  a one-to-one aspect ratio. *  Possible values are <code>"left"</code>, <code>"center"</code>, *  and <code>"right"</code>. *  @default "left"
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  The vertical alignment of the content when it does not have *  a one-to-one aspect ratio. *  Possible values are <code>"top"</code>, <code>"middle"</code>, *  and <code>"bottom"</code>. *  @default "top"
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 

	/**
	 *  The SWFLoader control loads and displays a specified SWF file. *  You typically use SWFLoader for loading one Flex application *  into a host Flex application. * *  <p><strong>Note:</strong> You can use the SWFLoader control to load *  a GIF, JPEG, or PNG image file at runtime,  *  to load a ByteArray representing a SWF, GIF, JPEG, or PNG image at runtime,  *  or load an embedded version of any of these file types,  *  and SVG files, at compile time *  by using <code>&#64;Embed(source='filename')</code>. *  However, the Image control is better suited for this capability *  and should be used for most image loading. *  The Image control is also designed to be used *  in custom item renderers and item editors.  *  When using either SWFLoader or Image with an SVG file, *  you can only load the SVG if it has been embedded in your *  application using an Embed statement; *  you cannot load an SVG from the network at runtime.</p> * *  <p>The SWFLoader control lets you scale its content and set its size.  *  It can also resize itself to fit the size of its content. *  By default, content is scaled to fit the size of the SWFLoader control. *  It can also load content on demand programmatically, *  and monitor the progress of a load.</p>   * *  <p>A SWFLoader control cannot receive focus. *  However, the contents of a SWFLoader control can accept focus *  and have its own focus interactions.</p> * *  <p>The SWFLoader control has the following default characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Width and height large enough for the loaded content</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>Undefined</td> *        </tr> *     </table> * *  @mxml *   *  <p>The &lt;mx:SWFLoader&gt; tag inherits all of the tag attributes *  of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:SWFLoader *    <strong>Properties</strong> *    autoLoad="true|false" *    loadForCompatibility="false|true" *    loaderContext="null" *    maintainAspectRatio="true|false" *    scaleContent="true|false" *    showBusyCursor="false|true" *    source="<i>No default</i>" *    trustContent="false|true" *   *    <strong>Styles</strong> *    brokenImageBorderSkin="BrokenImageBorderSkin" *    brokenImageSkin="<i>'__brokenImage' symbol in Assets.swf</i>" *    horizontalAlign="left|center|right" *    verticalAlign="top|middle|bottom" *   *    <strong>Effects</strong> *    completeEffect="<i>No default</i>" *     *    <strong>Events</strong> *    complete="<i>No default</i>" *    httpStatus="<i>No default</i>" *    init="<i>No default</i>" *    ioError="<i>No default</i>" *    open="<i>No default</i>" *    progress="<i>No default</i>" *    securityError="<i>No default</i>" *    unload="<i>No default</i>" *  /&gt; *  </pre> *   *  @includeExample examples/local.mxml -noswf *  @includeExample examples/SimpleLoader.mxml * *  @see mx.controls.Image
	 */
	public class SWFLoader extends UIComponent implements ISWFLoader
	{
		/**
		 *  @private
		 */
		local var contentHolder : DisplayObject;
		/**
		 *  @private
		 */
		private var contentChanged : Boolean;
		/**
		 *  @private
		 */
		private var scaleContentChanged : Boolean;
		/**
		 *  @private
		 */
		private var isContentLoaded : Boolean;
		/**
		 *  @private
		 */
		private var brokenImage : Boolean;
		/**
		 *  @private
		 */
		private var resizableContent : Boolean;
		/**
		 *  @private
		 */
		private var flexContent : Boolean;
		/**
		 *  @private
		 */
		private var contentRequestID : String;
		/**
		 *  @private
		 */
		private var attemptingChildAppDomain : Boolean;
		/**
		 *  @private
		 */
		private var requestedURL : URLRequest;
		/**
		 *  @private
		 */
		private var brokenImageBorder : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var explicitLoaderContext : Boolean;
		/**
		 *  @private
		 */
		private var mouseShield : Sprite;
		/**
		 *  @private     *      *  When unloading a swf, check this flag to see if we     *  should use unload() or unloadAndStop().
		 */
		private var useUnloadAndStop : Boolean;
		/**
		 *  @private     *      *  When using unloadAndStop, pass this flag     *  as the gc parameter.
		 */
		private var unloadAndStopGC : Boolean;
		/**
		 *  @private     *  Storage for the autoLoad property.
		 */
		private var _autoLoad : Boolean;
		/**
		 *  @private     *  Storage for the loadForCompatibility property.
		 */
		private var _loadForCompatibility : Boolean;
		/**
		 *  @private     *  Storage for the autoLoad property.
		 */
		private var _bytesLoaded : Number;
		/**
		 *  @private     *  Storage for the bytesTotal property.
		 */
		private var _bytesTotal : Number;
		/**
		 *  @private     *  Storage for the loaderContext property.
		 */
		private var _loaderContext : LoaderContext;
		/**
		 *  @private     *  Storage for the maintainAspectRatio property.
		 */
		private var _maintainAspectRatio : Boolean;
		private var _swfBridge : IEventDispatcher;
		/**
		 *  @private     *  Storage for the scaleContent property.
		 */
		private var _scaleContent : Boolean;
		/**
		 *  @private     *  Storage for the scaleContent property.
		 */
		private var _showBusyCursor : Boolean;
		/**
		 *  @private     *  Storage for the source property.
		 */
		private var _source : Object;
		/**
		 *  @private     *  Storage for the trustContent property.
		 */
		private var _trustContent : Boolean;

		/**
		 *  @private     *  The baselinePosition of a SWFLoader is calculated     *  the same as for a generic UIComponent.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  A flag that indicates whether content starts loading automatically     *  or waits for a call to the <code>load()</code> method.     *  If <code>true</code>, the content loads automatically.      *  If <code>false</code>, you must call the <code>load()</code> method.     *     *  @default true
		 */
		public function get autoLoad () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLoad (value:Boolean) : void;
		/**
		 *  A flag that indicates whether the content is loaded so that it can     *  interoperate with applications built with a different verion of the Flex compiler.       *  Compatibility with other Flex applications is accomplished by loading     *  the application into a sibling (or peer) ApplicationDomain.     *  This flag is ignored if the content must be loaded into a different     *  SecurityDomain.     *  If <code>true</code>, the content loads into a sibling ApplicationDomain.      *  If <code>false</code>, the content loaded into a child ApplicationDomain.     *     *  @default false
		 */
		public function get loadForCompatibility () : Boolean;
		/**
		 *  @private
		 */
		public function set loadForCompatibility (value:Boolean) : void;
		/**
		 *  The number of bytes of the SWF or image file already loaded.
		 */
		public function get bytesLoaded () : Number;
		/**
		 *  The total size of the SWF or image file.
		 */
		public function get bytesTotal () : Number;
		/**
		 *  This property contains the object that represents     *  the content that was loaded in the SWFLoader control.      *     *  @tiptext Returns the content of the SWFLoader.     *  @helpid 3134
		 */
		public function get content () : DisplayObject;
		/**
		 *  Height of the scaled content loaded by the control, in pixels.      *  Note that this is not the height of the control itself, but of the      *  loaded content. Use the <code>height</code> property of the control     *  to obtain its height.     *     *  <p>The value of this property is not final when the <code>complete</code> event is triggered.      *  You can get the value after the <code>updateComplete</code> event is triggered.</p>     *     *  @default NaN
		 */
		public function get contentHeight () : Number;
		/**
		 *  @private
		 */
		private function get contentHolderHeight () : Number;
		/**
		 *  @private
		 */
		private function get contentHolderWidth () : Number;
		/**
		 *  Width of the scaled content loaded by the control, in pixels.      *  Note that this is not the width of the control itself, but of the      *  loaded content. Use the <code>width</code> property of the control     *  to obtain its width.     *     *  <p>The value of this property is not final when the <code>complete</code> event is triggered.      *  You can get the value after the <code>updateComplete</code> event is triggered.</p>     *     *  @default NaN
		 */
		public function get contentWidth () : Number;
		/**
		 *  A LoaderContext object to use to control loading of the content.     *  This is an advanced property.      *  Most of the time you can use the <code>trustContent</code> property.     *     *  <p>The default value is <code>null</code>, which causes the control     *  to use the <code>trustContent</code> property to create     *  a LoaderContext object, which you can read back     *  after the load starts.</p>     *     *  <p>To use a custom LoaderContext object, you must understand the      *  SecurityDomain and ApplicationDomain classes.     *  Setting this property will not start a load;     *  you must set this before the load starts.     *  This does not mean that you have to set <code>autoLoad</code> property     *  to <code>false</code>, because the load does not actually start     *  immediately, but waiting for the <code>creationComplete</code> event      *  to set it is too late.</p>     *     *  @default null     *  @see flash.system.LoaderContext     *  @see flash.system.ApplicationDomain     *  @see flash.system.SecurityDomain
		 */
		public function get loaderContext () : LoaderContext;
		/**
		 *  @private
		 */
		public function set loaderContext (value:LoaderContext) : void;
		/**
		 *  A flag that indicates whether to maintain the aspect ratio     *  of the loaded content.     *  If <code>true</code>, specifies to display the image with the same ratio of     *  height to width as the original image.     *     *  @default true
		 */
		public function get maintainAspectRatio () : Boolean;
		/**
		 *  @private
		 */
		public function set maintainAspectRatio (value:Boolean) : void;
		/**
		 *  The percentage of the image or SWF file already loaded.     *     *  @default 0
		 */
		public function get percentLoaded () : Number;
		/**
		 *  A flag that indicates whether to scale the content to fit the     *  size of the control or resize the control to the content's size.     *  If <code>true</code>, the content scales to fit the SWFLoader control.     *  If <code>false</code>, the SWFLoader scales to fit the content.      *     *  @default true
		 */
		public function get scaleContent () : Boolean;
		/**
		 *  @private
		 */
		public function set scaleContent (value:Boolean) : void;
		/**
		 *  A flag that indicates whether to show a busy cursor while     *  the content loads.     *  If <code>true</code>, shows a busy cursor while the content loads.     *  The default busy cursor is the mx.skins.halo.BusyCursor     *  as defined by the <code>busyCursor</code> property of the CursorManager class.     *     *  @default false     *     *  @see mx.managers.CursorManager
		 */
		public function get showBusyCursor () : Boolean;
		/**
		 *  @private
		 */
		public function set showBusyCursor (value:Boolean) : void;
		/**
		 *  The URL, object, class or string name of a class to     *  load as the content.     *  The <code>source</code> property takes the following form:     *     *  <p><pre>     *  <code>source="<i>URLOrPathOrClass</i>"</code></pre></p>     *     *  <p><pre>     *  <code>source="&#64;Embed(source='<i>PathOrClass</i>')"</code></pre></p>     *     *  <p>The value of the <code>source</code> property represents      *  a relative or absolute URL; a ByteArray representing a      *  SWF, GIF, JPEG, or PNG; an object that implements      *  IFlexDisplayObject; a class whose type implements IFlexDisplayObject;     *  or a String that represents a class. </p>      *     *  <p>When you specify a path to a SWF, GIF, JPEG, PNG, or SVG file,     *  Flex automatically converts the file to the correct data type      *  for use with the SWFLoader control.</p>      *     *  <p>If you omit the Embed statement, Flex loads the referenced file at runtime;      *  it is not packaged as part of the generated SWF file.      *  At runtime, the <code>source</code> property only supports the loading of     *  GIF, JPEG, PNG images, and SWF files.</p>     *     *  <p>Flex Data Services users can use the SWFLoader control to      *  load a Flex application by using the following form:</p>     *     *  <p><pre>     *  <code>source="<i>MXMLPath</i>.mxml.swf"</code></pre></p>     *     *  <p>Flex Data Services compiles the MXML file,      *  and returns the SWF file to the main application. This technique works well      *  with SWF files that add graphics or animations to an application,      *  but are not intended to have a large amount of user interaction.      *  If you import SWF files that require a large amount of user interaction,      *  you should build them as custom components. </p>     *     *  @default null
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;
		/**
		 *  If <code>true</code>, the content is loaded     *  into your security domain.     *  This means that the load fails if the content is in another domain     *  and that domain does not have a crossdomain.xml file allowing your     *  domain to access it.      *  This property only has an affect on the next load,     *  it will not start a new load on already loaded content.     *     *  <p>The default value is <code>false</code>, which means load     *  any content without failing, but you cannot access the content.     *  Most importantly, the loaded content cannot      *  access your objects and code, which is the safest scenario.     *  Do not set this property to <code>true</code> unless you are absolutely sure of the safety     *  of the loaded content, especially active content like SWF files.</p>     *     *  <p>You can also use the <code>loaderContext</code> property     *  to exactly determine how content gets loaded,     *  if setting <code>trustContent</code> does not exactly     *  meet your needs.      *  The <code>loaderContext</code> property causes the SWFLoader     *  to ignore the value of the <code>trustContent</code> property.     *  But, you should be familiar with the SecurityDomain     *  and ApplicationDomain classes to use the <code>loaderContext</code> property.</p>     *     *  @default false     *  @see flash.system.SecurityDomain     *  @see flash.system.ApplicationDomain
		 */
		public function get trustContent () : Boolean;
		/**
		 *  @private
		 */
		public function set trustContent (value:Boolean) : void;
		/**
		 * @inheritDoc
		 */
		public function get swfBridge () : IEventDispatcher;
		/**
		 * @inheritDoc
		 */
		public function get childAllowsParent () : Boolean;
		/**
		 * @inheritDoc
		 */
		public function get parentAllowsChild () : Boolean;

		/**
		 *  Constructor.
		 */
		public function SWFLoader ();
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
		 *  Loads an image or SWF file.     *  The <code>url</code> argument can reference a GIF, JPEG, PNG,     *  or SWF file; you cannot use this method to load an SVG file.     *  Instead,  you must load it using an Embed statement     *  with the <code>source</code> property.     *     *  @param url Absolute or relative URL of the GIF, JPEG, PNG,     *  or SWF file to load.
		 */
		public function load (url:Object = null) : void;
		/**
		 *  Unloads an image or SWF file. After this method returns the      *  <code>source</code> property will be null. This is only supported     *  if the host Flash Player is version 10 or greater. If the host Flash      *  Player is less than version 10, then this method will unload the      *  content the same way as if <code>source</code> was set to null.      *      *  This method attempts to unload SWF files by removing references to      *  EventDispatcher, NetConnection, Timer, Sound, or Video objects of the     *  child SWF file. As a result, the following occurs for the child SWF file     *  and the child SWF file's display list:      *  <ul>     *  <li>Sounds are stopped.</li>     *  <li>Stage event listeners are removed.</li>     *  <li>Event listeners for <code>enterFrame</code>,      *  <code>frameConstructed</code>, <code>exitFrame</code>,     *  <code>activate</code> and <code>deactivate</code> are removed.</li>     *  <li>Timers are stopped.</li>     *  <li>Camera and Microphone instances are detached</li>     *  <li>Movie clips are stopped.</li>     *  </ul>     *      *  @param invokeGarbageCollector (default = <code>true</code>)     *  <code></code> &mdash; Provides a hint to the garbage collector to run     *  on the child SWF objects (<code>true</code>) or not (<code>false</code>).     *  If you are unloading many objects asynchronously, setting the      *  <code>gc</code> parameter to <code>false</code> might improve application     *  performance. However, if the parameter is set to <code>false</code>, media     *  and display objects of the child SWF file might persist in memory after     *  the child SWF has been unloaded.
		 */
		public function unloadAndStop (invokeGarbageCollector:Boolean = true) : void;
		/**
		 *  @inheritDoc
		 */
		public function getVisibleApplicationRect (allApplications:Boolean = false) : Rectangle;
		/**
		 *  @private     *  If changes are made to this method, make sure to look at     *  RectangularBorder.updateDisplayList()     *  to see if changes are needed there as well.
		 */
		private function loadContent (classOrString:Object) : DisplayObject;
		/**
		 *  @private     *  Called when the content has successfully loaded.
		 */
		private function contentLoaded () : void;
		/**
		 *  @private     *  If scaleContent = true then two situations arise:     *  1) the SWFLoader has explicitWidth/Height set so we     *  simply scale or resize the content to those dimensions; or     *  2) the SWFLoader doesn't have explicitWidth/Height.     *  In this case we should have had our measure() method called     *  which would set the measuredWidth/Height to that of the content,     *  and when we pass through this code we should just end up at scale = 1.0.
		 */
		private function doScaleContent () : void;
		/**
		 *  @private     *  If scaleContent = false then two situations arise:     *  1) the SWFLoader has been given explicitWidth/Height so we don't change     *  the size of the SWFLoader and simply place the content at 0,0     *  and don't scale it and clip it if needed; or     *  2) the SWFLoader does not have explicitWidth/Height in which case     *  our measure() method should have been called and we should have     *  been given the right size.     *  However if some other constraint applies we simply clip as in     *  situation #1, which is why there is only one code path in here.
		 */
		private function doScaleLoader () : void;
		/**
		 *  @private
		 */
		private function unScaleContent () : void;
		/**
		 *  @private
		 */
		private function getHorizontalAlignValue () : Number;
		/**
		 *  @private
		 */
		private function getVerticalAlignValue () : Number;
		/**
		 *  @private     *       *  Dispatch an invalidate request to a parent application using     *  a sandbox bridge.
		 */
		private function dispatchInvalidateRequest (invalidateProperites:Boolean, invalidateSize:Boolean, invalidateDisplayList:Boolean) : void;
		/**
		 *  @private
		 */
		private function initializeHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function addedToStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function contentLoaderInfo_completeEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_httpStatusEventHandler (event:HTTPStatusEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_initEventHandler (event:Event) : void;
		/**
		 * If we are loading a swf, listen for a message from the swf telling us it was loading         * into an application domain where it needs to use a sandbox bridge to communicate.
		 */
		private function addInitSystemManagerCompleteListener (loaderInfo:LoaderInfo) : void;
		/**
		 * Remove the listener after the swf is loaded.
		 */
		private function removeInitSystemManagerCompleteListener (loaderInfo:LoaderInfo) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_ioErrorEventHandler (event:IOErrorEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_openEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_progressEventHandler (event:ProgressEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_securityErrorEventHandler (event:SecurityErrorEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_unloadEventHandler (event:Event) : void;
		/**
		 *      @private         *          *      Message dispatched from System Manager. This gives us the child bridge         *  of the application we loaded.
		 */
		private function initSystemManagerCompleteEventHandler (event:Event) : void;
		/**
		 *  @private     *      *  Handle invalidate requests send from the child using the     *  sandbox bridge.      *
		 */
		private function invalidateRequestHandler (event:Event) : void;
		/**
		 *      @private         *          *      Put up or takedown a mouseshield that covers the content         *  of the application we loaded.
		 */
		private function mouseShieldHandler (event:Event) : void;
		/**
		 *      @private         *          *      size the shield if needed
		 */
		private function sizeShield () : void;
		/**
		 *  @private     *      *  Just push this change, wholesale, onto the loaded content, if the     *  content is another Flex SWF
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private     *      *  Just push this change, wholesale, onto the loaded content, if the     *  content is another Flex SWF
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		private function getContentSize () : Point;
	}
}
