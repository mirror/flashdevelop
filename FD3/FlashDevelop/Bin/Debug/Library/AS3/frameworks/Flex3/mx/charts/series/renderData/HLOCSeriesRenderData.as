/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.renderData {
	import mx.charts.chartClasses.RenderData;
	public class HLOCSeriesRenderData extends RenderData {
		/**
		 * Half the width of an item, in pixels.
		 */
		public var renderedHalfWidth:Number;
		/**
		 * The offset of each item from its x value, in pixels.
		 */
		public var renderedXOffset:Number;
		/**
		 * Constructor.
		 *
		 * @param cache             <Array (default = null)> The list of HLOCSeriesItem objects representing the items in the data provider.
		 * @param filteredCache     <Array (default = null)> The list of HLOCSeriesItem objects representing the items in the data provider that remain after filtering.
		 * @param renderedHalfWidth <Number (default = 0)> Half the width of an item, in pixels.
		 * @param renderedXOffset   <Number (default = 0)> The offset of each item from its x value, in pixels.
		 */
		public function HLOCSeriesRenderData(cache:Array = null, filteredCache:Array = null, renderedHalfWidth:Number = 0, renderedXOffset:Number = 0);
	}
}
