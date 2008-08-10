/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.display {
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	public class NativeWindow extends EventDispatcher {
		/**
		 * Indicates whether this window is the active application window.
		 */
		public function get active():Boolean;
		/**
		 * Specifies whether this window will always be in front of other windows (including
		 *  those of other applications).
		 */
		public function get alwaysInFront():Boolean;
		public function set alwaysInFront(value:Boolean):void;
		/**
		 * The size and location of this window.
		 */
		public function get bounds():Rectangle;
		public function set bounds(value:Rectangle):void;
		/**
		 * Indicates whether this window has been closed.
		 */
		public function get closed():Boolean;
		/**
		 * The display state of this window.
		 */
		public function get displayState():String;
		/**
		 * The height of this window in pixels.
		 */
		public function get height():Number;
		public function set height(value:Number):void;
		/**
		 * Reports the maximizable setting used to create this window.
		 */
		public function get maximizable():Boolean;
		/**
		 * The maximum size for this window.
		 */
		public function get maxSize():Point;
		public function set maxSize(value:Point):void;
		/**
		 * The native menu for this window.
		 */
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		/**
		 * Reports the minimizable setting used to create this window.
		 */
		public function get minimizable():Boolean;
		/**
		 * The minimum size for this window.
		 */
		public function get minSize():Point;
		public function set minSize(value:Point):void;
		/**
		 * Reports the resizable setting used to create this window.
		 */
		public function get resizable():Boolean;
		/**
		 * The Stage object for this window. The
		 *  Stage object is the root object in the display list architecture used in ActionScript
		 *  3.0-based SWF content.
		 */
		public function get stage():Stage;
		/**
		 * Indicates whether AIR supports native window menus on the current computer system.
		 */
		public static function get supportsMenu():Boolean;
		/**
		 * Indicates whether AIR supports window notification cueing on the current computer system.
		 */
		public static function get supportsNotification():Boolean;
		/**
		 * Reports the system chrome setting used to create this window.
		 */
		public function get systemChrome():String;
		/**
		 * The largest window size allowed by the operating system.
		 */
		public static function get systemMaxSize():Point;
		/**
		 * The smallest window size allowed by the operating system.
		 */
		public static function get systemMinSize():Point;
		/**
		 * The window title.
		 */
		public function get title():String;
		public function set title(value:String):void;
		/**
		 * Reports the transparency setting used to create this window.
		 */
		public function get transparent():Boolean;
		/**
		 * Reports the window type setting used to create this window.
		 */
		public function get type():String;
		/**
		 * Specifies whether this window is visible.
		 */
		public function get visible():Boolean;
		public function set visible(value:Boolean):void;
		/**
		 * The width of this window in pixels.
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * The horizontal axis coordinate of this window's top left corner relative to the
		 *  origin of the operating system desktop.
		 */
		public function get x():Number;
		public function set x(value:Number):void;
		/**
		 * The vertical axis coordinate of this window's top left corner relative to the
		 *  upper left corner of the operating system's desktop.
		 */
		public function get y():Number;
		public function set y(value:Number):void;
		/**
		 * Creates a new NativeWindow instance and a corresponding operating system window.
		 *
		 * @param initOptions       <NativeWindowInitOptions> An object containing the initialization properties for this window.
		 */
		public function NativeWindow(initOptions:NativeWindowInitOptions);
		/**
		 * Activates this window.
		 */
		public function activate():void;
		/**
		 * Closes this window.
		 */
		public function close():void;
		/**
		 * Converts a point in pixel coordinates relative to the origin of the window stage
		 *  (a global point in terms of the display list), to a point on the virtual desktop.
		 *
		 * @param globalPoint       <Point> The point on the stage to convert to a point on the screen.
		 * @return                  <Point> The specified global point relative to the desktop.
		 */
		public function globalToScreen(globalPoint:Point):Point;
		/**
		 * Maximizes this native window.
		 */
		public function maximize():void;
		/**
		 * Minimizes this native window.
		 */
		public function minimize():void;
		/**
		 * Triggers a visual cue through the operating system that an event of
		 *  interest has occurred.
		 *
		 * @param type              <String> A string representing the urgency of the notification.
		 */
		public function notifyUser(type:String):void;
		/**
		 * Sends this window directly behind the specified window.
		 *
		 * @param window            <NativeWindow> An application window.
		 * @return                  <Boolean> true if this window was succesfully sent to the
		 *                            back; false if this window is invisible or minimized.
		 */
		public function orderInBackOf(window:NativeWindow):Boolean;
		/**
		 * Brings this window directly in front of the specified window.
		 *
		 * @param window            <NativeWindow> An application window.
		 * @return                  <Boolean> true if this window was succesfully brought to the
		 *                            front; false if this window is invisible or minimized.
		 */
		public function orderInFrontOf(window:NativeWindow):Boolean;
		/**
		 * Sends this window behind any other visible windows.
		 *
		 * @return                  <Boolean> true if this window was succesfully sent to the
		 *                            back; false if this window is invisible or minimized.
		 */
		public function orderToBack():Boolean;
		/**
		 * Brings this window in front of any other visible windows.
		 *
		 * @return                  <Boolean> true if this window was succesfully brought to the
		 *                            front; false if this window is invisible or minimized.
		 */
		public function orderToFront():Boolean;
		/**
		 * Restores this window from either a minimized or a maximized state.
		 */
		public function restore():void;
		/**
		 * Starts a system-controlled move of this window.
		 *
		 * @return                  <Boolean> true if the move was succesfully initiated and
		 *                            false if the window is maximized.
		 */
		public function startMove():Boolean;
		/**
		 * Starts a system-controlled resize operation of this window.
		 *
		 * @param edgeOrCorner      <String (default = NaN)> A constant from the NativeWindowResize class that specifies
		 *                            which edge or corner of this window to resize. The following are
		 *                            valid values:
		 *                            ValueVertical alignmentHorizontal alignment
		 *                            NativeWindowResize.TOP
		 *                            TopCenter
		 * @return                  <Boolean> true if the resize was succesfully initiated and
		 *                            false if the window is maximized.
		 */
		public function startResize(edgeOrCorner:String):Boolean;
	}
}
