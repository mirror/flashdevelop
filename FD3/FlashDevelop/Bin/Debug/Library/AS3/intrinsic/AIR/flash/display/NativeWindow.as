package flash.display
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.display.NativeWindow;
	import flash.geom.Rectangle;
	import flash.display.NativeMenu;
	import flash.display.Stage;
	import flash.display.NativeWindowInitOptions;

	/**
	 * Dispatched by this NativeWindow object after the window has been deactivated.
	 * @eventType flash.events.Event.DEACTIVATE
	 */
	[Event(name="deactivate", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeWindow object after the window has been activated.
	 * @eventType flash.events.Event.ACTIVATE
	 */
	[Event(name="activate", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeWindow object after the window has been closed.
	 * @eventType flash.events.Event.CLOSE
	 */
	[Event(name="close", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeWindow object immediately before the window is to be closed.
	 * @eventType flash.events.Event.CLOSING
	 */
	[Event(name="closing", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeWindow object after the window's displayState property has changed.
	 * @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE
	 */
	[Event(name="displayStateChange", type="flash.events.NativeWindowDisplayStateEvent")] 

	/**
	 * Dispatched by this NativeWindow object immediately before the window changes its display state.
	 * @eventType flash.events.NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING
	 */
	[Event(name="displayStateChanging", type="flash.events.NativeWindowDisplayStateEvent")] 

	/**
	 * Dispatched by this NativeWindow object after the window has been resized.
	 * @eventType flash.events.NativeWindowBoundsEvent.RESIZE
	 */
	[Event(name="resize", type="flash.events.NativeWindowBoundsEvent")] 

	/**
	 * Dispatched by this NativeWindow object immediately before the window is to be resized on the desktop.
	 * @eventType flash.events.NativeWindowBoundsEvent.RESIZING
	 */
	[Event(name="resizing", type="flash.events.NativeWindowBoundsEvent")] 

	/**
	 * Dispatched by this NativeWindow object after the window has been moved on the desktop.
	 * @eventType flash.events.NativeWindowBoundsEvent.MOVE
	 */
	[Event(name="move", type="flash.events.NativeWindowBoundsEvent")] 

	/**
	 * Dispatched by the NativeWindow object immediately before the window is to be moved on the desktop.
	 * @eventType flash.events.NativeWindowBoundsEvent.MOVING
	 */
	[Event(name="moving", type="flash.events.NativeWindowBoundsEvent")] 

	/// The NativeWindow class provides an interface for creating and controlling native desktop windows.
	public class NativeWindow extends EventDispatcher
	{
		/// [AIR] Indicates whether this window is the active application window.
		public function get active () : Boolean;

		/// [AIR] Specifies whether this window will always be in front of other windows (including those of other applications).
		public function get alwaysInFront () : Boolean;
		public function set alwaysInFront (value:Boolean) : void;

		/// [AIR] The size and location of this window.
		public function get bounds () : Rectangle;
		public function set bounds (rect:Rectangle) : void;

		/// [AIR] Indicates whether this window has been closed.
		public function get closed () : Boolean;

		/// [AIR] The display state of this window.
		public function get displayState () : String;

		/// [AIR] The height of this window in pixels.
		public function get height () : Number;
		public function set height (value:Number) : void;

		/// [AIR] Reports the maximizable setting used to create this window.
		public function get maximizable () : Boolean;

		/// [AIR] The maximum size for this window.
		public function get maxSize () : Point;
		public function set maxSize (size:Point) : void;

		/// [AIR] The native menu for this window.
		public function get menu () : NativeMenu;
		public function set menu (value:NativeMenu) : void;

		/// [AIR] Reports the minimizable setting used to create this window.
		public function get minimizable () : Boolean;

		/// [AIR] The minimum size for this window.
		public function get minSize () : Point;
		public function set minSize (size:Point) : void;

		/// [AIR] Reports the resizable setting used to create this window.
		public function get resizable () : Boolean;

		/// [AIR] The Stage object for this window.
		public function get stage () : Stage;

		/// [AIR] Indicates whether AIR supports native window menus on the current computer system.
		public static function get supportsMenu () : Boolean;

		/// [AIR] Indicates whether AIR supports window notification cueing on the current computer system.
		public static function get supportsNotification () : Boolean;

		/// [AIR] Indicates whether AIR supports native windows with transparent pixels.
		public static function get supportsTransparency () : Boolean;

		/// [AIR] Reports the system chrome setting used to create this window.
		public function get systemChrome () : String;

		/// [AIR] The largest window size allowed by the operating system.
		public static function get systemMaxSize () : Point;

		/// [AIR] The smallest window size allowed by the operating system.
		public static function get systemMinSize () : Point;

		/// [AIR] The window title.
		public function get title () : String;
		public function set title (value:String) : void;

		/// [AIR] Reports the transparency setting used to create this window.
		public function get transparent () : Boolean;

		/// [AIR] Reports the window type setting used to create this window.
		public function get type () : String;

		/// [AIR] Specifies whether this window is visible.
		public function get visible () : Boolean;
		public function set visible (value:Boolean) : void;

		/// [AIR] The width of this window in pixels.
		public function get width () : Number;
		public function set width (value:Number) : void;

		/// [AIR] The horizontal axis coordinate of this window's top left corner relative to the origin of the operating system desktop.
		public function get x () : Number;
		public function set x (value:Number) : void;

		/// [AIR] The vertical axis coordinate of this window's top left corner relative to the upper left corner of the operating system's desktop.
		public function get y () : Number;
		public function set y (value:Number) : void;

		/// [AIR] Activates this window.
		public function activate () : void;

		/// [AIR] Closes this window.
		public function close () : void;

		/// [AIR] Converts a point in pixel coordinates relative to the origin of the window stage (a global point in terms of the display list), to a point on the virtual desktop.
		public function globalToScreen (globalPoint:Point) : Point;

		/// [AIR] Maximizes this window.
		public function maximize () : void;

		/// [AIR] Minimizes this window.
		public function minimize () : void;

		/// [AIR] Triggers a visual cue through the operating system that an event of interest has occurred.
		public function notifyUser (type:String) : void;

		/// [AIR] Sends this window directly behind the specified window.
		public function orderInBackOf (window:NativeWindow) : Boolean;

		/// [AIR] Brings this window directly in front of the specified window.
		public function orderInFrontOf (window:NativeWindow) : Boolean;

		/// [AIR] Sends this window behind any other visible windows.
		public function orderToBack () : Boolean;

		/// [AIR] Brings this window in front of any other visible windows.
		public function orderToFront () : Boolean;

		/// [AIR] Restores this window from either a minimized or a maximized state.
		public function restore () : void;

		/// [AIR] Starts a system-controlled move of this window.
		public function startMove () : Boolean;

		/// [AIR] Starts a system-controlled resize operation of this window.
		public function startResize (edgeOrCorner:String) : Boolean;
	}
}
