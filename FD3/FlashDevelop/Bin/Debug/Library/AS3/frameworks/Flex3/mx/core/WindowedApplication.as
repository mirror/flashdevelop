package mx.core
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowResize;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.FlexNativeMenu;
	import mx.controls.HTML;
	import mx.core.windowClasses.StatusBar;
	import mx.core.windowClasses.TitleBar;
	import mx.events.AIREvent;
	import mx.events.FlexEvent;
	import mx.events.FlexNativeWindowBoundsEvent;
	import mx.managers.DragManager;
	import mx.managers.NativeDragManagerImpl;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when this application is activated. * *  @eventType mx.events.AIREvent.APPLICATION_ACTIVATE
	 */
	[Event(name="applicationActivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched when this application is deactivated. * *  @eventType mx.events.AIREvent.APPLICATION_DEACTIVATE
	 */
	[Event(name="applicationDeactivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after this application window has been activated. * *  @eventType mx.events.AIREvent.WINDOW_ACTIVATE
	 */
	[Event(name="windowActivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after this application window has been deactivated. * *  @eventType mx.events.AIREvent.WINDOW_DEACTIVATE
	 */
	[Event(name="windowDeactivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after this application window has been closed. * *  @eventType flash.events.Event.CLOSE * *  @see flash.display.NativeWindow
	 */
	[Event(name="close", type="flash.events.Event")] 
	/**
	 *  Dispatched before the WindowedApplication window closes. *  Cancelable. * *  @eventType flash.events.Event.CLOSING * *  @see flash.display.NativeWindow
	 */
	[Event(name="closing", type="flash.events.Event")] 
	/**
	 *  Dispatched after the display state changes to minimize, maximize *  or restore. * *  @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE
	 */
	[Event(name="displayStateChange", type="flash.events.NativeWindowDisplayStateEvent")] 
	/**
	 *  Dispatched before the display state changes to minimize, maximize *  or restore. * *  @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING
	 */
	[Event(name="displayStateChanging", type="flash.events.NativeWindowDisplayStateEvent")] 
	/**
	 *  Dispatched when an application is invoked.
	 */
	[Event(name="invoke", type="flash.events.InvokeEvent")] 
	/**
	 *  Dispatched before the WindowedApplication object moves, *  or while the WindowedApplication object is being dragged. * *  @eventType flash.events.NativeWindowBoundsEvent.MOVING
	 */
	[Event(name="moving", type="flash.events.NativeWindowBoundsEvent")] 
	/**
	 *  Dispatched when the computer connects to or disconnects from the network. * *  @eventType flash.events.Event.NETWORK_CHANGE
	 */
	[Event(name="networkChange", type="flash.events.Event")] 
	/**
	 *  Dispatched before the WindowedApplication object is resized, *  or while the WindowedApplication object boundaries are being dragged. * *  @eventType flash.events.NativeWindowBoundsEvent.RESIZING
	 */
	[Event(name="resizing", type="flash.events.NativeWindowBoundsEvent")] 
	/**
	 *  Dispatched when the WindowedApplication completes its initial layout. *  By default, the WindowedApplication will be visbile at this time. * *  @eventType mx.events.AIREvent.WINDOW_COMPLETE
	 */
	[Event(name="windowComplete", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after the WindowedApplication object moves. * *  @eventType mx.events.FlexNativeWindowBoundsEvent.WINDOW_MOVE
	 */
	[Event(name="windowMove", type="mx.events.FlexNativeWindowBoundsEvent")] 
	/**
	 *  Dispatched after the underlying NativeWindow object is resized. * *  @eventType mx.events.FlexNativeWindowBoundsEvent.WINDOW_RESIZE
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
	 *  The status bar background skin. * *  @default mx.skins.halo.StatusBarBackgroundSkin
	 */
	[Style(name="statusBarBackgroundSkin", type="Class", inherit="yes")] 
	/**
	 *  The colors used to draw the status bar. * *  @default 0xC0C0C0
	 */
	[Style(name="statusBarBackgroundColor", type="uint", format="Color", inherit="yes")] 
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
	 *  The WindowedApplication defines the application container *  that you use to create Flex applications for AIR applications. * *  <p>The WindowedApplication serves two roles. It is a replacement for the &lt;mx:Application&gt; *  tag, functioning as the entry point to a Flex-based AIR application. In addition, *  as a container the WindowedApplication defines the layout of the initial window *  of a Flex AIR application -- any visual controls defined in the WindowedApplication *  become the content of the initial window loaded by the AIR application.</p> * *  <p>Note that because *  the WindowedApplication only represents the visual content of a single window, and not *  all the windows in a multi-window application, a WindowedApplication instance only dispatches *  display-related events (events that the WindowedApplication class inherits from display object base *  classes such as InteractiveObject or UIComponent) for its own stage and window, and not for *  events that occur on other windows in the application. This differs from a browser-based application, *  where an Application container dispatches events for all the windows in the application (because *  technically those windows are all display objects rendered on the single Application stage).</p> * *  @mxml * *  <p>The <code>&lt;mx:WindowedApplication&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:WindowedApplication *    <strong>Properties</strong> *    alwaysInFront="false" *    autoExit="true" *    dockIconMenu="<i>null</i>" *    maxHeight="10000" *    maxWidth="10000" *    menu="<i>null</i>" *    minHeight="100" *    minWidth="100" *    showGripper="true" *    showStatusBar="true" *    showTitleBar="true" *    status="" *    statusBarFactory="mx.core.ClassFactory" *    systemTrayIconMenu="<i>null</i>" *    title="" *    titleBarFactory="mx.core.ClassFactory" *    titleIcon="<i>null</i>" *  *    <strong>Styles</strong> *    buttonAlignment="auto" *    buttonPadding="2" *    closeButtonSkin="mx.skins.halo.windowCloseButtonSkin" *    gripperPadding="3" *    gripperStyleName="gripperStyle" *    headerHeight="<i>undefined</i>" *    maximizeButtonSkin="mx.skins.halo.WindowMaximizeButtonSkin" *    minimizeButtonSkin="mx.skins.halo.WindowMinimizeButtonSkin" *    restoreButtonSkin="mx.skins.halo.WindowRestoreButtonSkin" *    showFlexChrome="true" *    statusBarBackgroundColor="0xC0C0C0" *    statusBarBackgroundSkin="mx.skins.halo.StatusBarBackgroundSkin" *    statusTextStyleName="<i>undefined</i>" *    titleAlignment="auto" *    titleBarBackgroundSkin="mx.skins.halo.ApplicationTitleBarBackgroundSkin" *    titleBarButtonPadding="5" *    titleBarColors="[ 0x000000, 0x000000 ]" *    titleTextStyleName="<i>undefined</i>" *  *    <strong>Effects</strong> *    closeEffect="<i>No default</i>" *    minimizeEffect="<i>No default</i>" *    unminimizeEffect="<i>No default</i>" *  *    <strong>Events</strong> *    applicationActivate="<i>No default</i>" *    applicationDeactivate="<i>No default</i>" *    closing="<i>No default</i>" *    displayStateChange="<i>No default</i>" *    displayStateChanging="<i>No default</i>" *    invoke="<i>No default</i>" *    moving="<i>No default</i>" *    networkChange="<i>No default</i>" *    resizing="<i>No default</i>" *    windowComplete="<i>No default</i>" *    windowMove="<i>No default</i>" *    windowResize="<i>No default</i>" *  /&gt; *  </pre> *  *  @playerversion AIR 1.1
	 */
	public class WindowedApplication extends Application implements IWindow
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
		 *  @private     *  This is here to force linkage of NativeDragManagerImpl.
		 */
		private static var _forceLinkNDMI : NativeDragManagerImpl;
		/**
		 * @private
		 */
		private var _nativeWindow : NativeWindow;
		/**
		 *  @private
		 */
		private var _nativeWindowVisible : Boolean;
		/**
		 *  @private
		 */
		private var toMax : Boolean;
		/**
		 *  @private
		 */
		private var appViewMetrics : EdgeMetrics;
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
		private var _gripperPadding : Number;
		/**
		 *  @private
		 */
		private var initialInvokes : Array;
		/**
		 *  @private
		 */
		private var invokesPending : Boolean;
		/**
		 *  @private
		 */
		private var lastDisplayState : String;
		/**
		 *  @private
		 */
		private var shouldShowTitleBar : Boolean;
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
		private var windowBoundsChanged : Boolean;
		/**
		 *  @private     *  Determines whether the WindowedApplication opens in an active state.     *  If you are opening up other windows at startup that should be active,     *  this will ensure that the WindowedApplication does not steal focus.     *     *  @default true
		 */
		private var activateOnOpen : Boolean;
		/**
		 *  @private
		 */
		private var ucCount : Number;
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
		 *  @private	 *  Storage for the dockIconMenu property.
		 */
		private var _dockIconMenu : FlexNativeMenu;
		/**
		 *  @private	 *  Storage for the menu property.
		 */
		private var _menu : FlexNativeMenu;
		/**
		 *  @private
		 */
		private var menuChanged : Boolean;
		/**
		 *  @private     *  Storage for the showGripper property.
		 */
		private var _showGripper : Boolean;
		/**
		 *  @private
		 */
		private var showGripperChanged : Boolean;
		/**
		 *  @private	 *  Storage for the showStatusBar property.
		 */
		private var _showStatusBar : Boolean;
		/**
		 *  @private
		 */
		private var showStatusBarChanged : Boolean;
		/**
		 *  @private	 *  Storage for the showTitleBar property.
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
		 *  @private	 *  Storage for the systemTrayIconMenu property.
		 */
		private var _systemTrayIconMenu : FlexNativeMenu;
		/**
		 *  @private	 *  Storage for the title property.
		 */
		private var _title : String;
		/**
		 *  @private
		 */
		private var titleChanged : Boolean;
		/**
		 *  @private	 *  Storage for the titleBar property.
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
		 *  @private     *  A reference to this container's title icon.
		 */
		private var _titleIcon : Class;
		/**
		 *  @private
		 */
		private var titleIconChanged : Boolean;

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
		 *  @private	 *  Also sets the NativeWindow's visibility.
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
		 *  The identifier that AIR uses to identify the application.
		 */
		public function get applicationID () : String;
		/**
		 *  Determines whether the underlying NativeWindow is always in front of other windows.	 *	 *  @default false
		 */
		public function get alwaysInFront () : Boolean;
		/**
		 *  @private
		 */
		public function set alwaysInFront (value:Boolean) : void;
		/**
		 *  Specifies whether the AIR application will quit when the last     *  window closes or will continue running in the background.	 *	 *  @default true
		 */
		public function get autoExit () : Boolean;
		/**
		 *  @private
		 */
		public function set autoExit (value:Boolean) : void;
		/**
		 *  @private     *  Storage for the height and width
		 */
		protected function get bounds () : Rectangle;
		/**
		 *  @private
		 */
		protected function set bounds (value:Rectangle) : void;
		/**
		 *  Returns true when the underlying window has been closed.
		 */
		public function get closed () : Boolean;
		/**
		 *  The dock icon menu. Some operating systems do not support dock icon menus.
		 */
		public function get dockIconMenu () : FlexNativeMenu;
		/**
		 *  @private
		 */
		public function set dockIconMenu (value:FlexNativeMenu) : void;
		/**
		 *  Specifies whether the window can be maximized.
		 */
		public function get maximizable () : Boolean;
		/**
		 *  Specifies whether the window can be minimized.
		 */
		public function get minimizable () : Boolean;
		/**
		 *  The application menu for operating systems that support an application menu,	 *  or the window menu of the application's initial window for operating	 *  systems that support window menus.
		 */
		public function get menu () : FlexNativeMenu;
		/**
		 *  @private
		 */
		public function set menu (value:FlexNativeMenu) : void;
		/**
		 *  The NativeWindow used by this WindowedApplication component (the initial	 *  native window of the application).
		 */
		public function get nativeWindow () : NativeWindow;
		/**
		 *  Specifies whether the window can be resized.
		 */
		public function get resizable () : Boolean;
		/**
		 *  The NativeApplication object representing the AIR application.
		 */
		public function get nativeApplication () : NativeApplication;
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
		 *  Set of styles to pass from the WindowedApplication to the status bar.	 *     *  @see mx.styles.StyleProxy
		 */
		protected function get statusBarStyleFilters () : Object;
		/**
		 *  Specifies the type of system chrome (if any) the window has.	 *  The set of possible values is defined by the constants	 *  in the NativeWindowSystemChrome class.	 *	 *  @see flash.display.NativeWindow#systemChrome
		 */
		public function get systemChrome () : String;
		/**
		 *  The system tray icon menu. Some operating systems do not support system tray icon menus.
		 */
		public function get systemTrayIconMenu () : FlexNativeMenu;
		/**
		 *  @private
		 */
		public function set systemTrayIconMenu (value:FlexNativeMenu) : void;
		/**
		 *  The title that appears in the window title bar and     *  the taskbar.     *     *  If you are using system chrome and you set this property to something     *  different than the &lt;title&gt; tag in your application.xml,     *  you may see the title from the XML file appear briefly first.     *     *  @default ""
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
		 *  Set of styles to pass from the WindowedApplication to the titleBar.     *  @see mx.styles.StyleProxy
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
		 *  Specifies whether the window is transparent.
		 */
		public function get transparent () : Boolean;
		/**
		 *  Specifies the type of NativeWindow that this component	 *  represents. The set of possible values is defined by the constants	 *  in the NativeWindowType class.	 *	 *  @see flash.display.NativeWindowType
		 */
		public function get type () : String;

		/**
		 *  Constructor.
		 */
		public function WindowedApplication ();
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
		 *  @private     *  Called when the "View Source" item in the application's context menu     *  is selected.     *     *  Opens the window where AIR decides, sized to the parent application.     *  It will close when the parent WindowedApplication closes.
		 */
		protected function menuItemSelectHandler (event:Event) : void;
		/**
		 *  Activates the underlying NativeWindow (even if this application is not the active one).
		 */
		public function activate () : void;
		/**
		 *  Closes the application's NativeWindow (the initial native window opened by the application). This action is cancelable.
		 */
		public function close () : void;
		/**
		 *  Closes the window and exits the application.
		 */
		public function exit () : void;
		/**
		 *  @private     *  Returns the height of the header.
		 */
		private function getHeaderHeight () : Number;
		/**
		 *  @private     *  Returns the height of the statusBar.
		 */
		public function getStatusBarHeight () : Number;
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
		 *  Orders the window just behind another. To order the window behind     *  a NativeWindow that does not implement IWindow, use this window's     *  NativeWindow's <code>orderInBackOf()</code> method.     *     *  @param window The IWindow (Window or WindowedAplication)     *  to order this window behind.     *     *  @return <code>true</code> if the window was succesfully sent behind;     *  <code>false</code> if the window is invisible or minimized.
		 */
		public function orderInBackOf (window:IWindow) : Boolean;
		/**
		 *  Orders the window just in front of another. To order the window     *  in front of a NativeWindow that does not implement IWindow, use this     *  window's NativeWindow's <code>orderInFrontOf()</code> method.     *     *  @param window The IWindow (Window or WindowedAplication)     *  to order this window in front of.     *     *  @return <code>true</code> if the window was succesfully sent in front;     *  <code>false</code> if the window is invisible or minimized.
		 */
		public function orderInFrontOf (window:IWindow) : Boolean;
		/**
		 *  Orders the window behind all others in the same application.      *      *  @return <code>true</code> if the window was succesfully sent to the back;      *  <code>false</code> if the window is invisible or minimized.
		 */
		public function orderToBack () : Boolean;
		/**
		 *  Orders the window in front of all others in the same application.  *  *  @return <code>true</code> if the window was succesfully sent to the front;  *  <code>false</code> if the window is invisible or minimized.
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
		protected function startResize (start:String) : void;
		/**
		 *  @private
		 */
		private function creationCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function enterFrameHandler (e:Event) : void;
		/**
		 *  @private
		 */
		private function dispatchPendingInvokes () : void;
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
		 *  @private
		 */
		private function preinitializeHandler (event:Event = null) : void;
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
		private function stage_fullScreenHandler (event:FullScreenEvent) : void;
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
		private function nativeApplication_networkChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_invokeHandler (event:InvokeEvent) : void;
		/**
		 * @private
		 */
		private function nativeWindow_activateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeWindow_deactivateHandler (event:Event) : void;
		/**
		 *  This is a temporary event handler which dispatches a initialLayoutComplete event after     *  two updateCompletes. This event will only be dispatched after either setting the bounds or     *  maximizing the window at startup.
		 */
		private function updateComplete_handler (event:FlexEvent) : void;
		/**
		 *  @private     *  Returns a Function handler that resizes the view source HTML component with the stage.
		 */
		private function viewSourceResizeHandler (html:HTML) : Function;
		/**
		 *  @private     *  Returns a Function handler that closes the View Source window when the parent closes.
		 */
		private function viewSourceCloseHandler (win:Window) : Function;
	}
}
