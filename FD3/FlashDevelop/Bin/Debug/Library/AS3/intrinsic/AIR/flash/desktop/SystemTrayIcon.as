package flash.desktop
{
	import flash.display.NativeMenu;

	/**
	 * Dispatched by this SystemTrayIcon object on right mouse click.
	 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_CLICK
	 */
	[Event(name="rightClick", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on right mouse up.
	 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_UP
	 */
	[Event(name="rightMouseUp", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on right mouse down.
	 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_DOWN
	 */
	[Event(name="rightMouseDown", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on mouse click.
	 * @eventType flash.events.MouseEvent.CLICK
	 */
	[Event(name="click", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on mouse up.
	 * @eventType flash.events.MouseEvent.MOUSE_UP
	 */
	[Event(name="mouseUp", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched by this SystemTrayIcon object on mouse down.
	 * @eventType flash.events.MouseEvent.MOUSE_DOWN
	 */
	[Event(name="mouseDown", type="flash.events.MouseEvent")] 

	/// The SystemTrayIcon class represents the style of icon that is used in the Windows taskbar&#xAE; notification area (system tray).
	public class SystemTrayIcon extends InteractiveIcon
	{
		/// [AIR] The permitted length of the system tray icon tooltip.
		public static const MAX_TIP_LENGTH : Number;

		/// [AIR] The icon image as an array of BitmapData objects of different sizes.
		public function get bitmaps () : Array;
		public function set bitmaps (value:Array) : void;

		/// [AIR] The current display height of the icon in pixels.
		public function get height () : int;

		/// [AIR] The system tray icon menu.
		public function get menu () : NativeMenu;
		public function set menu (value:NativeMenu) : void;

		/// [AIR] The tooltip that pops up for the system tray icon.
		public function get tooltip () : String;
		public function set tooltip (value:String) : void;

		/// [AIR] The current display width of the icon in pixels.
		public function get width () : int;

		public function SystemTrayIcon ();
	}
}
