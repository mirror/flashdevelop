/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.html {
	public class HTMLWindowCreateOptions {
		/**
		 * Specifies whether the window should be full screen. This property is set to true if the
		 *  features string of the JavaScript call to the window.open()
		 *  method includes "fullscreen", "fullscreen=1", or
		 *  "fullscreen=y".
		 */
		public var fullscreen:Boolean = false;
		/**
		 * Specifies the desired initial height of the new window. This is set to the height value
		 *  in the features string of the JavaScript call to the window.open()
		 *  method. If the value is NaN, the default when no height value is
		 *  specified in the features string, then a default window height is used.
		 */
		public var height:Number = NaN;
		/**
		 * Whether a location bar should be displayed. This property is set to true if the
		 *  features string of the JavaScript call to the window.open()
		 *  method includes "location", "location=1", or "location=y".
		 */
		public var locationBarVisible:Boolean = false;
		/**
		 * Specifies whether a menu bar should be displayed. This property is set to true if the
		 *  features string of the JavaScript call to the window.open()
		 *  method includes "menubar", "menubar=1", or
		 *  "menubar=y".
		 */
		public var menuBarVisible:Boolean = false;
		/**
		 * Specifies whether the window should be resizable. This property is set to true if the
		 *  features string of the JavaScript call to the window.open()
		 *  method includes "resizable", "resizable=1", or
		 *  "resizable=y".
		 */
		public var resizable:Boolean = false;
		/**
		 * Specifies whether scrollbars should be displayed. This property is set to true if the
		 *  features string of JavaScript call to the window.open()
		 *  method includes "scrollbars", "scrollbars=1", or
		 *  "scrollbars=y".
		 */
		public var scrollBarsVisible:Boolean = true;
		/**
		 * Specifies whether a status bar should be displayed. This property is set to true if the
		 *  features string of the JavaScript call to the window.open()
		 *  method includes "status", "status=1", or "status=y".
		 */
		public var statusBarVisible:Boolean = false;
		/**
		 * Specifies whether a toolbar bar should be displayed. This property is set to true if the
		 *  features string of the JavaScript call to the window.open()
		 *  method includes "toolbar", "toolbar=1", or "toolbar=y".
		 */
		public var toolBarVisible:Boolean = false;
		/**
		 * Specifies the desired initial width of the new window. This is set to the width value
		 *  in the features string of the JavaScript call to the window.open()
		 *  method. If the value is NaN, the default when no width value is
		 *  specified in the features string, then a default window width is used.
		 */
		public var width:Number = NaN;
		/**
		 * Specifies the desired initial x position of the new window on the screen. This is set to the
		 *  value specified for left or screenX in the features
		 *  string of the JavaScript call to the window.open() method. If the value
		 *  is NaN, the default when no left or screenX value is
		 *  specified in the features string, then a default window x position is used.
		 */
		public var x:Number = NaN;
		/**
		 * Specifies the desired initial y position of the new window on the screen. This is set to the
		 *  value specified for top or screenY in the features
		 *  string of the JavaScript call to the window.open() method. If the value is
		 *  NaN, the default when no left or screenX value is specified
		 *  in the features string, then a default window x position is used.
		 */
		public var y:Number = NaN;
	}
}
