/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.core {
	public interface IWindow {
		/**
		 * Specifies whether the window can be maximized.
		 */
		public function get maximizable():Boolean;
		/**
		 * Specifies whether the window can be minimized.
		 */
		public function get minimizable():Boolean;
		/**
		 * The underlying NativeWindow that the Window component uses.
		 */
		public function get nativeWindow():NativeWindow;
		/**
		 * Specifies whether the window can be resized.
		 */
		public function get resizable():Boolean;
		/**
		 * The string that appears in the status bar, if it is visible.
		 */
		public function get status():String;
		public function set status(value:String):void;
		/**
		 * Specifies the type of system chrome (if any) the window has.
		 *  The set of possible values is defined by the constants
		 *  in the NativeWindowSystemChrome class.
		 */
		public function get systemChrome():String;
		/**
		 * The title text that appears in the window title bar and
		 *  the taskbar.
		 */
		public function get title():String;
		public function set title(value:String):void;
		/**
		 * The Class (usually an image) used to draw the title bar icon.
		 */
		public function get titleIcon():Class;
		public function set titleIcon(value:Class):void;
		/**
		 * Specifies whether the window is transparent.
		 */
		public function get transparent():Boolean;
		/**
		 * Specifies the type of NativeWindow that this component
		 *  represents. The set of possible values is defined by the constants
		 *  in the NativeWindowType class.
		 */
		public function get type():String;
		/**
		 * Controls the window's visibility.
		 */
		public function get visible():Boolean;
		/**
		 * Closes the window.
		 */
		public function close():void;
		/**
		 * Maximizes the window, or does nothing if it's already maximized.
		 */
		public function maximize():void;
		/**
		 * Minimizes the window.
		 */
		public function minimize():void;
		/**
		 * Restores the window (unmaximizes it if it's maximized, or
		 *  unminimizes it if it's minimized).
		 */
		public function restore():void;
	}
}
