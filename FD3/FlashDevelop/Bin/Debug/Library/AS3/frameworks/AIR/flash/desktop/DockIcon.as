/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.desktop {
	import flash.display.NativeMenu;
	public class DockIcon extends InteractiveIcon {
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
		 * The system-supplied menu of this dock icon.
		 */
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		/**
		 * The current display width of the icon in pixels.
		 */
		public function get width():int;
		/**
		 * Notifies the user that an event has occured that may require attention.
		 *
		 * @param priority          <String (default = "informational")> The urgency with which to bounce the dock.
		 */
		public function bounce(priority:String = "informational"):void;
	}
}
