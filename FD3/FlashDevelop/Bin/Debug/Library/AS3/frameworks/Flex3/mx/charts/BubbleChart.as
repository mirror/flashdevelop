/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.charts.chartClasses.CartesianChart;
	import mx.charts.chartClasses.IAxis;
	public class BubbleChart extends CartesianChart {
		/**
		 * The axis the bubble radius is mapped against
		 *  Bubble charts treat the size of the individual bubbles
		 *  as a third dimension of data which is transformed
		 *  in a similar manner to how x and y position is transformed.
		 *  By default, the radiusAxis is a LinearAxis
		 *  with the autoAdjust property set to false.
		 */
		public function get radiusAxis():IAxis;
		public function set radiusAxis(value:IAxis):void;
		/**
		 * Deprecated: Please Use series specific axis,  example:BubbleSeries.radiusAxis
		 */
		public function get secondRadiusAxis():IAxis;
		public function set secondRadiusAxis(value:IAxis):void;
		/**
		 * Constructor.
		 */
		public function BubbleChart();
	}
}
