package mx.core
{
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowResize;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import mx.controls.Button;
	import mx.controls.FlexNativeMenu;
	import mx.core.windowClasses.StatusBar;
	import mx.core.windowClasses.TitleBar;
	import mx.events.AIREvent;
	import mx.events.FlexEvent;
	import mx.events.FlexNativeWindowBoundsEvent;
	import mx.managers.CursorManagerImpl;
	import mx.managers.FocusManager;
	import mx.managers.ICursorManager;
	import mx.managers.ISystemManager;
	import mx.managers.WindowedSystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when this application gets activated. * *  @eventType mx.events.AIREvent.APPLICATION_ACTIVATE
	 */
	[Event(name="applicationActivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched when this application gets deactivated. * *  @eventType mx.events.AIREvent.APPLICATION_DEACTIVATE
	 */
	[Event(name="applicationDeactivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after the window has been activated. * *  @eventType mx.events.AIREvent.WINDOW_ACTIVATE
	 */
	[Event(name="windowActivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after the window has been deactivated. * *  @eventType mx.events.AIREvent.WINDOW_DEACTIVATE
	 */
	[Event(name="windowDeactivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after the window has been closed. * *  @eventType flash.events.Event.CLOSE * *  @see flash.display.NativeWindow
	 */
	[Event(name="close", type="flash.events.Event")] 
	/**
	 *  Dispatched before the window closes. *  This event is cancelable. * *  @eventType flash.events.Event.CLOSING * *  @see flash.display.NativeWindow
	 */
	[Event(name="closing", type="flash.events.Event")] 
	/**
	 *  Dispatched after the display state changes *  to minimize, maximize or restore. * *  @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE
	 */
	[Event(name="displayStateChange", type="flash.events.NativeWindowDisplayStateEvent")] 
	/**
	 *  Dispatched before the display state changes *  to minimize, maximize or restore. * *  @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING
	 */
	[Event(name="displayStateChanging", type="flash.events.NativeWindowDisplayStateEvent")] 
	/**
	 *  Dispatched before the window moves, *  and while the window is being dragged. * *  @eventType flash.events.NativeWindowBoundsEvent.MOVING
	 */
	[Event(name="moving", type="flash.events.NativeWindowBoundsEvent")] 
	/**
	 *  Dispatched when the computer connects to or disconnects from the network. * *	@eventType flash.events.Event.NETWORK_CHANGE
	 */
	[Event(name="networkChange", type="flash.events.Event")] 
	/**
	 *  Dispatched before the underlying NativeWindow is resized, or *  while the Window object boundaries are being dragged. * *  @eventType flash.events.NativeWindowBoundsEvent.RESIZING
	 */
	[Event(name="resizing", type="flash.events.NativeWindowBoundsEvent")] 
	/**
	 *  Dispatched when the Window completes its initial layout *  and opens the underlying NativeWindow. * *  @eventType mx.events.AIREvent.WINDOW_COMPLETE
	 */
	[Event(name="windowComplete", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after the window moves. * *  @eventType mx.events.FlexNativeWindowBoundsEvent.WINDOW_MOVE
	 */
	[Event(name="windowMove", type="mx.events.FlexNativeWindowBoundsEvent")] 
	/**
	 *  Dispatched after the underlying NativeWindow is resized. * *  @eventType mx.events.FlexNativeWindowBoundsEvent.WINDOW_RESIZE
	 */
	[Event(name="windowResize", type="mx.events.FlexNativeWindowBoundsEvent")] 
	/**
	 *  Position of buttons in title bar. Possible values: <code>"left"</code>, *  <code>"right"</code>, <code>"auto"</code>. * *  <p>A value of <code>"left"</code> means the buttons are aligned *  at the left of the title bar. *  A value of <code>"right"</code> means the buttons are aligned *  at the right of the title bar. *  A value of <code>"auto"</code> means the buttons are aligned *  at the left of the title bar on Mac OS X and on the *  right on Windows.</p> * *  @default "auto"
	 */
	[Style(name="buttonAlignment", type="String", enumeration="left,right,auto", inherit="yes")] 
	/**
	 *  Defines the distance between the titleBar buttons. * *  @default 2
	 */
	[Style(name="buttonPadding", type="Number", inherit="yes")] 
	/**
	 *  Skin for close button when using Flex chrome. * *  @default mx.skins.halo.WindowCloseButtonSkin
	 */
	[Style(name="closeButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  The extra space around the gripper. The total area of the gripper *  plus the padding around the edges is the hit area for the gripper resizing. * *  @default 3
	 */
	[Style(name="gripperPadding", type="Number", format="Length", inherit="no")] 
	/**
	 *  Style declaration for the skin of the gripper. * *  @default "gripperStyle"
	 */
	[Style(name="gripperStyleName", type="String", inherit="no")] 
	/**
	 *  The explicit height of the header. If this style is not set, the header *  height is calculated from the largest of the text height, the button *  heights, and the icon height. * *  @default undefined
	 */
	[Style(name="headerHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Skin for maximize button when using Flex chrome. * *  @default mx.skins.halo.WindowMaximizeButtonSkin
	 */
	[Style(name="maximizeButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  Skin for minimize button when using Flex chrome. * *  @default mx.skins.halo.WindowMinimizeButtonSkin
	 */
	[Style(name="minimizeButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  Skin for restore button when using Flex chrome. *  This style is ignored for Mac OS X. * *  @default mx.skins.halo.WindowRestoreButtonSkin
	 */
	[Style(name="restoreButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  Determines whether the window draws its own Flex Chrome or depends on the developer *  to draw chrome. Changing this style once the window is open has no effect. * *  @default true
	 */
	[Style(name="showFlexChrome", type="Boolean", inherit="no")] 
	/**
	 *  The colors used to draw the status bar. * *  @default 0xC0C0C0
	 */
	[Style(name="statusBarBackgroundColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The status bar background skin. * *  @default mx.skins.halo.StatusBarBackgroundSkin
	 */
	[Style(name="statusBarBackgroundSkin", type="Class", inherit="yes")] 
	/**
	 *  Style declaration for the status text. * *  @default undefined
	 */
	[Style(name="statusTextStyleName", type="String", inherit="yes")] 
	/**
	 *  Position of the title in title bar. *  The possible values are <code>"left"</code>, *  <code>"center"</code>, <code>"auto"</code> * *  <p>A value of <code>"left"</code> means the title is aligned *  at the left of the title bar. *  A value of <code>"center"</code> means the title is aligned *  at the center of the title bar. *  A value of <code>"auto"</code> means the title is aligned *  at the left on Windows and at the center on Mac OS X.</p> * *  @default "auto"
	 */
	[Style(name="titleAlignment", type="String", enumeration="left,center,auto", inherit="yes")] 
	/**
	 *  The title background skin. * *  @default mx.skins.halo.ApplicationTitleBarBackgroundSkin
	 */
	[Style(name="titleBarBackgroundSkin", type="Class", inherit="yes")] 
	/**
	 *  The distance between the furthest out title bar button and the *  edge of the title bar. * *  @default 5
	 */
	[Style(name="titleBarButtonPadding", type="Number", inherit="true")] 
	/**
	 *  An array of two colors used to draw the header. *  The first color is the top color. *  The second color is the bottom color. *  The default values are <code>undefined</code>, which *  makes the header background the same as the *  panel background. * *  @default [ 0x000000, 0x000000 ]
	 */
	[Style(name="titleBarColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  The style name for the title text. * *  @default undefined
	 */
	[Style(name="titleTextStyleName", type="String", inherit="yes")] 

	/**
	 *  The Window is a top-level container for additional windows *  in an AIR desktop application. * *  <p>The Window container is a special kind of container in the sense *  that it cannot be used within other layout containers. An mx:Window *  component must be the top-level component in its MXML document.</p> * *  <p>The easiest way to use a Window component to define a native window is to *  create an MXML document with an <code>&lt;mx:Window&gt;</code> tag *  as the top-level tag in the document. You use the Window component *  just as you do any other container, including specifying the layout *  type, defining child controls, and so forth. Like any other custom *  MXML component, when your application is compiled your MXML document *  is compiled into a custom class that is a subclass of the Window *  component.</p> * *  <p>In your application code, to make an instance of *  your Window subclass appear on the screen you first create an instance *  of the class in code (by defining a variable and calling the <code>new *  MyWindowClass()</code> constructor. Next you set any properties you wish *  to specify for the new window. Finally you call your Window component's *  <code>open()</code> method to open the window on the screen.</p> * *  <p>Note that several of the Window class's properties can only be set *  <strong>before</strong> calling the <code>open()</code> method to open *  the window. Once the underlying NativeWindow is created, these initialization *  properties can be read but cannot be changed. This restriction applies to *  the following properties:</p> * *  <ul> *    <li><code>maximizable</code></li> *    <li><code>minimizable</code></li> *    <li><code>resizable</code></li> *    <li><code>systemChrome</code></li> *    <li><code>transparent</code></li> *    <li><code>type</code></li> *  </ul> * *  @mxml * *  <p>The <code>&lt;mx:Window&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:Window *    <strong>Properties</strong> *    alwaysInFront="false" *    height="100" *    maxHeight="10000" *    maximizable="true" *    maxWidth="10000" *    menu="<i>null</i>" *    minHeight="0" *    minimizable="true" *    minWidth="0" *    resizable="true" *    showGripper="true" *    showStatusBar="true" *    showTitleBar="true" *    status="" *    statusBarFactory="mx.core.ClassFactory" *    systemChrome="standard" *    title="" *    titleBarFactory="mx.core.ClassFactory" *    titleIcon="<i>null</i>" *    transparent="false" *    type="normal" *    visible="true" *    width="100" *  *    <strong>Styles</strong> *    buttonAlignment="auto" *    buttonPadding="2" *    closeButtonSkin="mx.skins.halo.windowCloseButtonSkin" *    gripperPadding="3" *    gripperStyleName="gripperStyle" *    headerHeight="<i>undefined</i>" *    maximizeButtonSkin="mx.skins.halo.WindowMaximizeButtonSkin" *    minimizeButtonSkin="mx.skins.halo.WindowMinimizeButtonSkin" *    restoreButtonSkin="mx.skins.halo.WindowRestoreButtonSkin" *    showFlexChrome="true" *    statusBarBackgroundColor="0xC0C0C0" *    statusBarBackgroundSkin="mx.skins.halo.StatusBarBackgroundSkin" *    statusTextStyleName="<i>undefined</i>" *    titleAlignment="auto" *    titleBarBackgroundSkin="mx.skins.halo.ApplicationTitleBarBackgroundSkin" *    titleBarButtonPadding="5" *    titleBarColors="[ 0x000000, 0x000000 ]" *    titleTextStyleName="<i>undefined</i>" *  *    <strong>Effects</strong> *    closeEffect="<i>No default</i>" *    minimizeEffect="<i>No default</i>" *    unminimizeEffect="<i>No default</i>" *  *    <strong>Events</strong> *    applicationActivate="<i>No default</i>" *    applicationDeactivate="<i>No default</i>" *    closing="<i>No default</i>" *    displayStateChange="<i>No default</i>" *    displayStateChanging="<i>No default</i>" *    moving="<i>No default</i>" *    networkChange="<i>No default</i>" *    resizing="<i>No default</i>" *    windowComplete="<i>No default</
	 */
	public class Window extends LayoutContainer implements IWindow
	{
		/**
		 *  @private
		 */
		private static const HEADER_PADDING : Number = 4;
		/**
		 *  @private
		 */
		private static const MOUSE_SLACK : Number = 5;
		/**
		 *  The default height for a window (SDK-14399)      *  @private
		 */
		private static const DEFAULT_WINDOW_HEIGHT : Number = 100;
		/**
		 *  The default width for a window (SDK-14399)      *  @private
		 */
		private static const DEFAULT_WINDOW_WIDTH : Number = 100;
		/**
		 *  @private
		 */
		private var _nativeWindow : NativeWindow;
		/**
		 *  @private
		 */
		private var _nativeWindowVisible : Boolean;
		/**
		 *  @private
		 */
		private var maximized : Boolean;
		/**
		 *  @private
		 */
		private var _cursorManager : ICursorManager;
		/**
		 *  @private
		 */
		private var toMax : Boolean;
		/**
		 *  @private
		 */
		private var appViewMetrics : EdgeMetrics;
		/**
		 *  @private     *  Ensures that the Window has finished drawing     *  before it becomes visible.
		 */
		private var frameCounter : int;
		/**
		 *  @private
		 */
		private var gripper : Button;
		/**
		 *  @private
		 */
		private var gripperHit : Sprite;
		/**
		 *  @private
		 */
		private var flagForOpen : Boolean;
		/**
		 *   @private
		 */
		private var openActive : Boolean;
		/**
		 *  @private     *  A reference to this Application's title bar skin.     *  This is a child of the titleBar.
		 */
		local var titleBarBackground : IFlexDisplayObject;
		/**
		 *  @private     *  A reference to this Application's status bar skin.     *  This is a child of the statusBar.
		 */
		local var statusBarBackground : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var oldX : Number;
		/**
		 *  @private
		 */
		private var oldY : Number;
		/**
		 *  @private
		 */
		private var prevX : Number;
		/**
		 *  @private
		 */
		private var prevY : Number;
		/**
		 *  @private
		 */
		private var resizeHandlerAdded : Boolean;
		/**
		 *  @private     *  This flag indicates whether the width of the Application instance     *  can change or has been explicitly set by the developer.     *  When the stage is resized we use this flag to know whether the     *  width of the Application should be modified.
		 */
		private var resizeWidth : Boolean;
		/**
		 *  @private     *  This flag indicates whether the height of the Application instance     *  can change or has been explicitly set by the developer.     *  When the stage is resized we use this flag to know whether the     *  height of the Application should be modified.
		 */
		private var resizeHeight : Boolean;
		/**
		 *  @private	 *  Storage for the maxHeight property.
		 */
		private var _maxHeight : Number;
		/**
		 *  @private	 *  Keeps track of whether maxHeight property changed so we can	 *  handle it in commitProperties.
		 */
		private var maxHeightChanged : Boolean;
		/**
		 *  @private	 *  Storage for the maxWidth property.
		 */
		private var _maxWidth : Number;
		/**
		 *  @private	 *  Keeps track of whether maxWidth property changed so we can	 *  handle it in commitProperties.
		 */
		private var maxWidthChanged : Boolean;
		/**
		 *  @private
		 */
		private var _minHeight : Number;
		/**
		 *  @private	 *  Keeps track of whether minHeight property changed so we can	 *  handle it in commitProperties.
		 */
		private var minHeightChanged : Boolean;
		/**
		 *  @private	 *  Storage for the minWidth property.
		 */
		private var _minWidth : Number;
		/**
		 *  @private	 *  Keeps track of whether minWidth property changed so we can	 *  handle it in commitProperties.
		 */
		private var minWidthChanged : Boolean;
		/**
		 *  @private	 *  Storage for the alwaysInFront property.
		 */
		private var _alwaysInFront : Boolean;
		/**
		 *  @private     *  Storage for the bounds property.
		 */
		private var _bounds : Rectangle;
		/**
		 *  @private
		 */
		private var boundsChanged : Boolean;
		/**
		 *  The ApplicationControlBar for this Window.     *     *  @see mx.containers.ApplicationControlBar     *  @default null
		 */
		public var controlBar : IUIComponent;
		/**
		 *  @private	 *  Storage for the maximizable property.
		 */
		private var _maximizable : Boolean;
		/**
		 *  @private	 *  Storage for the menu property.
		 */
		private var _menu : FlexNativeMenu;
		/**
		 *  @private
		 */
		private var menuChanged : Boolean;
		/**
		 *  @private	 *  Storage for the minimizable property.
		 */
		private var _minimizable : Boolean;
		/**
		 *  @private	 *  Storage for the resizable property.
		 */
		private var _resizable : Boolean;
		/**
		 *  @private     *  Storage for the showGripper property.
		 */
		private var _showGripper : Boolean;
		/**
		 *  @private
		 */
		private var showGripperChanged : Boolean;
		/**
		 *  Storage for the showStatusBar property.
		 */
		private var _showStatusBar : Boolean;
		/**
		 *  @private
		 */
		private var showStatusBarChanged : Boolean;
		/**
		 *  Storage for the showTitleBar property.
		 */
		private var _showTitleBar : Boolean;
		/**
		 *  @private
		 */
		private var showTitleBarChanged : Boolean;
		/**
		 *  @private	 *  Storage for the status property.
		 */
		private var _status : String;
		/**
		 *  @private
		 */
		private var statusChanged : Boolean;
		/**
		 *  @private     *  Storage for the statusBar property.
		 */
		private var _statusBar : UIComponent;
		/**
		 *  @private	 *  Storage for the statusBarFactory property
		 */
		private var _statusBarFactory : IFactory;
		/**
		 *  @private
		 */
		private var statusBarFactoryChanged : Boolean;
		private static var _statusBarStyleFilters : Object;
		/**
		 *  @private	 *  Storage for the systemChrome property.
		 */
		private var _systemChrome : String;
		/**
		 *  @private     *  Storage for the title property.
		 */
		private var _title : String;
		/**
		 *  @private
		 */
		private var titleChanged : Boolean;
		/**
		 *  @private     *  Storage for the titleBar property.
		 */
		private var _titleBar : UIComponent;
		/**
		 *  @private	 *  Storage for the titleBarFactory property
		 */
		private var _titleBarFactory : IFactory;
		/**
		 *  @private
		 */
		private var titleBarFactoryChanged : Boolean;
		private static var _titleBarStyleFilters : Object;
		/**
		 *  @private     *  Storage for the titleIcon property.
		 */
		private var _titleIcon : Class;
		/**
		 *  @private
		 */
		private var titleIconChanged : Boolean;
		/**
		 *  @private	 *  Storage for the transparent property.
		 */
		private var _transparent : Boolean;
		/**
		 *  @private	 *  Storage for the type property.
		 */
		private var _type : String;

		/**
		 *  @private
		 */
		public function get height () : Number;
		/**
		 *  @private	 *  Also sets the stage's height.
		 */
		public function set height (value:Number) : void;
		/**
		 *  @private
		 */
		public function get maxHeight () : Number;
		/**
		 *  Specifies the maximum height of the application's window.
		 */
		public function set maxHeight (value:Number) : void;
		/**
		 *  @private
		 */
		public function get maxWidth () : Number;
		/**
		 *  Specifies the maximum width of the application's window.
		 */
		public function set maxWidth (value:Number) : void;
		/**
		 *  Specifies the minimum height of the application's window.
		 */
		public function get minHeight () : Number;
		/**
		 *  @private
		 */
		public function set minHeight (value:Number) : void;
		/**
		 *  Specifies the minimum width of the application's window.
		 */
		public function get minWidth () : Number;
		/**
		 *  @private
		 */
		public function set minWidth (value:Number) : void;
		/**
		 *  Controls the window's visibility. Unlike the	 *  <code>UIComponent.visible</code> property of most Flex	 *  visual components, this property affects the visibility	 *  of the underlying NativeWindow (including operating system	 *  chrome) as well as the visibility of the Window's child	 *  controls.	 *	 *  <p>When this property changes, Flex dispatches a <code>show</code>	 *  or <code>hide</code> event.</p>	 *	 *  @default true
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get width () : Number;
		/**
		 *  @private	 *  Also sets the stage's width.
		 */
		public function set width (value:Number) : void;
		/**
		 *  @private
		 */
		public function get viewMetrics () : EdgeMetrics;
		/**
		 *  Determines whether the underlying NativeWindow is always in front	 *  of other windows (including those of other applications). Setting	 *  this property sets the <code>alwaysInFront</code> property of the	 *  underlying NativeWindow. See the <code>NativeWindow.alwaysInFront</code>	 *  property description for details of how this affects window stacking	 *  order.	 *	 *  @see flash.display.NativeWindow#alwaysInFront
		 */
		public function get alwaysInFront () : Boolean;
		/**
		 *  @private
		 */
		public function set alwaysInFront (value:Boolean) : void;
		/**
		 *  @private     *  A Rectangle specifying the window's bounds	 *  relative to the screen.
		 */
		protected function get bounds () : Rectangle;
		/**
		 *  @private
		 */
		protected function set bounds (value:Rectangle) : void;
		/**
		 *  A flag indicating whether the window has been closed.
		 */
		public function get closed () : Boolean;
		/**
		 *  Specifies whether the window can be maximized.	 *  This property's value is read-only after the window	 *  has been opened.
		 */
		public function get maximizable () : Boolean;
		/**
		 *  @private
		 */
		public function set maximizable (value:Boolean) : void;
		/**
		 *  Returns the cursor manager for this Window.
		 */
		public function get cursorManager () : ICursorManager;
		/**
		 *  @private
		 */
		public function get menu () : FlexNativeMenu;
		/**
		 *  The window menu for this window.	 *  Some operating systems do not support window menus,	 *  in which case this property is ignored.
		 */
		public function set menu (value:FlexNativeMenu) : void;
		/**
		 *  Specifies whether the window can be minimized.	 *  This property is read-only after the window has	 *  been opened.
		 */
		public function get minimizable () : Boolean;
		/**
		 *  @private
		 */
		public function set minimizable (value:Boolean) : void;
		/**
		 *  The underlying NativeWindow that this Window component uses.
		 */
		public function get nativeWindow () : NativeWindow;
		/**
		 *  Specifies whether the window can be resized.	 *  This property is read-only after the window	 *  has been opened.
		 */
		public function get resizable () : Boolean;
		/**
		 *  @private
		 */
		public function set resizable (value:Boolean) : void;
		/**
		 *  If <code>true</code>, the gripper is visible.	 *     *  <p>On Mac OS X a window with <code>systemChrome</code>	 *  set to <code>"standard"</code>     *  always has an operating system gripper, so this property is ignored     *  in that case.</p>     *     *  @default true
		 */
		public function get showGripper () : Boolean;
		/**
		 *  @private
		 */
		public function set showGripper (value:Boolean) : void;
		/**
		 *  If <code>true</code>, the status bar is visible.     *     *  @default true
		 */
		public function get showStatusBar () : Boolean;
		/**
		 *  @private
		 */
		public function set showStatusBar (value:Boolean) : void;
		/**
		 *  If <code>true</code>, the window's title bar is visible.     *     *  @default true
		 */
		public function get showTitleBar () : Boolean;
		/**
		 *  @private
		 */
		public function set showTitleBar (value:Boolean) : void;
		/**
		 *  The string that appears in the status bar, if it is visible.     *     *  @default ""
		 */
		public function get status () : String;
		/**
		 *  @private
		 */
		public function set status (value:String) : void;
		/**
		 *  The UIComponent that displays the status bar.
		 */
		public function get statusBar () : UIComponent;
		/**
		 *  The IFactory that creates an instance to use     *  as the status bar.     *  The default value is an IFactory for StatusBar.     *     *  <p>If you write a custom status bar class, it should expose     *  a public property named <code>status</code>.</p>
		 */
		public function get statusBarFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set statusBarFactory (value:IFactory) : void;
		/**
		 *  Set of styles to pass from the window to the status bar.	 *     *  @see mx.styles.StyleProxy
		 */
		protected function get statusBarStyleFilters () : Object;
		/**
		 *  Specifies the type of system chrome (if any) the window has.	 *  The set of possible values is defined by the constants	 *  in the NativeWindowSystemChrome class.	 *	 *  <p>This property is read-only once the window has been opened.</p>	 *	 *  <p>The default value is <code>NativeWindowSystemChrome.STANDARD</code>.</p>	 *	 *  @see flash.display.NativeWindowSystemChrome	 *  @see flash.display.NativeWindowInitOptions#systemChrome
		 */
		public function get systemChrome () : String;
		/**
		 *  @private
		 */
		public function set systemChrome (value:String) : void;
		/**
		 *  The title text that appears in the window title bar and     *  the taskbar.     *     *  @default ""
		 */
		public function get title () : String;
		/**
		 *  @private
		 */
		public function set title (value:String) : void;
		/**
		 *  The UIComponent that displays the title bar.
		 */
		public function get titleBar () : UIComponent;
		/**
		 *  The IFactory that creates an instance to use     *  as the title bar.     *  The default value is an IFactory for TitleBar.     *     *  <p>If you write a custom title bar class, it should expose     *  public properties named <code>titleIcon</code>     *  and <code>title</code>.</p>
		 */
		public function get titleBarFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set titleBarFactory (value:IFactory) : void;
		/**
		 *  Set of styles to pass from the Window to the titleBar.	 *     *  @see mx.styles.StyleProxy
		 */
		protected function get titleBarStyleFilters () : Object;
		/**
		 *  The Class (usually an image) used to draw the title bar icon.     *     *  @default null
		 */
		public function get titleIcon () : Class;
		/**
		 *  @private
		 */
		public function set titleIcon (value:Class) : void;
		/**
		 *  Specifies whether the window is transparent. Setting this	 *  property to <code>true</code> for a window that uses	 *  system chrome is not supported.	 *	 *  <p>This property is read-only after the window has been opened.</p>
		 */
		public function get transparent () : Boolean;
		/**
		 *  @private
		 */
		public function set transparent (value:Boolean) : void;
		/**
		 *  Specifies the type of NativeWindow that this component	 *  represents. The set of possible values is defined by the constants	 *  in the NativeWindowType class.	 *	 *  <p>This property is read-only once the window has been opened.</p>	 *	 *  <p>The default value is <code>NativeWindowType.NORMAL</code>.</p>	 *	 *  @see flash.display.NativeWindowType	 *  @see flash.display.NativeWindowInitOptions#type
		 */
		public function get type () : String;
		/**
		 *  @private
		 */
		public function set type (value:String) : void;

		/**
		 *  Returns the Window to which a component is parented.     *     *  @param component the component whose Window you wish to find.
		 */
		public static function getWindow (component:UIComponent) : Window;
		/**
		 *  Constructor.
		 */
		public function Window ();
		/**
		 *  @private
		 */
		public function initialize () : void;
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
		public function validateDisplayList () : void;
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
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  @private     *  Window also handles themeColor defined     *  on the global selector. (Stolen from Application)
		 */
		function initThemeColor () : Boolean;
		/**
		 *  Closes the window. This action is cancelable.
		 */
		public function close () : void;
		/**
		 *  @private     *  Returns the height of the header.
		 */
		private function getHeaderHeight () : Number;
		/**
		 *  @private     *  Returns the height of the statusBar.
		 */
		public function getStatusBarHeight () : Number;
		/**
		 *  @private
		 */
		private function initManagers (sm:ISystemManager) : void;
		/**
		 *  Maximizes the window, or does nothing if it's already maximized.
		 */
		public function maximize () : void;
		/**
		 *  Minimizes the window.
		 */
		public function minimize () : void;
		/**
		 *  Restores the window (unmaximizes it if it's maximized, or     *  unminimizes it if it's minimized).
		 */
		public function restore () : void;
		/**
		 *  Activates the underlying NativeWindow (even if this Window's application	 *  is not currently active).
		 */
		public function activate () : void;
		/**
		 *  Creates the underlying NativeWindow and opens it.     *     *  @param  openWindowActive specifies whether the Window opens     *  activated (that is, whether it has focus). The default value	 *  is <code>true</code>.
		 */
		public function open (openWindowActive:Boolean = true) : void;
		/**
		 *  Orders the window just behind another. To order the window behind     *  a NativeWindow that does not implement IWindow, use this window's     *  nativeWindow's <code>orderInBackOf()</code> method.     *     *  @param window The IWindow (Window or WindowedAplication)     *  to order this window behind.     *     *  @return <code>true</code> if the window was succesfully sent behind;     *          <code>false</code> if the window is invisible or minimized.
		 */
		public function orderInBackOf (window:IWindow) : Boolean;
		/**
		 *  Orders the window just in front of another. To order the window     *  in front of a NativeWindow that does not implement IWindow, use this     *  window's nativeWindow's  <code>orderInFrontOf()</code> method.     *     *  @param window The IWindow (Window or WindowedAplication)     *  to order this window in front of.     *     *  @return <code>true</code> if the window was succesfully sent in front;     *          <code>false</code> if the window is invisible or minimized.
		 */
		public function orderInFrontOf (window:IWindow) : Boolean;
		/**
		 *  Orders the window behind all others in the same application.     *     *  @return <code>true</code> if the window was succesfully sent to the back;     *  <code>false</code> if the window is invisible or minimized.
		 */
		public function orderToBack () : Boolean;
		/**
		 *  Orders the window in front of all others in the same application.     *     *  @return <code>true</code> if the window was succesfully sent to the front;     *  <code>false</code> if the window is invisible or minimized.
		 */
		public function orderToFront () : Boolean;
		/**
		 *  @private     *  Returns the width of the chrome for the window
		 */
		private function chromeWidth () : Number;
		/**
		 *  @private     *  Returns the height of the chrome for the window
		 */
		private function chromeHeight () : Number;
		/**
		 *  @private     *  Starts a system move.
		 */
		private function startMove (event:MouseEvent) : void;
		/**
		 *  @private     *  Starts a system resize.
		 */
		private function startResize (start:String) : void;
		/**
		 *  @private
		 */
		private function enterFrameHandler (e:Event) : void;
		/**
		 *  @private
		 */
		private function hideEffectEndHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function windowMinimizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function windowUnminimizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_moveHandler (event:NativeWindowBoundsEvent) : void;
		/**
		 *  @private
		 */
		private function window_displayStateChangeHandler (event:NativeWindowDisplayStateEvent) : void;
		/**
		 *  @private
		 */
		private function window_displayStateChangingHandler (event:NativeWindowDisplayStateEvent) : void;
		/**
		 *  @private
		 */
		private function windowMaximizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function windowUnmaximizeHandler (event:Event) : void;
		/**
		 *  Manages mouse down events on the window border.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function closeButton_clickHandler (event:Event) : void;
		/**
		 *  @private     *  Triggered by a resize event of the stage.     *  Sets the new width and height.     *  After the SystemManager performs its function,     *  it is only necessary to notify the children of the change.
		 */
		private function resizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function creationCompleteHandler (event:Event = null) : void;
		/**
		 *  @private
		 */
		private function preinitializeHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function window_boundsHandler (event:NativeWindowBoundsEvent) : void;
		/**
		 *  @private
		 */
		private function window_closeEffectEndHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_closingHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_closeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_resizeHandler (event:NativeWindowBoundsEvent) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_activateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_deactivateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeWindow_activateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeWindow_deactivateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_networkChangeHandler (event:Event) : void;
	}
}
