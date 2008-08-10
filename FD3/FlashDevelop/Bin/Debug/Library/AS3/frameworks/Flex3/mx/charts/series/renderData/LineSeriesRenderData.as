/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.renderData {
	import mx.charts.chartClasses.RenderData;
	public class LineSeriesRenderData extends RenderData {
		/**
		 * The radius of the individual items in the line series.
		 */
		public var radius:Number;
		/**
		 * An Array of LineSeriesSegment instances representing each discontiguous segment of the line series.
		 */
		public var segments:Array;
		/**
		 * The number of points in the cache that were not filtered out by the axes.
		 */
		public var validPoints:Number;
		/**
		 * Constructor.
		 *
		 * @param cache             <Array (default = null)> The list of LineSeriesItem objects representing the items in the dataProvider.
		 * @param filteredCache     <Array (default = null)> The list of LineSeriesItem objects representing the items in the dataProvider that remain after filtering.
		 * @param validPoints       <Number (default = 0)> The number of points in the cache that are valid.
		 * @param segments          <Array (default = null)> An Array of LineSeriesSegment objects representing each discontiguous segment of the LineSeries.
		 * @param radius            <Number (default = 0)> The radius of the individual items in the LineSeries.
		 */
		public function LineSeriesRenderData(cache:Array = null, filteredCache:Array = null, validPoints:Number = 0, segments:Array = null, radius:Number = 0);
	}
}
