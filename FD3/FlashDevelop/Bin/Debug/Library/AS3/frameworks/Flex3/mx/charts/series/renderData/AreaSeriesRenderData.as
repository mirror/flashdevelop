/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.renderData {
	import mx.charts.chartClasses.RenderData;
	import mx.charts.series.AreaSeries;
	public class AreaSeriesRenderData extends RenderData {
		/**
		 * The AreaSeries that this structure is associated with.
		 */
		public var element:AreaSeries;
		/**
		 * The radius of the items of the AreaSeries.
		 */
		public var radius:Number;
		/**
		 * The vertical position of the base of the area series, in pixels.
		 */
		public var renderedBase:Number;
		/**
		 * Constructor.
		 *
		 * @param element           <AreaSeries> The AreaSeries object that this structure is associated with.
		 * @param cache             <Array (default = null)> The list of AreaSeriesItem objects representing the items in the dataProvider.
		 * @param filteredCache     <Array (default = null)> The list of AreaSeriesItem objects representing the items in the dataProvider that remain after filtering.
		 * @param renderedBase      <Number (default = 0)> The vertical position of the base of the area series, in pixels.
		 * @param radius            <Number (default = 0)> 
		 */
		public function AreaSeriesRenderData(element:AreaSeries, cache:Array = null, filteredCache:Array = null, renderedBase:Number = 0, radius:Number = 0);
	}
}
