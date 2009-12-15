package flash.desktop
{
	import flash.display.NativeMenu;

	/**
	 * Dispatched by this SystemTrayIcon object on right mouse click.
	 * @eventType flash.events.ScreenMouseEvent.RIGHT_CLICK
	 */
	[Event(name="rightClick", type="flash.events.ScreenMouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on right mouse up.
	 * @eventType flash.events.ScreenMouseEvent.RIGHT_MOUSE_UP
	 */
	[Event(name="rightMouseUp", type="flash.events.ScreenMouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on right mouse down.
	 * @eventType flash.events.ScreenMouseEvent.RIGHT_MOUSE_DOWN
	 */
	[Event(name="rightMouseDown", type="flash.events.ScreenMouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on mouse click.
	 * @eventType flash.events.ScreenMouseEvent.CLICK
	 */
	[Event(name="click", type="flash.events.ScreenMouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on mouse up.
	 * @eventType flash.events.ScreenMouseEvent.MOUSE_UP
	 */
	[Event(name="mouseUp", type="flash.events.ScreenMouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on mouse down.
	 * @eventType flash.events.ScreenMouseEvent.MOUSE_DOWN
	 */
	[Event(name="mouseDown", type="flash.events.ScreenMouseEvent")] 

	/// The SystemTrayIcon class represents the Windows taskbar® notification area (system tray)-style icon.
	public class SystemTrayIcon extends InteractiveIcon
	{
		/// The permitted length of the system tray icon tooltip.
		public static const MAX_TIP_LENGTH : Number;

		/// The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (value:Array) : void;

		/// The current display height of the icon in pixels.
		public function get height () : int;

		/// The system tray icon menu.
		public function get menu () : NativeMenu;
		public function set menu (value:NativeMenu) : void;

		/// The tooltip that pops up for the system tray icon.
		public function get tooltip () : String;
		public function set tooltip (value:String) : void;

		/// The current display width of the icon in pixels.
		public function get width () : int;

		public function SystemTrayIcon ();
	}
}
