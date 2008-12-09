package flash.display
{
	/// The NativeWindow class provides an interface for creating and controlling native desktop windows.
	public class NativeWindow extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Dispatched by this NativeWindow object after the window has been deactivated.
		 * @eventType flash.events.Event.DEACTIVATE
		 */
		[Event(name="deactivate", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object after the window has been activated.
		 * @eventType flash.events.Event.ACTIVATE
		 */
		[Event(name="activate", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object after the window has been closed.
		 * @eventType flash.events.Event.CLOSE
		 */
		[Event(name="close", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object immediately before the window is to be closed.
		 * @eventType flash.events.Event.CLOSING
		 */
		[Event(name="closing", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object after the window's displayState property has changed.
		 * @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE
		 */
		[Event(name="displayStateChange", type="flash.events.NativeWindowDisplayStateEvent")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object immediately before the window changes its display state.
		 * @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING
		 */
		[Event(name="displayStateChanging", type="flash.events.NativeWindowDisplayStateEvent")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object after the window has been resized.
		 * @eventType flash.events.NativeWindowBoundsEvent.RESIZE
		 */
		[Event(name="resize", type="flash.events.NativeWindowBoundsEvent")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object immediately before the window is to be resized on the desktop.
		 * @eventType flash.events.NativeWindowBoundsEvent.RESIZING
		 */
		[Event(name="resizing", type="flash.events.NativeWindowBoundsEvent")]

		/** 
		 * [AIR] Dispatched by this NativeWindow object after the window has been moved on the desktop.
		 * @eventType flash.events.NativeWindowBoundsEvent.MOVE
		 */
		[Event(name="move", type="flash.events.NativeWindowBoundsEvent")]

		/** 
		 * [AIR] Dispatched by the NativeWindow object immediately before the window is to be moved on the desktop.
		 * @eventType flash.events.NativeWindowBoundsEvent.MOVING
		 */
		[Event(name="moving", type="flash.events.NativeWindowBoundsEvent")]

		/// [AIR] The Stage object for this window.
		public var stage:flash.display.Stage;

		/// [AIR] The window title.
		public var title:String;

		/// [AIR] The size and location of this window.
		public var bounds:flash.geom.Rectangle;

		/// [AIR] The display state of this window.
		public var displayState:String;

		/// [AIR] Indicates whether this window has been closed.
		public var closed:Boolean;

		/// [AIR] Specifies whether this window is visible.
		public var visible:Boolean;

		/// [AIR] Reports the system chrome setting used to create this window.
		public var systemChrome:String;

		/// [AIR] Reports the transparency setting used to create this window.
		public var transparent:Boolean;

		/// [AIR] Reports the window type setting used to create this window.
		public var type:String;

		/// [AIR] Reports the minimizable setting used to create this window.
		public var minimizable:Boolean;

		/// [AIR] Reports the maximizable setting used to create this window.
		public var maximizable:Boolean;

		/// [AIR] Reports the resizable setting used to create this window.
		public var resizable:Boolean;

		/// [AIR] The minimum size for this window.
		public var minSize:flash.geom.Point;

		/// [AIR] The maximum size for this window.
		public var maxSize:flash.geom.Point;

		/// [AIR] Specifies whether this window will always be in front of other windows (including those of other applications).
		public var alwaysInFront:Boolean;

		/// [AIR] Indicates whether AIR supports native window menus on the current computer system.
		public var supportsMenu:Boolean;

		/// [AIR] Indicates whether AIR supports window notification cueing on the current computer system.
		public var supportsNotification:Boolean;

		/// [AIR] Indicates whether AIR supports native windows with transparent pixels.
		public var supportsTransparency:Boolean;

		/// [AIR] The smallest window size allowed by the operating system.
		public var systemMinSize:flash.geom.Point;

		/// [AIR] The largest window size allowed by the operating system.
		public var systemMaxSize:flash.geom.Point;

		/// [AIR] Indicates whether this window is the active application window.
		public var active:Boolean;

		/// [AIR] The native menu for this window.
		public var menu:flash.display.NativeMenu;

		/// [AIR] The width of this window in pixels.
		public var width:Number;

		/// [AIR] The height of this window in pixels.
		public var height:Number;

		/// [AIR] The horizontal axis coordinate of this window's top left corner relative to the origin of the operating system desktop.
		public var x:Number;

		/// [AIR] The vertical axis coordinate of this window's top left corner relative to the upper left corner of the operating system's desktop.
		public var y:Number;

		/// [AIR] Creates a new NativeWindow instance and a corresponding operating system window.
		public function NativeWindow(initOptions:flash.display.NativeWindowInitOptions);

		/// [AIR] Minimizes this window.
		public function minimize():void;

		/// [AIR] Maximizes this window.
		public function maximize():void;

		/// [AIR] Restores this window from either a minimized or a maximized state.
		public function restore():void;

		/// [AIR] Closes this window.
		public function close():void;

		/// [AIR] Starts a system-controlled move of this window.
		public function startMove():Boolean;

		/// [AIR] Starts a system-controlled resize operation of this window.
		public function startResize(edgeOrCorner:String=unknown):Boolean;

		/// [AIR] Brings this window in front of any other visible windows.
		public function orderToFront():Boolean;

		/// [AIR] Sends this window behind any other visible windows.
		public function orderToBack():Boolean;

		/// [AIR] Brings this window directly in front of the specified window.
		public function orderInFrontOf(window:flash.display.NativeWindow):Boolean;

		/// [AIR] Sends this window directly behind the specified window.
		public function orderInBackOf(window:flash.display.NativeWindow):Boolean;

		/// [AIR] Activates this window.
		public function activate():void;

		/// [AIR] Converts a point in pixel coordinates relative to the origin of the window stage (a global point in terms of the display list), to a point on the virtual desktop.
		public function globalToScreen(globalPoint:flash.geom.Point):flash.geom.Point;

		/// [AIR] Triggers a visual cue through the operating system that an event of interest has occurred.
		public function notifyUser(type:String):void;

	}

}

