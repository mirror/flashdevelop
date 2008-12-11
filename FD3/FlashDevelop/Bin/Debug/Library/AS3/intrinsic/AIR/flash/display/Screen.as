package flash.display
{
	/// The Screen class provides information about the display screens available to this application.
	public class Screen extends flash.events.EventDispatcher
	{
		/// [AIR] The array of the currently available screens.
		public var screens:Array;

		/// [AIR] The primary display.
		public var mainScreen:flash.display.Screen;

		/// [AIR] The bounds of this screen.
		public var bounds:flash.geom.Rectangle;

		/// [AIR] The bounds of the area on this screen in which windows will be visible.
		public var visibleBounds:flash.geom.Rectangle;

		/// [AIR] The color depth of this screen (expressed in number of bits).
		public var colorDepth:int;

		/// [AIR] Returns the (possibly empty) set of screens that intersect the provided rectangle.
		public static function getScreensForRectangle(rect:flash.geom.Rectangle):Array;

	}

}

