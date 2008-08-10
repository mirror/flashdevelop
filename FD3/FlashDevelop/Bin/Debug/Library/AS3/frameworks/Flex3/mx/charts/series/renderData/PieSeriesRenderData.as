/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.renderData {
	import mx.charts.chartClasses.RenderData;
	public class PieSeriesRenderData extends RenderData {
		/**
		 * The total sum of the values represented in the pie series.
		 */
		public var itemSum:Number;
		/**
		 * A structure of data associated with the layout of the labels rendered by the pie series.
		 */
		public var labelData:Object;
		/**
		 * The scale factor of the labels rendered by the pie series.
		 */
		public var labelScale:Number;
		/**
		 * Constructor.
		 *
		 * @param cache             <Array (default = null)> The list of PieSeriesItem objects representing the items in the dataProvider.
		 * @param filteredCache     <Array (default = null)> The list of PieSeriesItem objects representing the items in the dataProvider that remain after filtering.
		 * @param labelScale        <Number (default = 1)> The scale factor of the labels rendered by the PieSeries.
		 * @param labelData         <Object (default = null)> A structure of data associated with the layout of the labels rendered by the PieSeries.
		 */
		public function PieSeriesRenderData(cache:Array = null, filteredCache:Array = null, labelScale:Number = 1, labelData:Object = null);
	}
}
