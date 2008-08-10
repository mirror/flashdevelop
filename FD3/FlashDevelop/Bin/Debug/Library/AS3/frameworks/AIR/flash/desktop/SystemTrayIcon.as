/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.desktop {
	import flash.display.NativeMenu;
	public class SystemTrayIcon extends InteractiveIcon {
		/**
		 * The icon image as an array of BitmapData objects of different sizes.
		 */
		public function get bitmaps():Array;
		public function set bitmaps(value:Array):void;
		/**
		 * The current display height of the icon in pixels.
		 */
		public function get height():int;
		/**
		 * The system tray icon menu.
		 */
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		/**
		 * The tooltip that pops up for the system tray icon. If the string is
		 *  longer than SystemTrayIcon.MAX_TIP_LENGTH, the tip will
		 *  be truncated.
		 */
		public function get tooltip():String;
		public function set tooltip(value:String):void;
		/**
		 * The current display width of the icon in pixels.
		 */
		public function get width():int;
		/**
		 * The permitted length of the system tray icon tooltip.
		 */
		public static const MAX_TIP_LENGTH:Number = 63;
	}
}
