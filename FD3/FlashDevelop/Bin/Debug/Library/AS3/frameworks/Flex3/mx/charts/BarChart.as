/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.charts.chartClasses.CartesianChart;
	public class BarChart extends CartesianChart {
		/**
		 * The type of bar chart to render. Possible values are:
		 *  "clustered":
		 *  Bars are grouped by category.
		 *  This is the default value.
		 *  "overlaid":
		 *  Multiple bars are rendered on top of each other by category,
		 *  with the last series specified on top.
		 *  "stacked":
		 *  Bars are stacked end to end and grouped by category.
		 *  Each bar represents the cumulative value of the values beneath it.
		 *  "100%":
		 *  Bars are stacked end to end, adding up to 100%.
		 *  Each bar represents the percent that it contributes
		 *  to the sum of the values for that category.
		 */
		public function get type():String;
		public function set type(value:String):void;
		/**
		 * Constructor.
		 */
		public function BarChart();
	}
}
