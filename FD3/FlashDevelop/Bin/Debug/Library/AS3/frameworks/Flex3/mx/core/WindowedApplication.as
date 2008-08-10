/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.core {
	public class WindowedApplication extends Application implements IWindow {
		/**
		 * Determines whether the underlying NativeWindow is always in front of other windows.
		 */
		public function get alwaysInFront():Boolean;
		public function set alwaysInFront(value:Boolean):void;
		/**
		 * The identifier that AIR uses to identify the application.
		 */
		public function get applicationID():String;
		/**
		 * Specifies whether the AIR application will quit when the last
		 *  window closes or will continue running in the background.
		 */
		public function get autoExit():Boolean;
		public function set autoExit(value:Boolean):void;
		/**
		 * Returns true when the underlying window has been closed.
		 */
		public function get closed():Boolean;
		/**
		 * The dock icon menu. Some operating systems do not support dock icon menus.
		 */
		public function get dockIconMenu():FlexNativeMenu;
		public function set dockIconMenu(value:FlexNativeMenu):void;
		/**
		 * Specifies the maximum height of the application's window.
		 */
		public function get maxHeight():Number;
		public function set maxHeight(value:Number):void;
		/**
		 * Specifies whether the window can be maximized.
		 */
		public function get maximizable():Boolean;
		/**
		 * Specifies the maximum width of the application's window.
		 */
		public function get maxWidth():Number;
		public function set maxWidth(value:Number):void;
		/**
		 * The application menu for operating systems that support an application menu,
		 *  or the window menu of the application's initial window for operating
		 *  systems that support window menus.
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
		 */
		public function get minimizable():Boolean;
		/**
		 * Specifies the minimum width of the application's window.
		 */
		public function get minWidth():Number;
		public function set minWidth(value:Number):void;
		/**
		 * The NativeApplication object representing the AIR application.
		 */
		public function get nativeApplication():NativeApplication;
		/**
		 * The NativeWindow used by this WindowedApplication component (the initial
		 *  native window of the application).
		 */
		public function get nativeWindow():NativeWindow;
		/**
		 * Specifies whether the window can be resized.
		 */
		public function get resizable():Boolean;
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
		 * Set of styles to pass from the WindowedApplication to the status bar.
		 */
		protected function get statusBarStyleFilters():Object;
		/**
		 * Specifies the type of system chrome (if any) the window has.
		 *  The set of possible values is defined by the constants
		 *  in the NativeWindowSystemChrome class.
		 */
		public function get systemChrome():String;
		/**
		 * The system tray icon menu. Some operating systems do not support system tray icon menus.
		 */
		public function get systemTrayIconMenu():FlexNativeMenu;
		public function set systemTrayIconMenu(value:FlexNativeMenu):void;
		/**
		 * The title that appears in the window title bar and
		 *  the taskbar.
		 *  If you are using system chrome and you set this property to something
		 *  different than the <title> tag in your application.xml,
		 *  you may see the title from the XML file appear briefly first.
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
		 * Set of styles to pass from the WindowedApplication to the titleBar.
		 */
		protected function get titleBarStyleFilters():Object;
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
		 * Constructor.
		 */
		public function WindowedApplication();
		/**
		 * Activates the underlying NativeWindow (even if this application is not the active one).
		 */
		public function activate():void;
		/**
		 * Closes the application's NativeWindow (the initial native window opened by the application). This action is cancelable.
		 */
		public function close():void;
		/**
		 * Closes the window and exits the application.
		 */
		public function exit():void;
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
		 * Orders the window just behind another. To order the window behind
		 *  a NativeWindow that does not implement IWindow, use this window's
		 *  NativeWindow's orderInBackOf() method.
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
		 *  window's NativeWindow's orderInFrontOf() method.
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
