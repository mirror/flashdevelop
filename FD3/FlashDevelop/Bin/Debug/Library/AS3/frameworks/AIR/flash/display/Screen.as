/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.display {
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	public final  class Screen extends EventDispatcher {
		/**
		 * The bounds of this screen.
		 */
		public function get bounds():Rectangle;
		/**
		 * The color depth of this screen (expressed in number of bits).
		 */
		public function get colorDepth():int;
		/**
		 * The primary display.
		 */
		public static function get mainScreen():Screen;
		/**
		 * The array of the currently available screens.
		 */
		public static function get screens():Array;
		/**
		 * The bounds of the area on this screen in which windows will be visible.
		 *  The visibleBounds of a screen excludes the taskbar
		 *  (and other docked deskbars) on Windows, and excludes the
		 *  menu bar and, depending on system settings, the dock on Mac OS X.
		 */
		public function get visibleBounds():Rectangle;
		/**
		 * Returns the (possibly empty) set of screens that intersect
		 *  the provided rectangle.
		 *
		 * @param rect              <Rectangle> A rectangle with coordinates relative to the origin of
		 *                            the virtual desktop, which is the top-left corner of the primary
		 *                            screen.
		 * @return                  <Array> An array of Screen objects containing the screens that contain any
		 *                            part of the area defined by the rect parameter.
		 */
		public static function getScreensForRectangle(rect:Rectangle):Array;
	}
}
