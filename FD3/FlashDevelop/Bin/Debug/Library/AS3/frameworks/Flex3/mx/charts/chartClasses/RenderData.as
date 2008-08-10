/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public class RenderData {
		/**
		 * The bounds of all of the items a series displays on screen,
		 *  relative to the series's coordinate system.
		 *  This value is used by the various effects during rendering.
		 *  A series fills in this value when the effect
		 *  calls the getElementBounds() method.
		 *  A series does not need to fill in this field
		 *  unless specifically requested.
		 */
		public var bounds:Rectangle;
		/**
		 * The list of ChartItems representing the items
		 *  in the series's dataProvider.
		 */
		public var cache:Array;
		/**
		 * An Array of rectangles describing the bounds of the series's
		 *  ChartItems, relative to the series's coordinate system.
		 *  Effects use this Array
		 *  to generate the effect rendering.
		 *  An effect calls the getElementBounds() method, which
		 *  causes the series to fill in this value.
		 *  A series does not need to fill in this field
		 *  unless specifically requested.
		 *  Effects modify this Array to relect current positions
		 *  of the items during the effect duration.
		 *  If this value is filled in on the series's renderData,
		 *  the series renders itself based on these rectangles
		 *  rather than from the series's data.
		 */
		public var elementBounds:Array;
		/**
		 * The list of ChartItems representing the items
		 *  in the series's dataProvider that remain after filtering.
		 */
		public var filteredCache:Array;
		/**
		 * The number of items represented in this render data.
		 */
		public function get length():uint;
		/**
		 * The rectangle describing the possible coordinate range
		 *  that a series can display on screen.
		 *  This value is used by the various effects during rendering.
		 *  An effect calls the getElementBounds() method
		 *  to fill in this value.
		 *  A series does not need to fill in this field
		 *  unless specifically requested.
		 *  If left null, effects assume the visible region of an element
		 *  is the bounding box of the element itself (0, 0, width, height),
		 *  expressed relative to the element.
		 */
		public var visibleRegion:Rectangle;
		/**
		 * Constructor.
		 *
		 * @param cache             <Array (default = null)> The list of ChartItems representing the items
		 *                            in the series's dataProvider.
		 * @param filteredCache     <Array (default = null)> The list of ChartItems representing the items
		 *                            in the series's dataProvider that remain after filtering.
		 */
		public function RenderData(cache:Array = null, filteredCache:Array = null);
		/**
		 * Creates a copy of the render data. In the new copy, properties that point to other objects continue to
		 *  point to the same objects as the original.
		 */
		public function clone():RenderData;
	}
}
