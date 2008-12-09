package flash.desktop
{
	/// The SystemTrayIcon class represents the style of icon that is used in the Windows taskbar&#xAE; notification area (system tray).
	public class SystemTrayIcon extends flash.desktop.InteractiveIcon
	{
		/** 
		 * [AIR] Dispatched by this SystemTrayIcon object on right mouse click.
		 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_CLICK
		 */
		[Event(name="rightClick", type="flash.events.MouseEvent")]

		/** 
		 * [AIR] Dispatched by this SystemTrayIcon object on right mouse up.
		 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_UP
		 */
		[Event(name="rightMouseUp", type="flash.events.MouseEvent")]

		/** 
		 * [AIR] Dispatched by this SystemTrayIcon object on right mouse down.
		 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_DOWN
		 */
		[Event(name="rightMouseDown", type="flash.events.MouseEvent")]

		/** 
		 * [AIR] Dispatched by this SystemTrayIcon object on mouse click.
		 * @eventType flash.events.MouseEvent.CLICK
		 */
		[Event(name="click", type="flash.events.MouseEvent")]

		/** 
		 * [AIR] Dispatched by this SystemTrayIcon object on mouse up.
		 * @eventType flash.events.MouseEvent.MOUSE_UP
		 */
		[Event(name="mouseUp", type="flash.events.MouseEvent")]

		/** 
		 * [AIR] Dispatched by this SystemTrayIcon object on mouse down.
		 * @eventType flash.events.MouseEvent.MOUSE_DOWN
		 */
		[Event(name="mouseDown", type="flash.events.MouseEvent")]

		/// [AIR] The permitted length of the system tray icon tooltip.
		public static const MAX_TIP_LENGTH:Number;

		/// [AIR] The icon image as an array of BitmapData objects of different sizes.
		public var bitmaps:Array;

		/// [AIR] The current display width of the icon in pixels.
		public var width:int;

		/// [AIR] The current display height of the icon in pixels.
		public var height:int;

		/// [AIR] The tooltip that pops up for the system tray icon.
		public var tooltip:String;

		/// [AIR] The system tray icon menu.
		public var menu:flash.display.NativeMenu;

	}

}

