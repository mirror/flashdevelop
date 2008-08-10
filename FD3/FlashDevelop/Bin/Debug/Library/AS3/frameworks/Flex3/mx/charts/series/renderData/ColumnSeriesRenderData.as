/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.renderData {
	import mx.charts.chartClasses.RenderData;
	public class ColumnSeriesRenderData extends RenderData {
		/**
		 * A structure of data associated with the layout of the labels rendered by the column series.
		 */
		public var labelData:Object;
		/**
		 * The scale factor of the labels rendered by the column series.
		 */
		public var labelScale:Number;
		/**
		 * The vertical position of the base of the columns, in pixels.
		 */
		public var renderedBase:Number;
		/**
		 * Half the width of a column, in pixels.
		 */
		public var renderedHalfWidth:Number;
		/**
		 * The offset of each column from its x value, in pixels.
		 */
		public var renderedXOffset:Number;
		/**
		 * Constructor.
		 *
		 * @param cache             <Array (default = null)> The list of ColumnSeriesItem objects representing the items in the dataProvider.
		 * @param filteredCache     <Array (default = null)> The list of ColumnSeriesItem objects representing the items in the dataProvider that remain after filtering.
		 * @param renderedBase      <Number (default = 0)> The vertical position of the base of the columns, in pixels.
		 * @param renderedHalfWidth <Number (default = 0)> Half the width of a column, in pixels.
		 * @param renderedXOffset   <Number (default = 0)> The offset of each column from its x value, in pixels.
		 * @param labelScale        <Number (default = 1)> 
		 * @param labelData         <Object (default = null)> 
		 */
		public function ColumnSeriesRenderData(cache:Array = null, filteredCache:Array = null, renderedBase:Number = 0, renderedHalfWidth:Number = 0, renderedXOffset:Number = 0, labelScale:Number = 1, labelData:Object = null);
	}
}
