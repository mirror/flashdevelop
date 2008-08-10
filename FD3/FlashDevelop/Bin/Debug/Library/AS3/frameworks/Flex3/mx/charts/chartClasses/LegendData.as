/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public class LegendData {
		/**
		 * Determines
		 *  the size and placement of the legend marker.
		 *  If set, the LegendItem ensures that the marker's
		 *  width and height match this value.
		 *  If unset (NaN), the legend item chooses an appropriate
		 *  default width and height.
		 */
		public var aspectRatio:Number;
		/**
		 * The chart item that generated this legend item.
		 */
		public var element:IChartElement;
		/**
		 * The text identifying the series or item displayed in the legend item.
		 */
		public var label:String = "";
		/**
		 * A visual indicator associating the legend item
		 *  with the series or item being represented.
		 *  This DisplayObject is added as a child to the LegendItem.
		 */
		public var marker:IFlexDisplayObject;
		/**
		 * Constructor.
		 */
		public function LegendData();
	}
}
