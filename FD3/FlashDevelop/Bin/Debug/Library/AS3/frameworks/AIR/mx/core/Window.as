/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package mx.core {
	import mx.controls.FlexNativeMenu;
	import flash.display.NativeWindow;
	import flash.events.MouseEvent;
	public class Window extends LayoutContainer implements IWindow {
		/**
		 * Determines whether the underlying NativeWindow is always in front
		 *  of other windows (including those of other applications). Setting
		 *  this property sets the alwaysInFront property of the
		 *  underlying NativeWindow. See the NativeWindow.alwaysInFront
		 *  property description for details of how this affects window stacking
		 *  order.
		 */
		public function get alwaysInFront():Boolean;
		public function set alwaysInFront(value:Boolean):void;
		/**
		 * A flag indicating whether the window has been closed.
		 */
		public function get closed():Boolean;
		/**
		 * The ApplicationControlBar for this Window.
		 */
		public var controlBar:IUIComponent;
		/**
		 * Returns the cursor manager for this Window.
		 */
		public function get cursorManager():ICursorManager;
		/**
		 * Specifies the maximum height of the application's window.
		 */
		public function get maxHeight():Number;
		public function set maxHeight(value:Number):void;
		/**
		 * Specifies whether the window can be maximized.
		 *  This property's value is read-only after the window
		 *  has been opened.
		 */
		public function get maximizable():Boolean;
		public function set maximizable(value:Boolean):void;
		/**
		 * Specifies the maximum width of the application's window.
		 */
		public function get maxWidth():Number;
		public function set maxWidth(value:Number):void;
		/**
		 * The window menu for this window.
		 *  Some operating systems do not support window menus,
		 *  in which case this property is ignored.
		 */
		public function get menu():FlexNativeMenu;
		public function set menu(value:FlexNativeMenu):void;
		/**
		 * Specifies the minimum height of the application's window.
		 */
		public function get minHeight():Number;
		public function set minHeight(value:Number):void;
		/**
		 * Specifies whether the window can be minimized.
		 *  This property is read-only after the window has
		 *  been opened.
		 */
		public function get minimizable():Boolean;
		public function set minimizable(value:Boolean):void;
		/**
		 * Specifies the minimum width of the application's window.
		 */
		public function get minWidth():Number;
		public function set minWidth(value:Number):void;
		/**
		 * The underlying NativeWindow that this Window component uses.
		 */
		public function get nativeWindow():NativeWindow;
		/**
		 * Specifies whether the window can be resized.
		 *  This property is read-only after the window
		 *  has been opened.
		 */
		public function get resizable():Boolean;
		public function set resizable(value:Boolean):void;
		/**
		 * If true, the gripper is visible.
		 */
		public function get showGripper():Boolean;
		public function set showGripper(value:Boolean):void;
		/**
		 * If true, the status bar is visible.
		 */
		public function get showStatusBar():Boolean;
		public function set showStatusBar(value:Boolean):void;
		/**
		 * If true, the window's title bar is visible.
		 */
		public function get showTitleBar():Boolean;
		public function set showTitleBar(value:Boolean):void;
		/**
		 * The string that appears in the status bar, if it is visible.
		 */
		public function get status():String;
		public function set status(value:String):void;
		/**
		 * The UIComponent that displays the status bar.
		 */
		public function get statusBar():UIComponent;
		/**
		 * The IFactory that creates an instance to use
		 *  as the status bar.
		 *  The default value is an IFactory for StatusBar.
		 */
		public function get statusBarFactory():IFactory;
		public function set statusBarFactory(value:IFactory):void;
		/**
		 * Set of styles to pass from the window to the status bar.
		 */
		protected function get statusBarStyleFilters():Object;
		/**
		 * Specifies the type of system chrome (if any) the window has.
		 *  The set of possible values is defined by the constants
		 *  in the NativeWindowSystemChrome class.
		 */
		public function get systemChrome():String;
		public function set systemChrome(value:String):void;
		/**
		 * The title text that appears in the window title bar and
		 *  the taskbar.
		 */
		public function get title():String;
		public function set title(value:String):void;
		/**
		 * The UIComponent that displays the title bar.
		 */
		public function get titleBar():UIComponent;
		/**
		 * The IFactory that creates an instance to use
		 *  as the title bar.
		 *  The default value is an IFactory for TitleBar.
		 */
		public function get titleBarFactory():IFactory;
		public function set titleBarFactory(value:IFactory):void;
		/**
		 * Set of styles to pass from the Window to the titleBar.
		 */
		protected function get titleBarStyleFilters():Object;
		/**
		 * The Class (usually an image) used to draw the title bar icon.
		 */
		public function get titleIcon():Class;
		public function set titleIcon(value:Class):void;
		/**
		 * Specifies whether the window is transparent. Setting this
		 *  property to true for a window that uses
		 *  system chrome is not supported.
		 */
		public function get transparent():Boolean;
		public function set transparent(value:Boolean):void;
		/**
		 * Specifies the type of NativeWindow that this component
		 *  represents. The set of possible values is defined by the constants
		 *  in the NativeWindowType class.
		 */
		public function get type():String;
		public function set type(value:String):void;
		/**
		 * Controls the window's visibility. Unlike the
		 *  UIComponent.visible property of most Flex
		 *  visual components, this property affects the visibility
		 *  of the underlying NativeWindow (including operating system
		 *  chrome) as well as the visibility of the Window's child
		 *  controls.
		 */
		public function get visible():Boolean;
		public function set visible(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function Window();
		/**
		 * Activates the underlying NativeWindow (even if this Window's application
		 *  is not currently active).
		 */
		public function activate():void;
		/**
		 * Closes the window. This action is cancelable.
		 */
		public function close():void;
		/**
		 * Returns the Window to which a component is parented.
		 *
		 * @param component         <UIComponent> the component whose Window you wish to find.
		 */
		public static function getWindow(component:UIComponent):Window;
		/**
		 * Maximizes the window, or does nothing if it's already maximized.
		 */
		public function maximize():void;
		/**
		 * Minimizes the window.
		 */
		public function minimize():void;
		/**
		 * Manages mouse down events on the window border.
		 *
		 * @param event             <MouseEvent> 
		 */
		protected function mouseDownHandler(event:MouseEvent):void;
		/**
		 * Creates the underlying NativeWindow and opens it.
		 *
		 * @param openWindowActive  <Boolean (default = true)> openWindowActive specifies whether the Window opens
		 *                            activated (that is, whether it has focus). The default value
		 *                            is true.
		 */
		public function open(openWindowActive:Boolean = true):void;
		/**
		 * Orders the window just behind another. To order the window behind
		 *  a NativeWindow that does not implement IWindow, use this window's
		 *  nativeWindow's orderInBackOf() method.
		 *
		 * @param window            <IWindow> The IWindow (Window or WindowedAplication)
		 *                            to order this window behind.
		 * @return                  <Boolean> true if the window was succesfully sent behind;
		 *                            false if the window is invisible or minimized.
		 */
		public function orderInBackOf(window:IWindow):Boolean;
		/**
		 * Orders the window just in front of another. To order the window
		 *  in front of a NativeWindow that does not implement IWindow, use this
		 *  window's nativeWindow's  orderInFrontOf() method.
		 *
		 * @param window            <IWindow> The IWindow (Window or WindowedAplication)
		 *                            to order this window in front of.
		 * @return                  <Boolean> true if the window was succesfully sent in front;
		 *                            false if the window is invisible or minimized.
		 */
		public function orderInFrontOf(window:IWindow):Boolean;
		/**
		 * Orders the window behind all others in the same application.
		 *
		 * @return                  <Boolean> true if the window was succesfully sent to the back;
		 *                            false if the window is invisible or minimized.
		 */
		public function orderToBack():Boolean;
		/**
		 * Orders the window in front of all others in the same application.
		 *
		 * @return                  <Boolean> true if the window was succesfully sent to the front;
		 *                            false if the window is invisible or minimized.
		 */
		public function orderToFront():Boolean;
		/**
		 * Restores the window (unmaximizes it if it's maximized, or
		 *  unminimizes it if it's minimized).
		 */
		public function restore():void;
	}
}
