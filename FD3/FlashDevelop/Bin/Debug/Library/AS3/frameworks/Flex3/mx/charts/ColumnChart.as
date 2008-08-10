/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.charts.chartClasses.CartesianChart;
	public class ColumnChart extends CartesianChart {
		/**
		 * Determines whether or not data labels can extend to the end of the chart.
		 *  If you set this to true, labels can use the whole space between the item
		 *  and the boundary of the chart to show its label. Otherwise, data labels are
		 *  restricted to the area defined by their chart item.
		 */
		public function get extendLabelToEnd():Boolean;
		public function set extendLabelToEnd(value:Boolean):void;
		/**
		 * Determines maximum width in pixels of label of items.
		 */
		public function get maxLabelWidth():int;
		public function set maxLabelWidth(value:int):void;
		/**
		 * Determines whether or not the data labels can be shown vertically.
		 *  If you set this to true and if embedded fonts are used, labels will be shown vertically
		 *  if they cannot be fit horizontally within the column width.
		 */
		public function get showLabelVertically():Boolean;
		public function set showLabelVertically(value:Boolean):void;
		/**
		 * The type of the column chart.
		 */
		public function get type():String;
		public function set type(value:String):void;
		/**
		 * Constructor.
		 */
		public function ColumnChart();
	}
}
